import 'dart:typed_data';

import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

import '../utils/values/app_strings.dart';

Future<Uint8List> buildReportPdf({
  required SpenderType spenderType,
  required Map<String, int> scores,
  required String reportText,
}) async {
  final doc = pw.Document();
  final maxScore = scores.values.fold<int>(0, (a, b) => a > b ? a : b);

  doc.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(40),
      build: (context) => [
        pw.Header(
          level: 0,
          child: pw.Row(
            mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
            children: [
              pw.Text(AppStrings.appName,
                  style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold)),
              pw.Text('Personal Report',
                  style: const pw.TextStyle(fontSize: 12)),
            ],
          ),
        ),
        pw.SizedBox(height: 20),
        pw.Container(
          padding: const pw.EdgeInsets.all(12),
          decoration: pw.BoxDecoration(
            color: PdfColor.fromHex('#1B7F5C'),
            borderRadius: pw.BorderRadius.circular(8),
          ),
          child: pw.Text(
            spenderType.label,
            style: pw.TextStyle(
              color: PdfColors.white,
              fontSize: 18,
              fontWeight: pw.FontWeight.bold,
            ),
          ),
        ),
        pw.SizedBox(height: 24),
        pw.Text(AppStrings.reportScoreBreakdown,
            style: pw.TextStyle(fontSize: 14, fontWeight: pw.FontWeight.bold)),
        pw.SizedBox(height: 12),
        ...scores.entries.map((e) => _scoreBar(e.key, e.value, maxScore)),
        pw.SizedBox(height: 24),
        pw.Divider(),
        pw.SizedBox(height: 12),
        ...reportText.split('\n\n').map(
              (p) => pw.Padding(
                padding: const pw.EdgeInsets.only(bottom: 10),
                child: pw.Text(p, style: const pw.TextStyle(fontSize: 11, lineSpacing: 4)),
              ),
            ),
        pw.SizedBox(height: 30),
        pw.Divider(),
        pw.SizedBox(height: 8),
        pw.Text(
          'Share Spendly with friends — help them discover their spender type too!',
          style: pw.TextStyle(fontSize: 10, color: PdfColors.grey700),
        ),
      ],
    ),
  );
  return doc.save();
}

pw.Widget _scoreBar(String label, int value, int max) {
  final fraction = max > 0 ? value / max : 0.0;
  return pw.Padding(
    padding: const pw.EdgeInsets.only(bottom: 8),
    child: pw.Column(
      crossAxisAlignment: pw.CrossAxisAlignment.start,
      children: [
        pw.Text('$label: $value', style: const pw.TextStyle(fontSize: 10)),
        pw.SizedBox(height: 4),
        pw.Container(
          height: 8,
          width: 200,
          decoration: pw.BoxDecoration(
            color: PdfColors.grey300,
            borderRadius: pw.BorderRadius.circular(4),
          ),
          child: pw.Align(
            alignment: pw.Alignment.centerLeft,
            child: pw.Container(
              height: 8,
              width: 200 * fraction,
              decoration: pw.BoxDecoration(
                color: PdfColor.fromHex('#1B7F5C'),
                borderRadius: pw.BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    ),
  );
}
