import 'package:flutter/material.dart';
import 'color_manager.dart';
import 'font_manager.dart';
import 'style_manager.dart';
import 'value_manager.dart';

ThemeData getApplicationTheme() {
  return ThemeData(
      // main colors of the app
      primaryColor: ColorManager.primary,
      primaryColorDark: ColorManager.darkPrimary,
      primaryColorLight: ColorManager.primaryOpacity70,
      disabledColor: ColorManager.grey1,
      colorScheme:
          ColorScheme.fromSwatch().copyWith(secondary: ColorManager.grey),
      // accentColor replaced by ColorScheme.secondary

      // card view theme
      cardTheme: CardTheme(
          color: ColorManager.white,
          shadowColor: ColorManager.grey,
          elevation: AppSize.s4),

      // App bar theme
      appBarTheme: AppBarTheme(
          centerTitle: true,
          color: ColorManager.primary,
          elevation: AppSize.s4,
          shadowColor: ColorManager.primaryOpacity70,
          titleTextStyle: getRegularStyle(
              color: ColorManager.white, fontSize: FontSize.s16)),

      // Button theme
      buttonTheme: ButtonThemeData(
          shape: StadiumBorder(),
          disabledColor: ColorManager.grey1,
          buttonColor: ColorManager.primary,
          splashColor: ColorManager.primaryOpacity70),

      // elevation button theme
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
              textStyle: getRegularStyle(color: ColorManager.white),
              backgroundColor: ColorManager.primary,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(AppSize.s12)))),

      // Text theme
      textTheme: TextTheme(
          // headline1
          headlineLarge: getSemiBoldStyle(
              color: ColorManager.darkGrey, fontSize: FontSize.s18),
          // headline2
          headlineMedium:
              getBoldStyle(color: ColorManager.white, fontSize: FontSize.s16),
          // headline3
          headlineSmall: getRegularStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          // subtitle1
          titleLarge: getMediumStyle(
              color: ColorManager.lightGrey, fontSize: FontSize.s14),
          // subtitle2
          titleMedium: getMediumStyle(
              color: ColorManager.primary, fontSize: FontSize.s14),
          // caption
          displayLarge: getRegularStyle(color: ColorManager.grey1),
          // bodyText1
          bodyLarge: getRegularStyle(color: ColorManager.grey)),

      // input decoration theme (text from field)
      inputDecorationTheme: InputDecorationTheme(
        contentPadding: EdgeInsets.all(AppPadding.p8),
        // hint style
        hintStyle: getRegularStyle(color: ColorManager.grey1),
        // label style
        labelStyle: getMediumStyle(color: ColorManager.darkGrey),
        // error style
        errorStyle: getRegularStyle(color: ColorManager.error),

        // enabled border
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorManager.grey, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        // focused border
        focusedBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        // error border
        errorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.error, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
        // focused error border
        focusedErrorBorder: OutlineInputBorder(
          borderSide:
              BorderSide(color: ColorManager.primary, width: AppSize.s1_5),
          borderRadius: BorderRadius.all(Radius.circular(AppSize.s8)),
        ),
      ));
}
