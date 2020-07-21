import 'package:flutter/material.dart';
import 'package:flutter_boilerplate_starter/presentation/core/colors.dart';

class Themes {
  Themes._();

  static ThemeData getDefaultTheme() {
    // const _textStyle = TextStyle(
    //   color: Colors.white,
    //   // letterSpacing: Constants.UI_LETTER_SPACING,
    // );
    return ThemeData(
      canvasColor: LSColors.primary,
      primaryColor: LSColors.secondary,
      accentColor: LSColors.accent,
      highlightColor: LSColors.secondary,
      cardColor: LSColors.secondary,
      splashColor: LSColors.splash,
      dialogBackgroundColor: LSColors.secondary,
      dividerColor: LSColors.accent.withAlpha(0),
      unselectedWidgetColor: Colors.white,
    );
  }
}
