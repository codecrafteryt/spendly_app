import 'package:get/get.dart';
import 'package:spendly_app/data/models/quiz_model/spender_type.dart';

enum ReportStatus { idle, loading, success, error }

class SessionController extends GetxController {
  final RxString sessionId = ''.obs;
  final Rx<SpenderType?> spenderType = Rx<SpenderType?>(null);
  final RxMap<String, int> scores = <String, int>{}.obs;
  final RxMap<String, String> answers = <String, String>{}.obs;
  final RxString previewTip = ''.obs;
  final RxString reportText = ''.obs;
  final Rx<ReportStatus> reportStatus = ReportStatus.idle.obs;
  final RxBool isUnlocked = false.obs;
  final RxBool isPdfLoading = false.obs;

  void setQuizResults({
    required SpenderType spenderType,
    required Map<String, int> scores,
    required Map<String, String> answers,
    required String previewTip,
  }) {
    this.spenderType.value = spenderType;
    this.scores.assignAll(scores);
    this.answers.assignAll(answers);
    this.previewTip.value = previewTip;
    reportText.value = '';
    reportStatus.value = ReportStatus.idle;
    isUnlocked.value = false;
  }

  void setReportSuccess(String text) {
    reportText.value = text;
    reportStatus.value = ReportStatus.success;
  }

  void setReportError() => reportStatus.value = ReportStatus.error;
  void setReportLoading() => reportStatus.value = ReportStatus.loading;
  void unlockReport() => isUnlocked.value = true;
}
