import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_starter/core/di/injector_container.dart'
    as di;
import 'package:flutter_boilerplate_starter/core/log/logger.dart';
import 'package:flutter_boilerplate_starter/presentation/core/theme.dart';
import 'package:flutter_boilerplate_starter/presentation/feature/splash/splash_screen.dart';

void main() async {
  // Need to call this before starting di
  WidgetsFlutterBinding.ensureInitialized();

  // Set up dependency injection
  await di.init();

  // Set up application
  initApp();

  runZonedGuarded(() {
    runApp(MyApp());
  }, (error, stacktrace) {
    // Log any uncaught error
    Logger.error(
      'not caught error',
      Exception(error.toString() ?? ''),
      stacktrace,
    );
  });
}

/// Sets up the application
void initApp() async {}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App name',
      theme: Themes.getDefaultTheme(),
      home: SplashScreen(),
    );
  }
}
