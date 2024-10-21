import 'package:flutter/material.dart';
import 'package:nephrology_app/shared/color.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
import 'package:syncfusion_flutter_pdf/pdf.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:typed_data';
import 'package:permission_handler/permission_handler.dart';

class LoadPdfPage extends StatefulWidget {
  final String url;
  final String title;
  const LoadPdfPage({super.key, required this.url, required this.title});

  @override
  _LoadPdfPageState createState() => _LoadPdfPageState();
}

class _LoadPdfPageState extends State<LoadPdfPage> {
  final GlobalKey<SfPdfViewerState> _pdfViewerKey = GlobalKey();
  late PdfDocument _document;
  bool _isDocumentLoaded = false;

  @override
  void initState() {
    super.initState();
    _loadPdf();
  }

  Future<void> _loadPdf() async {
    final response = await http.get(Uri.parse(widget.url));
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
        final filename = "Filled${widget.title.replaceAll(' ', '_')}";
        final file = File('$path/$filename.pdf');
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
        backgroundColor: primaryColor,
        elevation: 0,
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Padding(
            padding: EdgeInsets.all(8.0),
            child: Icon(
              Icons.arrow_back_ios_new_rounded,
              color: Colors.white,
            ),
          ),
        ),
        title: Text(
          widget.title,
          style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(20),
            bottomRight: Radius.circular(20),
          ),
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
