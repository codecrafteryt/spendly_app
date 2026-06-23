import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/core/routes/app_routes.dart';
import 'package:spendly_app/data/quiz_data.dart';
import 'package:spendly_app/data/models/quiz_model/quiz_question.dart';
import 'package:spendly_app/controller/report_controller/session_controller.dart';

enum QuizStatus { loading, ready, error }

class QuizController extends GetxController {
  final Rx<QuizStatus> status = QuizStatus.loading.obs;
  final RxInt currentIndex = 0.obs;
  final RxList<QuizQuestion> questions = <QuizQuestion>[].obs;
  final RxMap<int, int> selectedOptions = <int, int>{}.obs;
  late PageController pageController;

  SessionController get _session => Get.find<SessionController>();

  @override
  void onInit() {
    super.onInit();
    pageController = PageController();
    loadQuestions();
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }

  void loadQuestions() {
    status.value = QuizStatus.loading;
    try {
      questions.assignAll(getQuizQuestions());
      status.value = QuizStatus.ready;
    } catch (_) {
      status.value = QuizStatus.error;
    }
  }

  double get progress =>
      questions.isEmpty ? 0 : (currentIndex.value + 1) / questions.length;

  bool get canGoNext => selectedOptions.containsKey(currentIndex.value);
  bool get isLastQuestion => currentIndex.value >= questions.length - 1;

  void selectOption(int optionIndex) {
    selectedOptions[currentIndex.value] = optionIndex;
    selectedOptions.refresh();
  }

  int? selectedFor(int questionIndex) => selectedOptions[questionIndex];

  void goNext() {
    if (!canGoNext) return;
    if (isLastQuestion) {
      completeQuiz();
      return;
    }
    currentIndex.value++;
    pageController.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void goBack() {
    if (currentIndex.value == 0) return;
    currentIndex.value--;
    pageController.previousPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  void completeQuiz() {
    final answers = <QuizOption>[];
    final answerMap = <String, String>{};
    for (var i = 0; i < questions.length; i++) {
      final optIdx = selectedOptions[i]!;
      final q = questions[i];
      final opt = q.options[optIdx];
      answers.add(opt);
      answerMap[q.id] = opt.text;
    }
    final scores = aggregateScores(answers);
    final type = calculateSpenderType(scores);
    _session.setQuizResults(
      spenderType: type,
      scores: scores,
      answers: answerMap,
      previewTip: freePreviewTip(type),
    );
    Get.offNamed(AppRoutes.analyzing);
  }
}
