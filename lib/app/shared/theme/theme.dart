import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:commune_app/app/modules/common/common/styles/color_palettes.dart';
import 'package:commune_app/app/shared/tool/constants.dart';

import '../models/theme/theme_data.dart';

class CustomTheme {
  Color? colorStatus1;
  Color? colorStatus2;

  CustomTheme({this.colorStatus1, this.colorStatus2});

  factory CustomTheme.dark() {
    return CustomTheme(colorStatus1: Colors.red, colorStatus2: Colors.blue);
  }

  factory CustomTheme.light() {
    return CustomTheme(colorStatus1: Colors.white, colorStatus2: Colors.green);
  }

  static getCusTheme(THEME_MODE themeMode) {
    switch(themeMode) {
      case THEME_MODE.DARK:
        return CustomTheme.dark();
      case THEME_MODE.LIGHT:
        return CustomTheme.light();
      default:
        return CustomTheme.light();
    }
  }

}

final ThemeData lightThemeData = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: Colors.blue,
  primaryColorDark: Colors.blueAccent,
  backgroundColor: Colors.white,
  textSelectionColor: Colors.black,
  accentColor: Modular.get<ColorPalettes>().blueLight,
  bottomAppBarColor: Colors.white,
  textSelectionHandleColor: Colors.white70,
  textTheme: TextTheme(
    subtitle1: TextStyle(
        color: Colors.red,
        fontFamily: 'abc'
    ),
  ),
);

final ThemeData darkThemeData = ThemeData.dark().copyWith(
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: ReplyColors.darkDrawerBackground,
      modalBackgroundColor: Colors.black.withOpacity(0.7),
    ),

    brightness: Brightness.dark,
    primaryColor: Colors.white30,
    primaryColorDark: Colors.white70,
    backgroundColor: Colors.black54,
    textSelectionHandleColor: Colors.white70,
    textSelectionColor: Colors.white60,
    accentColor: Colors.blueGrey,
    bottomAppBarColor: ReplyColors.darkBottomAppBarBackground,

    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: ReplyColors.darkBottomAppBarBackground,
      selectedIconTheme: const IconThemeData(color: ReplyColors.orange300),
      selectedLabelTextStyle:
      GoogleFonts.workSansTextTheme().headline5!.copyWith(
        color: ReplyColors.orange300,
      ),
      unselectedIconTheme: const IconThemeData(color: ReplyColors.greyLabel),
      unselectedLabelTextStyle:
      GoogleFonts.workSansTextTheme().headline5!.copyWith(
        color: ReplyColors.greyLabel,
      ),
    ),
    canvasColor: ReplyColors.black900,
    cardColor: ReplyColors.darkCardBackground,
    chipTheme: _buildChipTheme(
      ReplyColors.blue200,
      ReplyColors.darkChipBackground,
      Brightness.dark,
    ),
    colorScheme: const ColorScheme.dark(
      primary: ReplyColors.blue200,
      primaryVariant: ReplyColors.blue300,
      secondary: ReplyColors.orange300,
      secondaryVariant: ReplyColors.orange300,
      surface: ReplyColors.black800,
      error: ReplyColors.red200,
      onPrimary: ReplyColors.black900,
      onSecondary: ReplyColors.black900,
      onBackground: ReplyColors.white50,
      onSurface: ReplyColors.white50,
      onError: ReplyColors.black900,
      background: ReplyColors.black900Alpha087,
    ),
    // textTheme: _buildReplyDarkTextTheme(base.textTheme),
    scaffoldBackgroundColor: ReplyColors.black900,
    textTheme: TextTheme(
        subtitle1: TextStyle(
            color: Colors.red,
            fontFamily: 'abc'
        )
    ).apply(
        bodyColor: Modular.get<ColorPalettes>().text
    )
);


ChipThemeData _buildChipTheme(
    Color primaryColor,
    Color chipBackground,
    Brightness brightness,
    ) {
  return ChipThemeData(
    backgroundColor: primaryColor.withOpacity(0.12),
    disabledColor: primaryColor.withOpacity(0.87),
    selectedColor: primaryColor.withOpacity(0.05),
    secondarySelectedColor: chipBackground,
    padding: const EdgeInsets.all(4),
    shape: const StadiumBorder(),
    labelStyle: GoogleFonts.workSansTextTheme().bodyText2!.copyWith(
      color: brightness == Brightness.dark
          ? ReplyColors.white50
          : ReplyColors.black900,
    ),
    secondaryLabelStyle: GoogleFonts.workSansTextTheme().bodyText2!,
    brightness: brightness,
  );
}
