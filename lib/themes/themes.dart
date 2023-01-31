import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:get/get.dart';

class Themes {
  /// Theme for light mode
  static ThemeData lightTheme(BuildContext context) {
    return ThemeData(
        cardColor: Pallete.white,
        primaryColor: Pallete.primary,
        shadowColor: Pallete.lightShadow,
        colorScheme:
            const ColorScheme.light(primary: Pallete.primary, background: Pallete.lightBackground),
        unselectedWidgetColor: Pallete.lightunselectedColor,
        visualDensity: VisualDensity.comfortable,
        scaffoldBackgroundColor: Pallete.lightBackground,
        applyElevationOverlayColor: false,
        radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.resolveWith((states) => Get.theme.primaryColor)),
        bannerTheme: const MaterialBannerThemeData(
            backgroundColor: Pallete.lightBackground,
            padding: EdgeInsets.all(16),
            leadingPadding: EdgeInsets.all(12.0),
            contentTextStyle: TextStyle(color: Pallete.darkText, fontSize: 14.0)),
        buttonTheme: ButtonThemeData(
            buttonColor: Pallete.primary,
            height: 44.0,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 300),
          foregroundColor: MaterialStateProperty.resolveWith((states) => Pallete.lightShadow),
          backgroundColor: MaterialStateProperty.resolveWith((states) => Get.theme.primaryColor),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.7,
              color: Pallete.darkText,
            ),
          ),
          fixedSize: MaterialStateProperty.resolveWith(
            (states) => Size(Get.width, 48.0),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: MaterialStateProperty.resolveWith((states) => 0.0),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 500),
            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
            textStyle: MaterialStateProperty.resolveWith(
              (states) => const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.7,
                color: Pallete.darkText,
              ),
            ),
            side: MaterialStateProperty.resolveWith(
              (states) => BorderSide(
                color: Colors.grey[700]!,
                width: 1.0,
              ),
            ),
            fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size(Size.infinite.width, 48.0),
            ),
            shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            elevation: MaterialStateProperty.resolveWith((states) => 0.0),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Colors.white,
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontFamily: "Rubik",
            fontSize: 16.0,
            color: Pallete.grayText,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontSize: 14.0,
            height: 1.23,
            color: Colors.grey[600]!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
            height: 1.5,
            color: Colors.black54,
          ),
          filled: true,
          fillColor: Colors.grey[100],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.white,
          elevation: 1.0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white, elevation: 1.0, enableFeedback: true),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 1.0,
          modalBackgroundColor: Colors.black12,
          constraints:
              BoxConstraints(minWidth: double.infinity, minHeight: 200.0, maxHeight: 560.0),
        ),
        cardTheme: const CardTheme(
            color: Colors.white,
            margin: EdgeInsets.all(16.0),
            shadowColor: Colors.black12,
            elevation: 1.0),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[100]!,
          disabledColor: Colors.grey[100]!,
          selectedColor: const Color(0xFF75DF1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          secondarySelectedColor: const Color(0xFF75DF1C),
          elevation: 0,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
          ),
          secondaryLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
          ),
          brightness: Brightness.light,
        ),
        brightness: Brightness.light,
        appBarTheme: const AppBarTheme(
          elevation: 1.0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.light,
            statusBarColor: Pallete.primary,
            statusBarIconBrightness: Brightness.light,
            systemNavigationBarColor: Pallete.primary,
            systemNavigationBarIconBrightness: Brightness.light,
          ),
          backgroundColor: Pallete.transparent,
          titleTextStyle: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            color: Pallete.darkText,
          ),
          iconTheme: IconThemeData(
            color: Pallete.white,
            size: 18.0,
          ),
        ),
        iconTheme: IconThemeData(
          size: 20.0,
          color: Colors.blueGrey[800],
          opacity: 1.0,
        ),
        primaryIconTheme: const IconThemeData(
          size: 20.0,
          color: Pallete.white,
        ),
        sliderTheme: SliderThemeData(
          inactiveTrackColor: Colors.grey[200],
        ),
        textTheme: _textTheme(Pallete.darkText));
  }

  static ThemeData darkTheme(BuildContext context) {
    return ThemeData(
        cardColor: Pallete.white,
        primaryColor: Pallete.primary,
        shadowColor: Pallete.darkShadow,
        colorScheme:
            const ColorScheme.dark(primary: Pallete.primary, background: Pallete.darkBackground),
        unselectedWidgetColor: Pallete.darkunselectedColor,
        visualDensity: VisualDensity.comfortable,
        scaffoldBackgroundColor: Pallete.darkBackground,
        applyElevationOverlayColor: false,
        radioTheme: RadioThemeData(
            fillColor: MaterialStateProperty.resolveWith((states) => Get.theme.primaryColor)),
        bannerTheme: const MaterialBannerThemeData(
            backgroundColor: Pallete.darkBackground,
            padding: EdgeInsets.all(16),
            leadingPadding: EdgeInsets.all(12.0),
            contentTextStyle: TextStyle(color: Pallete.lighterText, fontSize: 14.0)),
        buttonTheme: ButtonThemeData(
            buttonColor: Pallete.primary,
            height: 44.0,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 300),
          foregroundColor: MaterialStateProperty.resolveWith((states) => Pallete.darkShadow),
          backgroundColor: MaterialStateProperty.resolveWith((states) => Get.theme.primaryColor),
          textStyle: MaterialStateProperty.resolveWith(
            (states) => const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.7,
              color: Pallete.lighterText,
            ),
          ),
          fixedSize: MaterialStateProperty.resolveWith(
            (states) => Size(Get.width, 48.0),
          ),
          shape: MaterialStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: MaterialStateProperty.resolveWith((states) => 0.0),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 500),
            foregroundColor: MaterialStateProperty.resolveWith((states) => Colors.black),
            textStyle: MaterialStateProperty.resolveWith(
              (states) => const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.7,
                color: Pallete.lighterText,
              ),
            ),
            side: MaterialStateProperty.resolveWith(
              (states) => BorderSide(
                color: Colors.grey[200]!,
                width: 1.0,
              ),
            ),
            fixedSize: MaterialStateProperty.resolveWith(
              (states) => Size(Size.infinite.width, 48.0),
            ),
            shape: MaterialStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            elevation: MaterialStateProperty.resolveWith((states) => 0.0),
          ),
        ),
        dialogTheme: DialogTheme(
          backgroundColor: Pallete.darkSecBackground,
          elevation: 0,
          titleTextStyle: const TextStyle(
            fontFamily: "Rubik",
            fontSize: 16.0,
            color: Pallete.lightText,
            fontWeight: FontWeight.bold,
          ),
          contentTextStyle: TextStyle(
            fontSize: 14.0,
            height: 1.23,
            color: Colors.grey[400]!,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          ),
        ),
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
            height: 1.5,
            color: Colors.white54,
          ),
          filled: true,
          fillColor: Colors.grey[800],
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0), borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarTheme(
          color: Colors.grey,
          elevation: 1.0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white, elevation: 1.0, enableFeedback: true),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 1.0,
          modalBackgroundColor: Colors.black12,
          constraints:
              BoxConstraints(minWidth: double.infinity, minHeight: 200.0, maxHeight: 560.0),
        ),
        cardTheme: const CardTheme(
            color: Colors.white,
            margin: EdgeInsets.all(16.0),
            shadowColor: Colors.black12,
            elevation: 1.0),
        chipTheme: ChipThemeData(
          backgroundColor: Colors.grey[100]!,
          disabledColor: Colors.grey[100]!,
          selectedColor: const Color(0xFF75DF1C),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          secondarySelectedColor: const Color(0xFF75DF1C),
          elevation: 0,
          labelPadding: const EdgeInsets.symmetric(horizontal: 12.0),
          shadowColor: Colors.transparent,
          selectedShadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
          labelStyle: const TextStyle(
            color: Colors.black54,
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
          ),
          secondaryLabelStyle: const TextStyle(
            color: Colors.white,
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
          ),
          brightness: Brightness.dark,
        ),
        brightness: Brightness.dark,
        appBarTheme: const AppBarTheme(
          elevation: 1.0,
          centerTitle: true,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Pallete.primary,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Pallete.primary,
            systemNavigationBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Pallete.transparent,
          titleTextStyle: TextStyle(
            fontSize: 17.0,
            fontWeight: FontWeight.w700,
            color: Pallete.darkText,
          ),
          iconTheme: IconThemeData(
            color: Pallete.white,
            size: 18.0,
          ),
        ),
        errorColor: Colors.red,
        iconTheme: IconThemeData(
          size: 20.0,
          color: Colors.blueGrey[800],
          opacity: 1.0,
        ),
        primaryIconTheme: const IconThemeData(
          size: 20.0,
          color: Pallete.white,
        ),
        sliderTheme: SliderThemeData(
          inactiveTrackColor: Colors.grey[200],
        ),
        textTheme: _textTheme(Pallete.lighterText));
  }

  static settingStatusBarColor({bool isDark = false}) {
    if (isDark) {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.light,
          systemNavigationBarColor: Colors.white,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Colors.black,
          systemNavigationBarIconBrightness: Brightness.dark,
        ),
      );
    }
  }
}

TextTheme _textTheme(Color colors) {
  return TextTheme(
    headlineLarge:
        TextStyle(fontFamily: "Heebo", fontSize: 34, color: colors, fontWeight: FontWeight.w700),
    headlineMedium:
        TextStyle(fontFamily: "Heebo", fontSize: 34, color: colors, fontWeight: FontWeight.w500),
    headlineSmall:
        TextStyle(fontFamily: "Heebo", fontSize: 24, color: colors, fontWeight: FontWeight.w700),
    displayLarge:
        TextStyle(fontFamily: "Heebo", fontSize: 90, color: colors, fontWeight: FontWeight.w100),
    displayMedium:
        TextStyle(fontFamily: "Heebo", fontSize: 60, color: colors, fontWeight: FontWeight.w100),
    displaySmall:
        TextStyle(fontFamily: "Heebo", fontSize: 48, color: colors, fontWeight: FontWeight.w500),
    bodyLarge:
        TextStyle(fontFamily: "Heebo", fontSize: 16, color: colors, fontWeight: FontWeight.w500),
    bodyMedium:
        TextStyle(fontFamily: "Heebo", fontSize: 14, color: colors, fontWeight: FontWeight.w500),
    bodySmall:
        TextStyle(fontFamily: "Heebo", fontSize: 12, color: colors, fontWeight: FontWeight.w500),
    labelLarge:
        TextStyle(fontFamily: "Heebo", fontSize: 14, color: colors, fontWeight: FontWeight.w700),
    labelMedium:
        TextStyle(fontFamily: "Heebo", fontSize: 12, color: colors, fontWeight: FontWeight.w500),
    labelSmall:
        TextStyle(fontFamily: "Heebo", fontSize: 10, color: colors, fontWeight: FontWeight.w500),
    titleLarge:
        TextStyle(fontFamily: "Heebo", fontSize: 20, color: colors, fontWeight: FontWeight.w700),
    titleMedium:
        TextStyle(fontFamily: "Heebo", fontSize: 16, color: colors, fontWeight: FontWeight.w500),
    titleSmall:
        TextStyle(fontFamily: "Heebo", fontSize: 14, color: colors, fontWeight: FontWeight.w700),
  );
}
