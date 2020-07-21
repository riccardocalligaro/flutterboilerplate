import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_starter/core/navigation/routes.dart';

/// Singleton that helps to navigate inside the application
/// Contains also snackbars
class AppNavigator {
  static AppNavigator _instance;

  AppNavigator._();

  static AppNavigator get instance {
    if (_instance == null) {
      _instance = AppNavigator._();
    }
    return _instance;
  }

  /// Navigates and replaces the current screen with a [SplashScreen]
  void navToSplash(BuildContext context) {
    Navigator.pushReplacementNamed(context, Routes.splash);
  }
}
