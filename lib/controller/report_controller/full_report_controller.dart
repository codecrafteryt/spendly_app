import 'dart:io';
import 'dart:typed_data';

import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:printing/printing.dart';
import 'package:spendly_app/core/constants/app_strings.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';
import 'package:spendly_app/data/pdf_generator.dart';

class FullReportController extends GetxController {
  final RxString pdfError = ''.obs;

  SessionController get _session => Get.find<SessionController>();

  Future<Uint8List?> _buildPdf() async {
    final type = _session.spenderType.value;
    final text = _session.reportText.value;
    if (type == null || text.isEmpty) return null;
    return buildReportPdf(
      spenderType: type,
      scores: Map<String, int>.from(_session.scores),
      reportText: text,
    );
  }

  Future<void> sharePdf() async {
    pdfError.value = '';
    _session.isPdfLoading.value = true;
    try {
      final bytes = await _buildPdf();
      if (bytes == null) throw Exception('No data');
      await Printing.sharePdf(bytes: bytes, filename: 'spendly_report.pdf');
    } catch (_) {
      pdfError.value = AppStrings.reportPdfError;
    } finally {
      _session.isPdfLoading.value = false;
    }
  }

  Future<void> downloadPdf() async {
    pdfError.value = '';
    _session.isPdfLoading.value = true;
    try {
      final bytes = await _buildPdf();
      if (bytes == null) throw Exception('No data');
      final dir = await getApplicationDocumentsDirectory();
      final path = '${dir.path}/spendly_report.pdf';
      await File(path).writeAsBytes(bytes);
      await Printing.layoutPdf(onLayout: (_) async => bytes);
    } catch (_) {
      pdfError.value = AppStrings.reportPdfError;
    } finally {
      _session.isPdfLoading.value = false;
    }
  }
}
