import 'package:flutter/material.dart';
import 'package:theme_extensions_builder_annotation/theme_extensions_builder_annotation.dart';

part 'app_colors.g.theme.dart';

@immutable
@themeExtensions
class AppColorsTheme extends ThemeExtension<AppColorsTheme>
    with _$ThemeExtensionMixin {
  const AppColorsTheme(
      {required this.supportSeparator,
      required this.supportOverlay,
      required this.labelPrimary,
      required this.labelSecondary,
      required this.labelTertiary,
      required this.labelDisable,
      required this.colorRed,
      required this.colorGreen,
      required this.colorBlue,
      required this.colorGray,
      required this.colorLightGray,
      required this.colorWhite,
      required this.backPrimary,
      required this.backSecondary,
      required this.backElevated});

  factory AppColorsTheme.light() {
    return const AppColorsTheme(
      supportSeparator: AppColors.lightSupportSeparator,
      supportOverlay: AppColors.lightSupportOverlay,
      labelPrimary: AppColors.lightLabelPrimary,
      labelSecondary: AppColors.lightLabelSecondary,
      labelTertiary: AppColors.lightLabelTertiary,
      labelDisable: AppColors.lightLabelDisable,
      colorRed: AppColors.lightColorRed,
      colorGreen: AppColors.lightColorGreen,
      colorBlue: AppColors.lightColorBlue,
      colorGray: AppColors.lightColorGray,
      colorLightGray: AppColors.lightColorLightGray,
      colorWhite: AppColors.lightColorWhite,
      backPrimary: AppColors.lightBackPrimary,
      backSecondary: AppColors.lightBackSecondary,
      backElevated: AppColors.lightBackElevated,
    );
  }

  factory AppColorsTheme.dark() {
    return const AppColorsTheme(
      supportSeparator: AppColors.darkSupportSeparator,
      supportOverlay: AppColors.darkSupportOverlay,
      labelPrimary: AppColors.darkLabelPrimary,
      labelSecondary: AppColors.darkLabelSecondary,
      labelTertiary: AppColors.darkLabelTertiary,
      labelDisable: AppColors.darkLabelDisable,
      colorRed: AppColors.darkColorRed,
      colorGreen: AppColors.darkColorGreen,
      colorBlue: AppColors.darkColorBlue,
      colorGray: AppColors.darkColorGray,
      colorLightGray: AppColors.darkColorLightGray,
      colorWhite: AppColors.darkColorWhite,
      backPrimary: AppColors.darkBackPrimary,
      backSecondary: AppColors.darkBackSecondary,
      backElevated: AppColors.darkBackElevated,
    );
  }

  final Color supportSeparator;
  final Color supportOverlay;
  final Color labelPrimary;
  final Color labelSecondary;
  final Color labelTertiary;
  final Color labelDisable;
  final Color colorRed;
  final Color colorGreen;
  final Color colorBlue;
  final Color colorGray;
  final Color colorLightGray;
  final Color colorWhite;
  final Color backPrimary;
  final Color backSecondary;
  final Color backElevated;
}

class AppColors {
  AppColors._();

  static const lightSupportSeparator = Color(0x33000000);
  static const lightSupportOverlay = Color(0x0F000000);
  static const lightLabelPrimary = Color(0xFF000000);
  static const lightLabelSecondary = Color(0x99000000);
  static const lightLabelTertiary = Color(0x4D000000);
  static const lightLabelDisable = Color(0x26000000);
  static const lightColorRed = Color(0xFFFF3B30);
  static const lightColorGreen = Color(0xFF34C759);
  static const lightColorBlue = Color(0xFF007AFF);
  static const lightColorGray = Color(0xFF8E8E93);
  static const lightColorLightGray = Color(0xFFD1D1D6);
  static const lightColorWhite = Color(0xFFFFFFFF);
  static const lightBackPrimary = Color(0xFFF7F6F2);
  static const lightBackSecondary = Color(0xFFFFFFFF);
  static const lightBackElevated = Color(0xFFFFFFFF);

  static const darkSupportSeparator = Color(0x33FFFFFF);
  static const darkSupportOverlay = Color(0x52000000);
  static const darkLabelPrimary = Color(0xFFFFFFFF);
  static const darkLabelSecondary = Color(0x99FFFFFF);
  static const darkLabelTertiary = Color(0x66FFFFFF);
  static const darkLabelDisable = Color(0x26FFFFFF);
  static const darkColorRed = Color(0xFFFF453A);
  static const darkColorGreen = Color(0xFF32D74B);
  static const darkColorBlue = Color(0xFF0A84FF);
  static const darkColorGray = Color(0xFF48484A);
  static const darkColorLightGray = Color(0xFFD1D1D6);
  static const darkColorWhite = Color(0xFFFFFFFF);
  static const darkBackPrimary = Color(0xFF161618);
  static const darkBackSecondary = Color(0xFF252528);
  static const darkBackElevated = Color(0xFF3C3C3F);
}
