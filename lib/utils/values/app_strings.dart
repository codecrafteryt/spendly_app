/// Centralized string constants — no hardcoded strings in widgets.
class AppStrings {
  AppStrings._();

  static const appName = 'Spendly';
  static const tagline = 'Know your spending style';

  // Splash
  static const splashLoading = 'Preparing your journey...';

  // Onboarding
  static const onboardingSkip = 'Skip';
  static const onboardingNext = 'Next';
  static const onboardingStart = 'Start Quiz';
  static const onboardingTitle1 = 'Discover Your Spender Type';
  static const onboardingBody1 =
      'Take a quick quiz to understand how you handle money.';
  static const onboardingTitle2 = 'Get AI-Powered Insights';
  static const onboardingBody2 =
      'Receive a personalized report with tips tailored to you.';
  static const onboardingTitle3 = 'Save More, Stress Less';
  static const onboardingBody3 =
      'Unlock actionable advice to plug money leaks and build savings.';

  // Quiz
  static const quizTitle = 'Spending Quiz';
  static const quizBack = 'Back';
  static const quizNext = 'Next';
  static const quizFinish = 'See Results';
  static const quizLoadError = 'Could not load quiz questions.';
  static const quizRetry = 'Retry';

  // Analyzing
  static const analyzingTitle = 'Analyzing Your Habits';
  static const analyzingSubtitle =
      'Our AI is crafting your personalized report...';
  static const analyzingError = 'Report generation failed.';
  static const analyzingRetry = 'Try Again';

  // Results
  static const resultsTitle = 'Your Spender Type';
  static const resultsFreeTip = 'Free Preview Tip';
  static const resultsLocked = 'Full report locked';
  static const resultsUnlock = 'Unlock Full Report';
  static const resultsUnlockPrice = 'One-time unlock — \$4.99';

  // Payment
  static const paymentTitle = 'Unlock Your Report';
  static const paymentCard = 'Pay with Card';
  static const paymentCardSub = 'Visa, Mastercard, Amex (Stripe)';
  static const paymentJazzCash = 'JazzCash / Easypaisa';
  static const paymentJazzCashSub = 'Pay locally in Pakistan';
  static const paymentProcessing = 'Processing payment...';
  static const paymentSuccess = 'Payment successful!';
  static const paymentFailed = 'Payment failed. Please try again.';
  static const paymentRetry = 'Retry Payment';

  // Report
  static const reportTitle = 'Your Full Report';
  static const reportDownload = 'Download PDF';
  static const reportShare = 'Share PDF';
  static const reportGenerating = 'Generating PDF...';
  static const reportPdfError = 'Could not generate PDF.';
  static const reportScoreBreakdown = 'Score Breakdown';

  // Theme
  static const themeLight = 'Light';
  static const themeDark = 'Dark';
  static const themeSystem = 'System';

  // Errors
  static const errorGeneric = 'Something went wrong.';
  static const errorNetwork = 'Check your connection and try again.';
  static const btnRetry = 'Retry';
  static const btnContinue = 'Continue';
}
