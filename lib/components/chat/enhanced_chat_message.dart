import 'package:flutter/material.dart';
import 'package:flutter_chat_types/flutter_chat_types.dart' as types;
import 'package:url_launcher/url_launcher.dart';

class EnhancedChatMessage extends StatelessWidget {
  final types.TextMessage message;

  const EnhancedChatMessage({
    super.key,
    required this.message,
  });

  // Regular expressions for detecting different types of content
  static final RegExp phoneRegex = RegExp(r'\b\d{3}-\d{3}-\d{4}\b');
  static final RegExp urlRegex = RegExp(r'https://\S+');
  static final RegExp emailRegex = RegExp(r'\b[\w\.-]+@[\w\.-]+\.\w+\b');
  // static final RegExp addressRegex = RegExp(
  //   r'\b\d+\s+[A-Za-z0-9\s\'".,]+(?:Suite|Ste|STE|#)\s*[A-Za-z0-9\s,.\']+California\s+\d{5}\b'
  // );

  // Launch phone dialer
  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(
      scheme: 'tel',
      path: phoneNumber.replaceAll('-', ''),
    );
    if (await canLaunchUrl(phoneUri)) {
      await launchUrl(phoneUri);
    }
  }

  // Launch maps
  Future<void> _launchMaps(String address) async {
    final Uri mapsUri = Uri(
      scheme: 'https',
      host: 'maps.google.com',
      queryParameters: {'q': address},
    );
    if (await canLaunchUrl(mapsUri)) {
      await launchUrl(mapsUri);
    }
  }

  // Launch URL
  Future<void> _launchUrl(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(Uri.parse(url));
    }
  }

  // Launch email
  Future<void> _launchEmail(String email) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: email,
    );
    if (await canLaunchUrl(emailUri)) {
      await launchUrl(emailUri);
    }
  }

  // Build interactive element
  Widget _buildInteractiveElement(String text, VoidCallback onTap, IconData icon) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 4),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.blue.withOpacity(0.1),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.blue.withOpacity(0.3)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 16, color: Colors.blue),
            const SizedBox(width: 8),
            Flexible(
              child: Text(
                text,
                style: const TextStyle(
                  color: Colors.blue,
                  decoration: TextDecoration.underline,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<InlineSpan> _processText(String text) {
    List<InlineSpan> spans = [];
    int currentPosition = 0;

    // Helper function to add regular text
    void addTextUpTo(int endPosition) {
      if (endPosition > currentPosition) {
        spans.add(TextSpan(
          text: text.substring(currentPosition, endPosition),
        ));
      }
    }

    // Process all matches
    void processMatches(RegExp regex, Widget Function(String) builder) {
      for (Match match in regex.allMatches(text)) {
        // Add text before the match
        addTextUpTo(match.start);

        // Add the widget for the match
        spans.add(WidgetSpan(
          child: builder(match.group(0)!),
        ));

        currentPosition = match.end;
      }
    }

    // Process phone numbers
    processMatches(
      phoneRegex,
      (phone) => _buildInteractiveElement(
        phone,
        () => _launchPhone(phone),
        Icons.phone,
      ),
    );

    // Process URLs
    processMatches(
      urlRegex,
      (url) => _buildInteractiveElement(
        url,
        () => _launchUrl(url),
        Icons.link,
      ),
    );

    // Process email addresses
    processMatches(
      emailRegex,
      (email) => _buildInteractiveElement(
        email,
        () => _launchEmail(email),
        Icons.email,
      ),
    );

    // Process addresses
    // processMatches(
    //   addressRegex,
    //   (address) => _buildInteractiveElement(
    //     address,
    //     () => _launchMaps(address),
    //     Icons.location_on,
    //   ),
    // );

    // Add any remaining text
    addTextUpTo(text.length);

    return spans;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4),
      child: RichText(
        text: TextSpan(
          style: DefaultTextStyle.of(context).style,
          children: _processText(message.text),
        ),
      ),
    );
  }
}