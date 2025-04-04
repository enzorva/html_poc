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
    <title>Autorização de Ocupação - Bloco Suva (Studio)</title>
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
        .rules {
            margin-top: 30px;
            border-top: 2px solid #000;
            padding-top: 20px;
        }
    </style>
</head>
<body>

    <h1>AUTORIZAÇÃO PARA OCUPAÇÃO DE UNIDADE – BLOCO SUVA (STUDIO)</h1>

    <p>Eu, <strong>Eryk Azevedo</strong>, proprietário da unidade no.: <strong>48C Bloco Suva (STUDIO)</strong>, 
    AUTORIZO as pessoas abaixo relacionadas a ocupar meu apartamento no período de: 
    <strong>${widget.checkIn} a ${widget.checkOut}</strong>.</p>

    <h2>Ocupantes</h2>
    <ul>
        <li>${widget.name1}</li>
        <li>${widget.name2}</li>
        <li>${widget.name3}</li>
        <li>${widget.name4}</li>
    </ul>

    <h2>Veículo</h2>
    <p><strong>Marca/Modelo:</strong> ${widget.carModel}</p>

    <p>Os ocupantes têm total conhecimento e estão de acordo com as normas do Regulamento Interno e Convenção do Condomínio Residencial Fiji.</p>

    <div class="signature">
        <p>Data: <strong>${widget.checkIn}</strong></p>
        <p>___________________________</p>
        <p>Assinatura do proprietário</p>
    </div>

    <div class="rules">
        <h2>MANUAL DO LOCATÁRIO</h2>
        <ul>
            <li>PROIBIDO pendurar toalhas ou roupas no parapeito das varandas.</li>
            <li>PROIBIDO bebidas e comidas no entorno e dentro da piscina.</li>
            <li>PROIBIDO crianças menores de 12 anos desacompanhadas dos pais ou responsáveis na área da piscina.</li>
            <li>OBRIGATÓRIO o uso da ducha antes de entrar na piscina.</li>
            <li>PROIBIDO som alto e barulhos que incomodem os outros condôminos, independente do horário.</li>
            <li>NÃO É PERMITIDO deixar pranchas, bolas, cooler, cadeiras ou quaisquer outros objetos nas áreas sociais do condomínio.</li>
            <li>PROIBIDO subir molhado pelos elevadores.</li>
            <li>NÃO É PERMITIDO a inquilinos/cessionários temporários trazer e receber visitantes nas áreas comuns.</li>
        </ul>
    </div>

</body>
</html>
    ''';

      final output = await getTemporaryDirectory();
      print('Temporary directory: ${output.path}');
      final file = File('${output.path}/example.pdf');

      final pdf = pdf_widgets.Document();
      final widgets = await htmltopdf.HTMLToPdf().convert(body);
      print('HTML converted to PDF widgets successfully.');

      pdf.addPage(pw.MultiPage(build: (context) => widgets));
      await file.writeAsBytes(await pdf.save());
      print('PDF saved successfully at ${file.path}');

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
