import 'dart:developer';
import 'dart:ui';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_app_info/flutter_app_info.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:theme_provider/theme_provider.dart';
import 'package:thousand_app/core/locator/locator.dart';
import 'package:thousand_app/core/routes/routes.dart';
import 'package:thousand_app/core/theme/material.dart';
import 'package:thousand_app/firebase_options.dart';
import 'package:thousand_app/news/bloc/news_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await _initApp();
  runApp(AppInfo(
    data: await AppInfoData.get(),
    child: const MyApp(),
  ));
}

Future<void> _initApp() async {
  try {
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
    FlutterError.onError = (errorDetails) {
      FirebaseCrashlytics.instance.recordFlutterFatalError(errorDetails);
    };
    PlatformDispatcher.instance.onError = (error, stack) {
      FirebaseCrashlytics.instance.recordError(error, stack, fatal: true);
      return true;
    };
  } on Exception catch (e) {
    log("Failed to initialize Firebase: $e");
  }
  await ServiceLocator.setup();
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ThemeProvider(
      defaultThemeId: DefaultTheme.dark.id,
      saveThemesOnChange: true,
      onInitCallback: (controller, previouslySavedThemeFuture) async {
        String? savedTheme = await previouslySavedThemeFuture;
        if (savedTheme != null) {
          controller.setTheme(savedTheme);
        }
      },
      themes: [
        DefaultTheme.light,
        DefaultTheme.dark,
      ],
      child: MultiBlocListener(
        listeners: [
          BlocProvider(create: (context) => GetIt.instance<NewsBloc>()),
        ],
        child: ThemeConsumer(
          child: Builder(
            builder: (context) => MaterialApp.router(
              title: 'Thousand App',
              routerConfig: router,
              debugShowCheckedModeBanner: false,
              theme: ThemeProvider.themeOf(context).data,
            ),
          ),
        ),
      ),
    );
  }
}
