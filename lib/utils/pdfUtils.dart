import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:pdf/widgets.dart' as pw;
import 'dart:html' as html;
import 'package:pdf/pdf.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'dart:typed_data';

class PdfUtils {
  static Future<void> abrirPlanoTratamentoPdf(String paciente,
      String diagnostico, String avaliador, String observacao) async {
    final pdf = pw.Document();

    List<Map<String, dynamic>> procedimentos = [
      {
        'servico': 'Procedimento 1',
        'numero_sessoes': 5,
        'unitario': 100.00,
        'total': 500.00,
        'desconto': 50.00,
        'valor_final': 450.00,
      },
      {
        'servico': 'Procedimento 2',
        'numero_sessoes': 3,
        'unitario': 150.00,
        'total': 450.00,
        'desconto': 45.00,
        'valor_final': 405.00,
      },
      {
        'servico': 'Procedimento 1',
        'numero_sessoes': 5,
        'unitario': 100.00,
        'total': 500.00,
        'desconto': 50.00,
        'valor_final': 450.00,
      },
      {
        'servico': 'Procedimento 2',
        'numero_sessoes': 3,
        'unitario': 150.00,
        'total': 450.00,
        'desconto': 45.00,
        'valor_final': 405.00,
      },
      {
        'servico': 'Procedimento 1',
        'numero_sessoes': 5,
        'unitario': 100.00,
        'total': 500.00,
        'desconto': 50.00,
        'valor_final': 450.00,
      },
      {
        'servico': 'Procedimento 2',
        'numero_sessoes': 3,
        'unitario': 150.00,
        'total': 450.00,
        'desconto': 45.00,
        'valor_final': 405.00,
      },
    ];

    Future<Uint8List> loadAssetImage() async {
      final ByteData data = await rootBundle
          .load('assets/images/illustration/signup_illustration.png');
      return data.buffer.asUint8List();
    }

    final Uint8List imageBytes = await loadAssetImage();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          final pageWidth = context.page.pageFormat.availableWidth;

          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.all(4),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  children: [
                    pw.Container(
                      height: 50,
                      width: 50,
                      child: pw.Image(
                        pw.MemoryImage(imageBytes),
                        fit: pw.BoxFit.contain,
                      ),
                    ),
                    pw.SizedBox(width: 16),
                    pw.Column(
                      crossAxisAlignment: pw.CrossAxisAlignment.start,
                      children: [
                        pw.Text(
                          'Thais Estética Integrativa - Telefone: (31)8254-0846',
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(height: 8),
                        pw.Text(
                          'Av. Rio Branco, 106 - Nova Lima/MG - E-mail: thaisesteticaintegrativa@gmail.com',
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                        pw.SizedBox(height: 24),
                        pw.Text(
                          'PROPOSTA VÁLIDA ATÉ: 14/09/2024',
                          style: pw.TextStyle(
                            fontSize: 10,
                            fontStyle: pw.FontStyle.italic,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: 0.17 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Cliente',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.83 * pageWidth,
                      padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                      child: pw.Text(
                        paciente,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: 0.17 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Avaliador',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.83 * pageWidth,
                      padding: const pw.EdgeInsets.symmetric(horizontal: 4),
                      child: pw.Text(
                        avaliador,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Observações',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      child: pw.Text(
                        observacao,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Plano 123456789 - Personalizado',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: 0.35 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Serviço',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.13 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'N° Sessões',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.13 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Unitário',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.13 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Total',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.13 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Desconto',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.13 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Valor Final',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(procedimentos.length, (index) {
                final procedimento = procedimentos[index];
                return pw.Container(
                  padding: const pw.EdgeInsets.all(1),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 0.35 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['servico'],
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.13 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['numero_sessoes'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.13 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['unitario'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.13 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['total'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.13 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['desconto'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.13 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['valor_final'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              pw.SizedBox(height: 24),
              pw.Row(
                children: [
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Valor Bruto:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 2.880,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              pw.Row(
                children: [
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Valor Liq:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 2.880,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.20 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Desconto Adic.:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 0,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Valor Final:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.15 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 2.880,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Parcelas',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: 0.20 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Parcelas',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.25 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Vencimento',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.25 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Valor(R\$)',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                    pw.Container(
                      width: 0.30 * pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Forma de Pagamento',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              ...List.generate(procedimentos.length, (index) {
                final procedimento = procedimentos[index];
                return pw.Container(
                  padding: const pw.EdgeInsets.all(1),
                  decoration: pw.BoxDecoration(
                    border: pw.Border.all(color: PdfColors.black),
                  ),
                  child: pw.Row(
                    children: [
                      pw.Container(
                        width: 0.20 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['servico'],
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.25 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['numero_sessoes'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.25 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['unitario'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                      pw.Container(
                        width: 0.30 * pageWidth,
                        padding: const pw.EdgeInsets.all(4),
                        decoration: const pw.BoxDecoration(
                          color: PdfColors.white,
                        ),
                        child: pw.Text(
                          procedimento['total'].toString(),
                          textAlign: pw.TextAlign.center,
                          style: const pw.TextStyle(
                            fontSize: 10,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              pw.SizedBox(height: 8),
              pw.Container(
                padding: const pw.EdgeInsets.all(1),
                width: double.infinity,
                decoration: pw.BoxDecoration(
                  border: pw.Border.all(color: PdfColors.black),
                ),
                child: pw.Row(
                  children: [
                    pw.Container(
                      width: pageWidth,
                      padding: const pw.EdgeInsets.all(4),
                      decoration: const pw.BoxDecoration(
                        color: PdfColors.grey300,
                      ),
                      child: pw.Text(
                        'Valor Total',
                        textAlign: pw.TextAlign.center,
                        style: pw.TextStyle(
                          fontSize: 10,
                          fontWeight: pw.FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              pw.Row(
                children: [
                  pw.Container(
                    width: 0.16 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Valor:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.18 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 2.880,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.16 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Desconto:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.17 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 0,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.16 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      color: PdfColors.grey300,
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      'Valor Final:',
                      textAlign: pw.TextAlign.center,
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                  pw.Container(
                    width: 0.17 * pageWidth,
                    padding: const pw.EdgeInsets.all(4),
                    decoration: pw.BoxDecoration(
                      border: pw.Border.all(color: PdfColors.black),
                    ),
                    child: pw.Text(
                      "R\$ 2.880,00",
                      style: pw.TextStyle(
                        fontSize: 10,
                        fontWeight: pw.FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );

    final Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }

  static Future<void> abrirContratoPdf(
      String nome,
      String estadoCivil,
      String profissao,
      String rua,
      String bairro,
      String numero,
      String cep,
      String dia,
      String mes,
      String ano) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "CONTRATO DE PRESTAÇÃO DE SERVIÇOS QUE ENTRE SI FAZEM ",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 24),
              pw.Text(
                "Como contratante, $nome, $estadoCivil, $profissao, residente e domiciliado na $rua, $bairro, $numero, $cep; Como contratada, Thais Melo Estética Integrativa, pessoa jurídica de direito privado, inscrita no CNPJ sob o número 43.131.909/0001-91, situada na Avenida Rio Branco, número 106, Centro, na cidade de Nova Lima, Minas Gerais, CEP 34.000.132, empresa legalmente representada por Thais Rodrigues Melo, esteticista, microempreendedora individual, registrada sob o n.º 797.411-57.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA PRIMEIRA: DO OBJETO",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "O presente instrumento tem por objeto estabelecer a prestação, pela contratada, de procedimentos estéticos faciais, corporais e/ou capilares, executados com recursos de trabalho, produtos cosméticos, técnicas e equipamentos registrados na Agência Nacional de Vigilância Sanitária (Anvisa).",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "1.1. O objeto contratual engloba a realização, pela contratada, de elaboração de protocolo de tratamento, com base no quadro da parte contratante, estabelecendo as técnicas a serem empregadas e a quantidade de aplicações necessárias.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "1.2. A parte contratante está ciente que os resultados dos tratamentos são individuais e não devem ser parametrizados com quaisquer outros, bem como possui conhecimento que a manutenção dos referidos avanços é integrativa, razão pela qual está diretamente ligada à assiduidade no tratamento, acompanhamento nutricional, atividade física regular e hábitos condizentes com os objetivos pretendidos.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA SEGUNDA: DA REALIZAÇÃO DOS PROCEDIMENTOS",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "O tratamento proposto será realizado com a periodicidade e duração discriminadas na Ficha de Anamnese Clínica (ANEXO 1), podendo, a critério da contratada, sofrer prorrogação ou alteração, de acordo com eventual complexidade que o caso apresentar no decorrer do procedimento, bem como pela resposta biológica do paciente à técnica empregada, assiduidade às sessões e observância das orientações fornecidas pela contratada.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "2.1. Fica estabelecido que os serviços serão prestados no endereço sede da contratada, localizado na Rua Melo Viana, número 187, Centro, na cidade de Nova Lima/MG, CEP 34.000.282.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "2.1.1 A prestação de serviços em endereço diverso da sede da empresa está condicionada ao interesse e disponibilidade da contratada, que poderá arbitrar o custo e o horário de atendimento.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
            ],
          );
        },
      ),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "CLÁUSULA TERCEIRA: DO PREÇO E FORMA DE PAGAMENTO",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "Pelos serviços contratados, devidamente elencados na Ficha de Anamnese Clínica (ANEXO 1), a parte contratante pagará à contratada, o valor constante no ANEXO 2, nas condições estabelecidas pelas partes e colacionadas ao mesmo anexo.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "3.1. Os pagamentos vencidos e efetuados fora dos prazos previstos, estarão sujeitos a atualização monetária, a multa de mora de 2% (dois por cento) e juros de 1% (um por cento) ao mês.  ",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "3.1.1.  A critério da contratada, poderá haver o perdão ou a redução da multa prevista no item 3.1., contudo, isso não significa novação contratual, mas tão somente mera liberalidade deste.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA QUARTA: DAS GARANTIAS E OBRIGAÇÕES DO CONTRATANTE",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "A contratada desenvolverá seus melhores esforços no sentido de obter os resultados pretendidos pela parte contratante nas ações sobreditas. Portanto, a prestação dos serviços estabelecidos na Ficha de Anamnese Clínica (ANEXO 1) tem caráter de exclusividade, não podendo a parte contratante, livremente, solicitar a assistência ou patrocínio de outros profissionais/consultórios, sem o conhecimento da contratada.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "4.1.  A parte contratante contribuirá com fornecimento de documentação médica, exames, ou outros meios necessários para a melhor execução do presente contrato, quando houver expressa solicitação da contratada.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "4.2. A parte contratante comparecerá pontualmente ao consultório da contratada, nas sessões previamente agendadas, cuja ausência sem aviso prévio de 24 (vinte e quatro) horas acarretará a perda do direito ao reagendamento desta aplicação.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "4.2.1. A parte contratante está ciente que as sessões desmarcadas com prazo superior a 24 (vinte e quatro) horas serão computadas como executadas, razão pela qual a parte contratante não poderá requerer qualquer reembolso. ",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "4.3.  A parte contratante informará à contratada sobre qualquer alteração, supostamente ocorrida em decorrência do tratamento realizado, bem como sobre eventuais insatisfações ou dúvidas sobre o tratamento em execução.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "4.4. A parte contratante se compromete a manter seus dados cadastrais sempre atualizados, informando eventuais mudanças de endereço, telefone etc.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "4.5. O presente contrato poderá ser suspenso, pelo prazo máximo de quarenta dias, caso, por recomendação médica, devidamente comprovada por atestado, a parte contratante não possa se submeter aos procedimentos estéticos contratados.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "4.6. Após o período de finalização do tratamento contratado, conforme data estipulada no ANEXO 1, o contratante terá o prazo de trinta dias para realizar quaisquer reposições de sessões desmarcadas nos termos previstos no item 4.2. do presente instrumento, sob pena de preclusão do direito à remarcação.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
            ],
          );
        },
      ),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "CLÁUSULA QUINTA - DAS GARANTIAS E OBRIGAÇÕES DA CONTRATADA",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "A contratada declara que a técnica proposta e demais materiais utilizados possuem efetiva comprovação científica, respeitando o mais alto nível profissional, o estado atual da ciência e sua dignidade profissional.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "Parágrafo único: a parte contratante foi devidamente esclarecida sobre os propósitos, custos, riscos e alternativas de tratamento, bem como que a estética não conta exclusivamente com a eficácia procedimental e que os resultados esperados, a partir do diagnóstico, poderão não se concretizar em face da resposta biológica, da colaboração do paciente e da própria limitação dos métodos de tratamento já desenvolvidos.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "5.1.  A contratada se compromete a utilizar as técnicas e os materiais adequados à execução do plano de tratamento proposto e aprovado, assumindo a responsabilidade pela qualidade dos serviços prestados, resguardando a privacidade do paciente e o necessário sigilo, bem como zelando pela saúde e dignidade da parte contratante. ",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "5.2. Caso seja necessária a desmarcação de sessões pela contratada, estas serão reagendadas e realizadas no prazo de trinta dias. Na impossibilidade de reposição, a parte contratante será reembolsada no valor correspondente à sessão desmarcada, conforme o ajustado no ANEXO 2.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA SEXTA: DA AUTORIZAÇÃO PARA O USO DE IMAGEM",
                textAlign: pw.TextAlign.justify,
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "Mediante a anuência e a assinatura do TERMO DE AUTORIZAÇÃO PARA O USO DE IMAGEM (ANEXO 3), a  parte contratante autoriza o uso do material de registro fotográfico, ou em vídeo, sobre qualquer fase de tratamento, para fins didáticos, conferências, palestras, publicação científica ou não, comunicação entre profissionais, entrevistas em periódicos ou televisão, motivação de clientes e também para fins publicitários, observando-se a preservação da  identidade, o respeito à privacidade, direito à imagem e o dever de sigilo profissional.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA SÉTIMA: DA RESPONSABILIDADE",
                textAlign: pw.TextAlign.justify,
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "A contratada, nos termos do artigo 14, §4°, da lei m.° 8.078, de 11.09.90 (Código de Defesa do Consumidor), responde pela reparação dos danos causados à parte contratante em decorrência da prestação dos serviços contratados, desde que presentes os requisitos da Responsabilidade Civil, bem como por informações insuficientes ou inadequadas sobre o tratamento, suas consequências e riscos.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "7.1. A obrigação assumida pela contratada, por força do presente instrumento, incumbe ao profissional agir dentro da melhor técnica na execução dos serviços, despendendo todos os esforços e meios necessários para alcance do objetivo almejado no tratamento.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "7.2. A contratada não se responsabilizará por quaisquer consequências ao tratamento, bem como por prejuízos financeiros, estéticos e morais gerados à parte contratante em virtude de sua não cooperação durante e após o tratamento, ou ainda pela omissão de informações relevantes para o diagnóstico do caso.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "7.2.1 Considera-se como não cooperação do paciente, para fins do presente instrumento, o não comparecimento às consultas agendadas, o abandono do tratamento e a não observação das recomendações prescritas pelo esteticista responsável.",
                textAlign: pw.TextAlign.justify,
              ),
            ],
          );
        },
      ),
    );

    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Text(
                "7.3. Nos termos do artigo 14, §3º, I e II do Código de Defesa do Consumidor, a frustração da parte contratante com os resultados do tratamento contratado, por si só, não é capaz de garantir o direito à restituição do valor pago pelos serviços prestados, ensejando a exclusão de responsabilidade do fornecedor. ",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA OITAVA: DA RESCISÃO CONTRATUAL",
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "Para além das hipóteses legais, o presente instrumento poderá ser rescindido pelas partes, uma vez verificada a ocorrência do descumprimento de qualquer cláusula ou condição pactuada, não sanada no prazo de trinta dias, contado do recebimento de notificação neste sentido.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "Parágrafo Primeiro: A rescisão, na hipótese de não regularização do descumprimento apontado, operará de pleno direito após o decurso do prazo indicado, independentemente de qualquer notificação judicial ou extrajudicial.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "Parágrafo Segundo: A parte que der causa a rescisão do contrato permanecerá responsável por todos as perdas e danos ocasionadas à parte inocente.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "CLÁUSULA NONA: DO FORO",
                textAlign: pw.TextAlign.justify,
                style:
                    pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
              ),
              pw.SizedBox(height: 16),
              pw.Text(
                "As partes elegem o foro da Comarca de Nova Lima, Minas Gerais para dirimir quaisquer dúvidas oriundas do presente ajuste, preterindo qualquer outro por mais privilegiado que seja. ",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "E, por estarem acertados em todos os seus termos, firmam o presente instrumento em 2 (duas) vias de igual teor e forma.",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 32),
              pw.Text(
                "Nova Lima, $dia de $mes de $ano",
                textAlign: pw.TextAlign.justify,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "__________________________________       ________________________________",
                textAlign: pw.TextAlign.center,
              ),
              pw.SizedBox(height: 12),
              pw.Text(
                "                     CONTRATANTE                                                CONTRATADO",
                textAlign: pw.TextAlign.center,
              ),
            ],
          );
        },
      ),
    );

    final Uint8List bytes = await pdf.save();
    final blob = html.Blob([bytes], 'application/pdf');
    final url = html.Url.createObjectUrlFromBlob(blob);
    html.window.open(url, "_blank");
    html.Url.revokeObjectUrl(url);
  }
}
