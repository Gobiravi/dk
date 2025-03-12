import 'package:dikla_spirit/model/auth/onboarding_model.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class OnboardingImagesNotifier extends StateNotifier<List<SplashDetails>> {
  OnboardingImagesNotifier() : super([]);

  void updateImages(List<SplashDetails> newImages) {
    state = newImages;
  }
}

final onboardingImagesProvider =
    StateNotifierProvider<OnboardingImagesNotifier, List<SplashDetails>>(
  (ref) => OnboardingImagesNotifier(),
);
