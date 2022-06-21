import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:commune_app/app/shared/tool/constants.dart';
import 'color_palettes.dart';

import 'package:commune_app/app/shared/models/theme/theme_data.dart';


// Styling for text
final TextTheme _myTextTheme = TextTheme(
  headline1:
      TextStyle(fontSize: 92, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2:
      TextStyle(fontSize: 57, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: TextStyle(fontSize: 46, fontWeight: FontWeight.w400),
  headline4:
      TextStyle(fontSize: 32, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: TextStyle(fontSize: 23, fontWeight: FontWeight.w400),
  headline6:
      TextStyle(fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1:
      TextStyle(fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2:
      TextStyle(fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1:
      TextStyle(fontSize: 16, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button:
      TextStyle(fontSize: 14, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption:
      TextStyle(fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline:
      TextStyle(fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

// Styling for light theme
ThemeData lightTheme = ThemeData(
  fontFamily: 'IBMPlexSans',
  backgroundColor: Modular.get<ColorPalettes>().lightBG,
  primaryColor: Modular.get<ColorPalettes>().lightPrimary,
  accentColor: Modular.get<ColorPalettes>().lightAccent,
  cursorColor: Modular.get<ColorPalettes>().lightAccent,
  dividerColor: Modular.get<ColorPalettes>().darkBG,
  scaffoldBackgroundColor: Modular.get<ColorPalettes>().lightBG,
  textTheme: _myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme:
        _myTextTheme.apply(bodyColor: Modular.get<ColorPalettes>().darkPrimary),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Modular.get<ColorPalettes>().lightAccent,
    unselectedItemColor: Colors.grey,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Modular.get<ColorPalettes>().lightAccent,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
  ),
);

// Styling for dark theme
ThemeData darkTheme = ThemeData(
  fontFamily: 'IBMPlexSans',
  brightness: Brightness.dark,
  backgroundColor: Modular.get<ColorPalettes>().darkBG,
  primaryColor: Modular.get<ColorPalettes>().darkPrimary,
  accentColor: Modular.get<ColorPalettes>().darkAccent,
  dividerColor: Modular.get<ColorPalettes>().lightPrimary,
  scaffoldBackgroundColor: Modular.get<ColorPalettes>().darkBG,
  cursorColor: Modular.get<ColorPalettes>().darkAccent,
  textTheme: _myTextTheme,
  appBarTheme: AppBarTheme(
    textTheme: _myTextTheme.apply(
        bodyColor: Modular.get<ColorPalettes>().lightPrimary),
    elevation: 0,
  ),
  bottomNavigationBarTheme: BottomNavigationBarThemeData(
    selectedItemColor: Modular.get<ColorPalettes>().darkAccent,
    unselectedItemColor: Colors.grey,
  ),
  buttonTheme: ButtonThemeData(
    buttonColor: Modular.get<ColorPalettes>().darkAccent,
    textTheme: ButtonTextTheme.primary,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.all(
        Radius.circular(0),
      ),
    ),
  ),
);


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
        break;
      case THEME_MODE.LIGHT:
        return CustomTheme.light();
        break;
      default:
        break;
    }
  }

}

final ThemeData lightThemeData = ThemeData.light().copyWith(
  brightness: Brightness.light,
  primaryColor: Colors.red,
  primaryColorDark: Colors.red,
  backgroundColor: Colors.white,
  accentColor: Colors.redAccent,
  bottomAppBarColor: Colors.white,
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
    brightness: Brightness.light,
    primaryColor: Colors.redAccent,
    primaryColorDark: Colors.red,
    backgroundColor: Colors.red,
    accentColor: Colors.red,
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