import 'package:flutter/material.dart';
import 'dart:io';
import 'package:document_scanner/document_scanner.dart';

class DocScanApp2 extends StatefulWidget {
  const DocScanApp2({Key? key}) : super(key: key);

  @override
  State<DocScanApp2> createState() => _DocScanApp2State();
}

class _DocScanApp2State extends State<DocScanApp2> {
  File? scannedDocument;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: MaterialButton(
      onPressed: () {},
      child: DocumentScanner(
        onDocumentScanned: (ScannedImage scannedImage) {
          //print("document : " + scannedImage.croppedImage);
          scannedDocument = scannedImage.getScannedDocumentAsFile();
        },
      ),
    ));
  }
}
