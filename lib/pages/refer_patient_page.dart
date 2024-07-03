import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class ReferPage extends StatefulWidget {
  const ReferPage({Key? key}) : super(key: key);

  @override
  _ReferPageState createState() => _ReferPageState();
}

class _ReferPageState extends State<ReferPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfDocument _document;
  bool _isDocumentLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final response = await http.get(Uri.parse(
        'https://www.thenephrologygroupinc.com/Portals/0/Online%20Forms/Forms%202-12-2018/NewPatientRF.pdf'));
    if (response.statusCode == 200) {
      _document = PdfDocument(inputBytes: response.bodyBytes);
      setState(() {
        _isDocumentLoaded = true;
      });
    } else {
      throw Exception('Failed to load PDF');
    }
  }

  Future<void> _savePdf() async {
    // Check and request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }

    if (status.isGranted) {
      // Get the Downloads directory path
      final directory = Directory('/storage/emulated/0/Download');

      if (directory.existsSync()) {
        final path = directory.path;
        final file = File('$path/FilledNewPatientRF.pdf');
        await file.writeAsBytes(_document.saveSync());
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('PDF saved to ${file.path}')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to get storage directory')),
        );
      }
    } else if (status.isPermanentlyDenied) {
      // The permission has been permanently denied, open app settings
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text(
              'Storage permission permanently denied, please enable it from settings.'),
          action: SnackBarAction(
            label: 'Settings',
            onPressed: () {
              openAppSettings();
            },
          ),
        ),
      );
    }
    else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Storage permission denied')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: bgColor,
        elevation: 0,
        leading: const BackButton(
          color: Colors.black,
        ),
        title: const Text(
          "Refer a Patient",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(
              Icons.bookmark,
              color: Colors.white,
              semanticLabel: 'Bookmark',
            ),
            onPressed: () {
              _pdfViewerKey.currentState?.openBookmarkView();
            },
          ),
        ],
      ),
      body: _isDocumentLoaded
          ? SfPdfViewer.memory(
              Uint8List.fromList(_document.saveSync()),
              key: _pdfViewerKey,
            )
          : const Center(child: CircularProgressIndicator()),
      floatingActionButton: FloatingActionButton(
        onPressed: _savePdf,
        child: const Icon(Icons.download),
      ),
    );
  }
}
