import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/home_screen.dart';
import '../../features/onboarding/presentation/onboarding_screen.dart';
import '../../features/privacy/presentation/privacy_screen.dart';
import '../../features/settings/application/settings_controller.dart';
import '../../features/settings/presentation/settings_screen.dart';
import '../../features/subscription/presentation/subscription_screen.dart';

abstract final class AppRoutes {
  static const home = '/';
  static const onboarding = '/onboarding';
  static const settings = '/settings';
  static const privacy = '/settings/privacy';
  static const subscription = '/settings/subscription';
}

final appRouterProvider = Provider<GoRouter>((ref) {
  final router = GoRouter(
    initialLocation: AppRoutes.home,
    redirect: (context, state) {
      final done = ref.read(settingsControllerProvider).onboardingCompleted;
      final atOnboarding = state.matchedLocation == AppRoutes.onboarding;
      if (!done && !atOnboarding) return AppRoutes.onboarding;
      if (done && atOnboarding) return AppRoutes.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.onboarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: AppRoutes.settings,
        builder: (context, state) => const SettingsScreen(),
        routes: [
          GoRoute(
            path: 'privacy',
            builder: (context, state) => const PrivacyScreen(),
          ),
          GoRoute(
            path: 'subscription',
            builder: (context, state) => const SubscriptionScreen(),
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});
