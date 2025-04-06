import 'dart:io';

import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';

import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:htmltopdfwidgets/htmltopdfwidgets.dart' as htmltopdf;
import 'package:path_provider/path_provider.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:universal_html/html.dart' as html;

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
  <title> <strong>AUTORIZAÇÃO PARA OCUPAÇÃO DE UNIDADE - BLOCO SUVA (STUDIO)</strong> </title>
</head>
<body style="font-family: Arial, sans-serif;">

  <h2 style="text-align: center;">Autorização para Ocupação</h2>
  <p>
    Eu, <strong>${widget.name1}</strong>,  proprietário da unidade no.: <strong>48C  Bloco Suva (STUDIO)</strong>, AUTORIZO as 
pessoas abaixo relacionadas, a ocupar meu apartamento no período de :
    <strong>${widget.checkIn}</strong> a <strong>${widget.checkOut}</strong>.
  </p>

  <br><strong>Nomes / Documentos</strong>
  <table border="1" style="width: 100%; border-collapse: collapse;">
    <tr>
      <th style="padding: 8px;">Nome</th>
      <th style="padding: 8px;">Documento</th>
    </tr>
    <tr>
      <td style="padding: 8px;">${widget.name2}</td>
      <td style="padding: 8px;">RG 41.105.912/9</td>
    </tr>
    <tr>
      <td style="padding: 8px;">${widget.name3}</td>
      <td style="padding: 8px;">RG 45.749.576/5</td>
    </tr>
    <tr>
      <td style="padding: 8px;">${widget.name4}</td>
      <td style="padding: 8px;">CPF 573.216.898-24</td>
    </tr>
  </table>

  <br><strong>Veículo: Marca / Modelo / Placa</strong>
  <table border="1" style="width: 100%; border-collapse: collapse;">
    <tr>
      <th style="padding: 8px;">Marca / Modelo</th>
      <th style="padding: 8px;">Cor</th>
      <th style="padding: 8px;">Placa</th>
    </tr>
    <tr>
      <td style="padding: 8px;">${widget.carModel}</td>
      <td style="padding: 8px;">Prata</td>
      <td style="padding: 8px;">QMT 5E79</td>
    </tr>
  </table>

  <br><p>
    Os ocupantes têm total conhecimento e estão de acordo com as normas do Regulamento Interno e Convenção do Condomínio Residencial Fiji.
  </p>
  <p><strong>Data:</strong> ${widget.checkIn}</p>
  <p style="text-align: center; margin-top: 50px;">
    ___________________________<br>
    Assinatura do proprietário
  </p>

  <h3 style="text-align: center;">Manual do Locatário</h3>
  <ul>
    <li>PROIBIDO PENDURAR TOALHAS/ROUPAS NO PARAPEITO DAS VARANDAS;</li>
    <li>PROIBIDO BEBIDAS E COMIDAS NO ENTORNO E DENTRO DA PISCINA;</li>
    <li>PROIBIDO CRIANÇAS MENORES DE 12 ANOS DESACOMPANHADAS DOS PAIS OU RESPONSÁVEIS NA ÁREA DA PISCINA;</li>
    <li>OBRIGATÓRIO O USO DA DUCHA ANTES DE ENTRAR NA PISCINA;</li>
    <li>PROIBIDO SOM ALTO E BARULHOS QUE INCOMODEM OS OUTROS CONDÔMINOS, INDEPENDENTE DO HORÁRIO;</li>
    <li>NÃO É PERMITIDO DEIXAR PRANCHAS, BOLAS, COOLER, CADEIRAS OU OUTROS OBJETOS NAS ÁREAS SOCIAIS DO CONDOMÍNIO;</li>
    <li>PROIBIDO SUBIR MOLHADO PELOS ELEVADORES;</li>
    <li>NÃO É PERMITIDO A INQUILINOS/CESSIONÁRIOS TEMPORÁRIOS TRAZER E RECEBER VISITANTES NAS ÁREAS COMUNS.</li>
  </ul>

</body>
</html>

    ''';

      print('HTML to be converted: $body'); // Debug log

      final pdf = pw.Document();
      final widgets = await htmltopdf.HTMLToPdf().convert(body);
      print('HTML converted to PDF widgets successfully.');

      pdf.addPage(pw.MultiPage(build: (context) => widgets));

      if (kIsWeb) {
        final pdfBytes = await pdf.save();
        final blob = html.Blob([pdfBytes], 'application/pdf');
        final url = html.Url.createObjectUrlFromBlob(blob);
        html.window.open(url, '_blank');
        html.Url.revokeObjectUrl(url);
        print('PDF saved successfully for web.');
      } else {
        final output = await getTemporaryDirectory();
        final file = File('${output.path}/example.pdf');
        await file.writeAsBytes(await pdf.save());
        print('PDF saved successfully at ${file.path}');

        setState(() {
          pdfPath = file.path;
        });
      }
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
