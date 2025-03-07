import 'package:flutter/material.dart';
import 'package:merge_music/core/themes/app_theme.dart';
import 'package:merge_music/common/navigation/router.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:merge_music/service_locator.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await setupServiceLocator();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      routerConfig: router,
      theme: AppTheme.lightTheme,
    );
  }
}
