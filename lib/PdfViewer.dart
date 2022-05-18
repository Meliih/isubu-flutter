import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_pdfviewer/pdfviewer.dart';
class PdfViewer extends StatefulWidget {
  final String path;
  const PdfViewer({ Key? key, required this.path }) : super(key: key);

  @override
  State<PdfViewer> createState() => _PdfViewerState();
}

class _PdfViewerState extends State<PdfViewer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SafeArea(child: Scaffold(
        body: SfPdfViewer.network(widget.path),
      )),);
  }
}