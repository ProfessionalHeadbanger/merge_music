import 'package:merge_music/presentation/main_page/pages/main_page.dart';
import 'package:merge_music/common/navigation/routes.dart';
import 'package:merge_music/presentation/vk_login/pages/vk_login_page.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  initialLocation: Routes.vkLogin,
  routes: [
    GoRoute(
      path: Routes.mainPage,
      builder: (_, __) => const MainPage(),
    ),
    GoRoute(
      path: Routes.vkLogin,
      builder: (_, __) => const VkLoginPage(),
    ),
  ],
);
