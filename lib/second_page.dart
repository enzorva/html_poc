import 'dart:io';

import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as htmltopdf;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:pdf/widgets.dart' as pdf_widgets;

class SecondPage extends StatefulWidget {
  final String name1;
  final String name2;
  final String name3;
  final String name4;
  final String checkIn;
  final String checkOut;
  final String carModel;

  const SecondPage({
    super.key,
    required this.name1,
    required this.name2,
    required this.name3,
    required this.name4,
    required this.checkIn,
    required this.checkOut,
    required this.carModel,
  });

  @override
  State<SecondPage> createState() => _SecondPageState();
}

class _SecondPageState extends State<SecondPage> {
  String? pdfPath;

  @override
  void initState() {
    super.initState();
    _generatePdf();
  }

  Future<void> _generatePdf() async {
    try {
      final String body = '''
    <!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Autorização de Ocupação</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 40px;
            line-height: 1.6;
        }
        h1, h2 {
            text-align: center;
        }
        .signature {
            margin-top: 40px;
            text-align: center;
        }
    </style>
</head>
<body>
    <h1>AUTORIZAÇÃO PARA OCUPAÇÃO</h1>
    <p>Eu autorizo as seguintes pessoas a ocupar o apartamento:</p>
    <ul>
        <li>${widget.name1}</li>
        <li>${widget.name2}</li>
        <li>${widget.name3}</li>
        <li>${widget.name4}</li>
    </ul>
    <p><strong>Período:</strong> ${widget.checkIn} a ${widget.checkOut}</p>
    <p><strong>Carro:</strong> ${widget.carModel}</p>
</body>
</html>
    ''';

      final output = await getTemporaryDirectory();
      final file = File('${output.path}/example.pdf');

      final pdf = pdf_widgets.Document();
      final widgets = await htmltopdf.HTMLToPdf().convert(body);
      pdf.addPage(pw.MultiPage(build: (context) => widgets));

      await file.writeAsBytes(await pdf.save());

      setState(() {
        pdfPath = file.path;
      });
    } catch (e) {
      print('Error generating PDF: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Second Page')),
      body:
          pdfPath == null
              ? const Center(child: CircularProgressIndicator())
              : Column(
                children: [
                  Expanded(
                    child: PDFView(
                      filePath: pdfPath,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: false,
                      pageFling: false,
                      pageSnap: false,
                      fitPolicy: FitPolicy.BOTH,
                      preventLinkNavigation: true, // very important
                      onRender: (pages) {
                        print("PDF rendered with $pages pages.");
                      },
                      onError: (error) {
                        print('Error rendering PDF: $error');
                      },
                      onPageError: (page, error) {
                        print('Error on page $page: $error');
                      },
                      onViewCreated: (PDFViewController controller) {
                        // You can save the controller for later use
                      },
                    ),
                  ),
                ],
              ),
    );
  }
}
