import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:spendly_app/controller/quiz_controller/quiz_controller.dart';
import 'package:spendly_app/view/widget/quiz_option_tile.dart';
import 'package:spendly_app/view/widget/quiz_progress_bar.dart';

import '../../utils/values/app_colors.dart';
import '../../utils/values/app_spacing.dart';
import '../../utils/values/app_strings.dart';
import '../widget/error_state_widget.dart';
import '../widget/primary_button.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(AppStrings.quizTitle)),
      body: Obx(() {
        switch (controller.status.value) {
          case QuizStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case QuizStatus.error:
            return ErrorStateWidget(
              message: AppStrings.quizLoadError,
              retryLabel: AppStrings.quizRetry,
              onRetry: controller.loadQuestions,
            );
          case QuizStatus.ready:
            return _QuizBody(controller: controller);
        }
      }),
    );
  }
}

class _QuizBody extends StatelessWidget {
  const _QuizBody({required this.controller});
  final QuizController controller;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Obx(() => QuizProgressBar(progress: controller.progress)),
        Expanded(
          child: PageView.builder(
            controller: controller.pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: controller.questions.length,
            onPageChanged: (i) => controller.currentIndex.value = i,
            itemBuilder: (_, index) {
              final q = controller.questions[index];
              return Padding(
                padding: const EdgeInsets.all(AppSpacing.lg),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('${index + 1}/${controller.questions.length}',
                        style: Theme.of(context).textTheme.labelMedium?.copyWith(
                              color: AppColors.accent,
                            )),
                    const SizedBox(height: AppSpacing.sm),
                    Text(q.questionText,
                        style: Theme.of(context).textTheme.headlineSmall),
                    const SizedBox(height: AppSpacing.lg),
                    Expanded(
                      child: ListView.builder(
                        itemCount: q.options.length,
                        itemBuilder: (_, optIdx) => Obx(() {
                          final selected =
                              controller.selectedFor(index) == optIdx;
                          return QuizOptionTile(
                            text: q.options[optIdx].text,
                            selected: selected,
                            onTap: () => controller.selectOption(optIdx),
                          );
                        }),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(AppSpacing.lg),
          child: Row(
            children: [
              Obx(() => TextButton(
                    onPressed: controller.currentIndex.value > 0
                        ? controller.goBack
                        : null,
                    child: Text(AppStrings.quizBack),
                  )),
              const Spacer(),
              Obx(() => SizedBox(
                    width: 160,
                    child: PrimaryButton(
                      label: controller.isLastQuestion
                          ? AppStrings.quizFinish
                          : AppStrings.quizNext,
                      onPressed:
                          controller.canGoNext ? controller.goNext : null,
                      enabled: controller.canGoNext,
                    ),
                  )),
            ],
          ),
        ),
      ],
    );
  }
}
