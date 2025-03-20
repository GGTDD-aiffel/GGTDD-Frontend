import 'package:get/get.dart';
import 'package:ggtdd_frontend/controllers/auth_controller.dart';
import 'package:ggtdd_frontend/ui/features/actions/widgets/actions_detail_screen.dart';
import 'package:ggtdd_frontend/ui/features/actions/widgets/actions_screen.dart';
import 'package:ggtdd_frontend/ui/features/focus/widgets/focus_timer_screen.dart';
import 'package:ggtdd_frontend/ui/features/inbox/widgets/inbox_screen.dart';
import 'package:ggtdd_frontend/ui/features/intro/widgets/intro_screen.dart';
import 'package:ggtdd_frontend/ui/features/main/widgets/main_screen.dart';
import 'package:ggtdd_frontend/ui/features/onboarding/widgets/onboarding_contexts_screen.dart';
import 'package:ggtdd_frontend/ui/features/onboarding/widgets/onboarding_info_screen.dart';
import 'package:ggtdd_frontend/ui/features/recognition/widgets/recognition_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/app_features_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/context_roles_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/contexts_tags_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/custom_tags_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/settings_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/timer_settings_screen.dart';
import 'package:ggtdd_frontend/ui/features/settings/widgets/user_info_screen.dart';
import 'package:ggtdd_frontend/ui/features/welcome/widgets/welcome_screen.dart';

class AppRoutes {
  static const String home = '/';
  static const String intro = "/intro";
  static const String welcome = "/welcome";
  static const String onboardingInfo = "/onboarding/info";
  static const String onboardingContexts = "/onboarding/contexts";
  static const String inbox = "/inbox";
  static const String recognition = '/recognition';
  static const String actions = '/actions';
  static const String actionDetail = '/actions/:id';
  static const String settings = '/settings';
  static const String settingsUserInfo = '/settings/:user_id/user_info';
  static const String settingsContextTags = '/settings/:user_id/context_tags';
  static const String settingsContextRoles =
      '/settings/:user_id/context_tags/context';
  static const String settingsCustomTags =
      '/settings/:user_id/context_tags/tags';
  static const String settingsAppFeatures = '/settings/:user_id/app_features';
  static const String settingsTimer = '/settings/:user_id/timer';
  static const String focusTimer = '/focus/:id/timer';

  static final pages = [
    GetPage(name: home, page: () => MainScreen()),
    GetPage(name: intro, page: () => IntroScreen()),
    GetPage(name: welcome, page: () => WelcomeScreen()),
    GetPage(name: onboardingInfo, page: () => OnBoardingInfoScreen()),
    GetPage(name: onboardingContexts, page: () => OnBoardingContextsScreen()),
    GetPage(name: inbox, page: () => InboxScreen()),
    GetPage(name: recognition, page: () => RecognitionScreen()),
    GetPage(name: actions, page: () => ActionsScreen()),
    GetPage(
      name: actionDetail,
      page: () => ActionDetailScreen(id: Get.parameters['id'] ?? ''),
    ),
    GetPage(
      name: settings,
      page: () {
        final authController = Get.find<AuthController>();
        return SettingsScreen(userId: authController.userId.value);
      },
    ),
    GetPage(
      name: settingsUserInfo,
      page: () => UserInfoScreen(userId: Get.parameters['user_id'] ?? '1'),
    ),
    GetPage(
      name: settingsContextTags,
      page: () => ContextTagsScreen(userId: Get.parameters['user_id'] ?? '1'),
    ),
    GetPage(
      name: settingsContextRoles,
      page: () {
        final authController = Get.find<AuthController>();
        return ContextRolesScreen(userId: authController.userId.value);
      },
    ),
    GetPage(
      name: settingsCustomTags,
      page: () {
        final authController = Get.find<AuthController>();
        return CustomTagsScreen(userId: authController.userId.value);
      },
    ),
    GetPage(
      name: settingsAppFeatures,
      page: () {
        final authController = Get.find<AuthController>();
        return AppFeaturesScreen(userId: authController.userId.value);
      },
    ),
    GetPage(
      name: settingsTimer,
      page: () {
        final authController = Get.find<AuthController>();
        return TimerSettingsScreen(userId: authController.userId.value);
      },
    ),
    GetPage(
      name: focusTimer,
      page: () => FocusTimerScreen(id: Get.parameters['id'] ?? ''),
    ),
  ];

  static String get initial => intro;
}
