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
      final pdf = pw.Document();

      pdf.addPage(
        pw.Page(
          build: (context) => pw.Column(
            children: [
              pw.Text('Autorização para Ocupação', style: pw.TextStyle(fontSize: 18, fontWeight: pw.FontWeight.bold)),e>Autorização de Ocupação - Fiji 48C</title>
              pw.SizedBox(height: 20),
              pw.Text('Eu, Eryk Azevedo, autorizo as pessoas abaixo a ocupar meu apartamento no período de:'),
              pw.SizedBox(height: 20),
              pw.Table.fromTextArray(argin-top: 20px;">
                headers: ['Nome', 'Documento'],ad>tyle="text-align: center; margin-bottom: 20px;">
                data: [
                  ['Paulo Rodrigues', 'RG 41.105.912/9'],lor: #f2f2f2;">Nome</th>
                  ['Alessandra Silva', 'RG 45.749.576/5'],th style="border: 1px solid #000; padding: 8px; background-color: #f2f2f2;">Documento</th>
                ],tr>yle="text-align: center; text-transform: uppercase;">Autorização para Ocupação de Unidade - Bloco Suva (Studio)</h2>
                border: pw.TableBorder.all(),
                headerStyle: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                cellAlignment: pw.Alignment.centerLeft,>strong>Eryk Azevedo</strong>, proprietário da unidade no.: <strong>48C Bloco Suva (STUDIO)</strong>,
                headerDecoration: pw.BoxDecoration(color: PdfColors.grey300),<td style="border: 1px solid #000; padding: 8px;">Paulo Rodrigues</td>ong>AUTORIZO</strong> as pessoas abaixo relacionadas a ocupar meu apartamento no período de:
              ),>
            ],
          ),>
        ),d style="border: 1px solid #000; padding: 8px;">Alessandra Silva</td>le="margin-top: 30px;">
      ); <td style="border: 1px solid #000; padding: 8px;">RG 45.749.576/5</td>rong>Nomes / Documentos</strong>
/tr>ble style="width: 100%; border: 1px solid #000; border-collapse: collapse; margin-top: 15px;">
      if (kIsWeb) {ody>head>
        final pdfBytes = await pdf.save();  </table>        <tr>
        final blob = html.Blob([pdfBytes], 'application/pdf');>Nome</th>
        final url = html.Url.createObjectUrlFromBlob(blob);</html>          <th style="border: 1px solid #000; padding: 10px; text-align: left; background-color: #f2f2f2;">Documento</th>
        html.window.open(url, '_blank');
        html.Url.revokeObjectUrl(url);
        print('PDF saved successfully for web.');
      } else {        <tr>
        final output = await getTemporaryDirectory();gues Ferrage Junior</td>
        final file = File('${output.path}/example.pdf');      final widgets = await htmltopdf.HTMLToPdf().convert(body);          <td style="border: 1px solid #000; padding: 10px; text-align: left;">RG 41.105.912/9</td>
        await file.writeAsBytes(await pdf.save());onverted to PDF widgets successfully.'); // Debug log
        print('PDF saved successfully at ${file.path}');
t-align: left;">Alessandra Silva Ferrage</td>
        setState(() {
          pdfPath = file.path;
        });e();
      }cation/pdf');ing: 10px; text-align: left;">Isabela</td>
    } catch (e) {url = html.Url.createObjectUrlFromBlob(blob);style="border: 1px solid #000; padding: 10px; text-align: left;">CPF 573.216.898-24</td>
      print('Error generating PDF: $e');
    }
  }

  @override        final output = await getTemporaryDirectory();
  Widget build(BuildContext context) {File('${output.path}/example.pdf');top: 30px;">
    return Scaffold(s(await pdf.save());odelo / Placa</strong>
      appBar: AppBar(title: const Text('Second Page')),nt('PDF saved successfully at ${file.path}');style="width: 100%; border: 1px solid #000; border-collapse: collapse; margin-top: 15px;">
      body:
          pdfPath == null() {
              ? const Center(child: CircularProgressIndicator())ng: 10px; text-align: left; background-color: #f2f2f2;">Marca / Modelo</th>
              : Column(   });     <th style="border: 1px solid #000; padding: 10px; text-align: left; background-color: #f2f2f2;">Cor</th>
                children: [   }       <th style="border: 1px solid #000; padding: 10px; text-align: left; background-color: #f2f2f2;">Placa</th>
                  Expanded(    } catch (e) {        </tr>
                    child: PDFView(('Error generating PDF: $e');ad>
                      filePath: pdfPath,
                      enableSwipe: true,
                      swipeHorizontal: false,
                      autoSpacing: false,td style="border: 1px solid #000; padding: 10px; text-align: left;">Prata</td>
                      pageFling: false,xt context) {er: 1px solid #000; padding: 10px; text-align: left;">QMT 5E79</td>
                      pageSnap: false,
                      fitPolicy: FitPolicy.BOTH,tle: const Text('Second Page')),
                      preventLinkNavigation: true, // very important
                      onRender: (pages) {
                        print("PDF rendered with $pages pages."); CircularProgressIndicator())
                      },
                      onError: (error) {
                        print('Error rendering PDF: $error'); as normas do
                      },ínio Residencial Fiji.
                      onPageError: (page, error) {,
                        print('Error on page $page: $error');e,
                      },
                      onViewCreated: (PDFViewController controller) {
                        // You can save the controller for later usen: center;">
                      },
                    ),tPolicy: FitPolicy.BOTH,rietário
                  ),ion: true, // very important
                ],
              ),print("PDF rendered with $pages pages.");
    );
  }</h2>
}print('Error rendering PDF: $error');eft: 20px;">




}  }    );
</body>
</html>
    ''';

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
