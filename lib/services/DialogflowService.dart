import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/services.dart' show rootBundle;
import 'package:dart_jsonwebtoken/dart_jsonwebtoken.dart';

class DialogflowService {
  static final DialogflowService _singleton = DialogflowService._internal();
  factory DialogflowService() {
    return _singleton;
  }
  DialogflowService._internal();

  final String _projectId = 'cool-agility-435923-i7';
  final String _location = 'global';
  final String _agentId = '310802b5-320a-421b-9110-3632e3f9d1e4';
  final String _environmentId = 'cc60f52c-ac17-4c5e-b3c3-781d765441ac';

  String? _accessToken;
  DateTime? _tokenExpiryTime;

  String encodeJWT(Map<String, dynamic> header, Map<String, dynamic> claims, String privateKey) {
    final key = RSAPrivateKey(privateKey);
    
    final jwt = JWT(
      claims,
      header: header,
    );

    return jwt.sign(key, algorithm: JWTAlgorithm.RS256);
  }

  Future<String> _getAccessToken() async {
    if (_accessToken != null && _tokenExpiryTime != null && DateTime.now().isBefore(_tokenExpiryTime!)) {
      return _accessToken!;
    }

    final serviceAccountJson = await rootBundle.loadString('assets/credentials.json');
    final serviceAccount = json.decode(serviceAccountJson);

    final now = DateTime.now();
    final expiry = now.add(const Duration(hours: 1));

    final claims = {
      "iss": serviceAccount["client_email"],
      "scope": "https://www.googleapis.com/auth/dialogflow",
      "aud": "https://oauth2.googleapis.com/token",
      "exp": expiry.millisecondsSinceEpoch ~/ 1000,
      "iat": now.millisecondsSinceEpoch ~/ 1000,
    };

    final header = {
      "alg": "RS256",
      "typ": "JWT",
      "kid": serviceAccount["private_key_id"]
    };

    final key = serviceAccount["private_key"];
    
    final jwt = encodeJWT(header, claims, key);

    final response = await http.post(
      Uri.parse('https://oauth2.googleapis.com/token'),
      body: {
        'grant_type': 'urn:ietf:params:oauth:grant-type:jwt-bearer',
        'assertion': jwt,
      },
    );

    if (response.statusCode == 200) {
      final tokenData = json.decode(response.body);
      _accessToken = tokenData['access_token'];
      _tokenExpiryTime = DateTime.now().add(Duration(seconds: tokenData['expires_in']));
      return _accessToken!;
    } else {
      throw Exception('Failed to get access token: ${response.body}');
    }
  }

  Future<String> sendMessageToDialogflow(String message, String sessionId) async {
    final accessToken = await _getAccessToken();
    final response = await http.post(
      Uri.parse('https://dialogflow.googleapis.com/v3/projects/$_projectId/locations/$_location/agents/$_agentId/environments/$_environmentId/sessions/$sessionId:detectIntent'),
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'queryInput': {
          'text': {
            'text': message,
          },
          'languageCode': 'en',
        },
      }),
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      return jsonResponse['queryResult']['responseMessages'][0]['text']['text'][0];
    } else {
      throw Exception('Failed to get response from Dialogflow: ${response.body}');
    }
  }
}