import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:cashier_app/themes/color_pallete.dart';
import 'package:get/get.dart';

class Themes {
  /// Theme for light mode
  static ThemeData lightTheme(BuildContext context) {
    settingStatusBarColor(isDark: false);
    return ThemeData(
        cardColor: Pallete.lightSecBackground,
        primaryColor: Pallete.primary,
        shadowColor: Pallete.lightShadow,
        colorScheme: const ColorScheme.light(
            primary: Pallete.primary,
            surface: Pallete.lightBackground,
            secondary: Pallete.lightSecBackground,
            error: Colors.red),
        unselectedWidgetColor: Pallete.lightunselectedColor,
        visualDensity: VisualDensity.comfortable,
        scaffoldBackgroundColor: Pallete.lightBackground,
        applyElevationOverlayColor: false,
        radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.resolveWith(
                (states) => Get.theme.primaryColor)),
        bannerTheme: const MaterialBannerThemeData(
            backgroundColor: Pallete.lightBackground,
            padding: EdgeInsets.all(16),
            leadingPadding: EdgeInsets.all(12.0),
            contentTextStyle:
                TextStyle(color: Pallete.darkText, fontSize: 14.0)),
        buttonTheme: ButtonThemeData(
            buttonColor: Pallete.primary,
            height: 44.0,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 300),
          foregroundColor:
              WidgetStateProperty.resolveWith((states) => Pallete.lightShadow),
          backgroundColor: WidgetStateProperty.resolveWith(
              (states) => Get.theme.primaryColor),
          textStyle: WidgetStateProperty.resolveWith(
            (states) => const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.7,
              color: Pallete.darkText,
            ),
          ),
          fixedSize: WidgetStateProperty.resolveWith(
            (states) => Size(Get.width, 48.0),
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: WidgetStateProperty.resolveWith((states) => 0.0),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 500),
            foregroundColor:
                WidgetStateProperty.resolveWith((states) => Colors.black),
            textStyle: WidgetStateProperty.resolveWith(
              (states) => const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.7,
                color: Pallete.darkText,
              ),
            ),
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: Colors.grey[700]!,
                width: 1.0,
              ),
            ),
            fixedSize: WidgetStateProperty.resolveWith(
              (states) => Size(Size.infinite.width, 48.0),
            ),
            shape: WidgetStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            elevation: WidgetStateProperty.resolveWith((states) => 0.0),
          ),
        ),
        // dialogTheme removed to match current ThemeData expected types
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
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.white,
          elevation: 1.0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 1.0,
            enableFeedback: true),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 1.0,
          modalBackgroundColor: Colors.black12,
          constraints: BoxConstraints(
              minWidth: double.infinity, minHeight: 200.0, maxHeight: 560.0),
        ),
        // cardTheme removed to match current ThemeData expected types
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
    settingStatusBarColor(isDark: true);
    return ThemeData(
        cardColor: Pallete.darkSecBackground,
        primaryColor: Pallete.primary,
        shadowColor: Pallete.darkShadow,
        colorScheme: const ColorScheme.dark(
            primary: Pallete.primary,
            // onPrimaryContainer: Pallete.darkSelectedColor,
            outline: Pallete.white,
            surface: Pallete.darkBackground,
            secondary: Pallete.darkSecBackground,
            error: Colors.red),
        unselectedWidgetColor: Pallete.darkunselectedColor,
        visualDensity: VisualDensity.comfortable,
        scaffoldBackgroundColor: Pallete.darkBackground,
        applyElevationOverlayColor: false,
        radioTheme: RadioThemeData(
            fillColor: WidgetStateProperty.resolveWith(
                (states) => Get.theme.primaryColor)),
        bannerTheme: const MaterialBannerThemeData(
            backgroundColor: Pallete.darkBackground,
            padding: EdgeInsets.all(16),
            leadingPadding: EdgeInsets.all(12.0),
            contentTextStyle:
                TextStyle(color: Pallete.lighterText, fontSize: 14.0)),
        buttonTheme: ButtonThemeData(
            buttonColor: Pallete.primary,
            height: 44.0,
            textTheme: ButtonTextTheme.primary,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0))),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ButtonStyle(
          animationDuration: const Duration(milliseconds: 300),
          foregroundColor:
              WidgetStateProperty.resolveWith((states) => Pallete.darkShadow),
          backgroundColor: WidgetStateProperty.resolveWith(
              (states) => Get.theme.primaryColor),
          textStyle: WidgetStateProperty.resolveWith(
            (states) => const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.normal,
              letterSpacing: 0.7,
              color: Pallete.lighterText,
            ),
          ),
          fixedSize: WidgetStateProperty.resolveWith(
            (states) => Size(Get.width, 48.0),
          ),
          shape: WidgetStateProperty.resolveWith(
            (states) => RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
          ),
          elevation: WidgetStateProperty.resolveWith((states) => 0.0),
        )),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            animationDuration: const Duration(milliseconds: 500),
            foregroundColor:
                WidgetStateProperty.resolveWith((states) => Colors.black),
            textStyle: WidgetStateProperty.resolveWith(
              (states) => const TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.normal,
                letterSpacing: 0.7,
                color: Pallete.lighterText,
              ),
            ),
            side: WidgetStateProperty.resolveWith(
              (states) => BorderSide(
                color: Colors.grey[200]!,
                width: 1.0,
              ),
            ),
            fixedSize: WidgetStateProperty.resolveWith(
              (states) => Size(Size.infinite.width, 48.0),
            ),
            shape: WidgetStateProperty.resolveWith(
              (states) => RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.0),
              ),
            ),
            elevation: WidgetStateProperty.resolveWith((states) => 0.0),
          ),
        ),
        // dialogTheme removed to match current ThemeData expected types
        inputDecorationTheme: InputDecorationTheme(
          border: InputBorder.none,
          hintStyle: const TextStyle(
            fontSize: 13.0,
            fontWeight: FontWeight.normal,
            height: 1.5,
            color: Pallete.darkCursorColor,
          ),
          filled: true,
          fillColor: Pallete.darkFormBackground,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12.0),
            borderSide: const BorderSide(color: Pallete.darkunselectedColor),
          ),
          focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: const BorderSide(color: Pallete.darkCursorColor)),
          errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.0),
              borderSide: BorderSide.none),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16.0,
            vertical: 16.0,
          ),
        ),
        bottomAppBarTheme: const BottomAppBarThemeData(
          color: Colors.grey,
          elevation: 1.0,
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
            backgroundColor: Colors.white,
            elevation: 1.0,
            enableFeedback: true),
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: Colors.white,
          elevation: 1.0,
          modalBackgroundColor: Colors.black12,
          constraints: BoxConstraints(
              minWidth: double.infinity, minHeight: 200.0, maxHeight: 560.0),
        ),
        // cardTheme removed to match current ThemeData expected types
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
        // errorColor removed; use colorScheme.error instead
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
          systemNavigationBarColor: Pallete.darkLine,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    } else {
      SystemChrome.setSystemUIOverlayStyle(
        const SystemUiOverlayStyle(
          statusBarBrightness: Brightness.light,
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
          systemNavigationBarColor: Pallete.darkLine,
          systemNavigationBarIconBrightness: Brightness.light,
        ),
      );
    }
  }
}

TextTheme _textTheme(Color colors) {
  return TextTheme(
    headlineLarge: TextStyle(
        fontFamily: "Heebo",
        fontSize: 34,
        color: colors,
        fontWeight: FontWeight.w700),
    headlineMedium: TextStyle(
        fontFamily: "Heebo",
        fontSize: 34,
        color: colors,
        fontWeight: FontWeight.w500),
    headlineSmall: TextStyle(
        fontFamily: "Heebo",
        fontSize: 24,
        color: colors,
        fontWeight: FontWeight.w700),
    displayLarge: TextStyle(
        fontFamily: "Heebo",
        fontSize: 90,
        color: colors,
        fontWeight: FontWeight.w100),
    displayMedium: TextStyle(
        fontFamily: "Heebo",
        fontSize: 60,
        color: colors,
        fontWeight: FontWeight.w100),
    displaySmall: TextStyle(
        fontFamily: "Heebo",
        fontSize: 48,
        color: colors,
        fontWeight: FontWeight.w500),
    bodyLarge: TextStyle(
        fontFamily: "Heebo",
        fontSize: 16,
        color: colors,
        fontWeight: FontWeight.w500),
    bodyMedium: TextStyle(
        fontFamily: "Heebo",
        fontSize: 14,
        color: colors,
        fontWeight: FontWeight.w500),
    bodySmall: TextStyle(
        fontFamily: "Heebo",
        fontSize: 12,
        color: colors,
        fontWeight: FontWeight.w500),
    labelLarge: TextStyle(
        fontFamily: "Heebo",
        fontSize: 14,
        color: colors,
        fontWeight: FontWeight.w700),
    labelMedium: TextStyle(
        fontFamily: "Heebo",
        fontSize: 12,
        color: colors,
        fontWeight: FontWeight.w500),
    labelSmall: TextStyle(
        fontFamily: "Heebo",
        fontSize: 10,
        color: colors,
        fontWeight: FontWeight.w500),
    titleLarge: TextStyle(
        fontFamily: "Heebo",
        fontSize: 20,
        color: colors,
        fontWeight: FontWeight.w700),
    titleMedium: TextStyle(
        fontFamily: "Heebo",
        fontSize: 16,
        color: colors,
        fontWeight: FontWeight.w500),
    titleSmall: TextStyle(
        fontFamily: "Heebo",
        fontSize: 14,
        color: colors,
        fontWeight: FontWeight.w700),
  );
}
