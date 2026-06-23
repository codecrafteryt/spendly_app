import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';
import 'package:spendly_app/services/ai_services/ai_service.dart';

class ReportController extends GetxController {
  ReportController({AiService? aiService}) : _ai = aiService ?? AiService();

  final AiService _ai;
  SessionController get _session => Get.find<SessionController>();

  @override
  void onReady() {
    super.onReady();
    if (_session.reportStatus.value == ReportStatus.idle) {
      generateReport();
    }
  }

  Future<void> generateReport() async {
    final type = _session.spenderType.value;
    if (type == null) {
      _session.setReportError();
      return;
    }
    _session.setReportLoading();
    try {
      final text = await _ai.generateReport(
        spenderType: type,
        scores: Map<String, int>.from(_session.scores),
        answers: Map<String, String>.from(_session.answers),
      );
      _session.setReportSuccess(text);
      Get.offNamed(AppRoutes.resultsPreview);
    } catch (_) {
      _session.setReportError();
    }
  }
}
