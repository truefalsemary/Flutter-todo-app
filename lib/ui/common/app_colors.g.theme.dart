// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, unused_element

part of 'app_colors.dart';

// **************************************************************************
// ThemeExtensionsGenerator
// **************************************************************************

mixin _$ThemeExtensionMixin on ThemeExtension<AppColorsTheme> {
  @override
  ThemeExtension<AppColorsTheme> copyWith({
    Color? supportSeparator,
    Color? supportOverlay,
    Color? labelPrimary,
    Color? labelSecondary,
    Color? labelTertiary,
    Color? labelDisable,
    Color? colorRed,
    Color? colorGreen,
    Color? colorBlue,
    Color? colorGray,
    Color? colorLightGray,
    Color? colorWhite,
    Color? backPrimary,
    Color? backSecondary,
    Color? backElevated,
  }) {
    final object = this as AppColorsTheme;

    return AppColorsTheme(
      supportSeparator: supportSeparator ?? object.supportSeparator,
      supportOverlay: supportOverlay ?? object.supportOverlay,
      labelPrimary: labelPrimary ?? object.labelPrimary,
      labelSecondary: labelSecondary ?? object.labelSecondary,
      labelTertiary: labelTertiary ?? object.labelTertiary,
      labelDisable: labelDisable ?? object.labelDisable,
      colorRed: colorRed ?? object.colorRed,
      colorGreen: colorGreen ?? object.colorGreen,
      colorBlue: colorBlue ?? object.colorBlue,
      colorGray: colorGray ?? object.colorGray,
      colorLightGray: colorLightGray ?? object.colorLightGray,
      colorWhite: colorWhite ?? object.colorWhite,
      backPrimary: backPrimary ?? object.backPrimary,
      backSecondary: backSecondary ?? object.backSecondary,
      backElevated: backElevated ?? object.backElevated,
    );
  }

  @override
  ThemeExtension<AppColorsTheme> lerp(
    ThemeExtension<AppColorsTheme>? other,
    double t,
  ) {
    final otherValue = other;

    if (otherValue is! AppColorsTheme) {
      return this;
    }

    final value = this as AppColorsTheme;

    return AppColorsTheme(
      supportSeparator: Color.lerp(
        value.supportSeparator,
        otherValue.supportSeparator,
        t,
      )!,
      supportOverlay: Color.lerp(
        value.supportOverlay,
        otherValue.supportOverlay,
        t,
      )!,
      labelPrimary: Color.lerp(
        value.labelPrimary,
        otherValue.labelPrimary,
        t,
      )!,
      labelSecondary: Color.lerp(
        value.labelSecondary,
        otherValue.labelSecondary,
        t,
      )!,
      labelTertiary: Color.lerp(
        value.labelTertiary,
        otherValue.labelTertiary,
        t,
      )!,
      labelDisable: Color.lerp(
        value.labelDisable,
        otherValue.labelDisable,
        t,
      )!,
      colorRed: Color.lerp(
        value.colorRed,
        otherValue.colorRed,
        t,
      )!,
      colorGreen: Color.lerp(
        value.colorGreen,
        otherValue.colorGreen,
        t,
      )!,
      colorBlue: Color.lerp(
        value.colorBlue,
        otherValue.colorBlue,
        t,
      )!,
      colorGray: Color.lerp(
        value.colorGray,
        otherValue.colorGray,
        t,
      )!,
      colorLightGray: Color.lerp(
        value.colorLightGray,
        otherValue.colorLightGray,
        t,
      )!,
      colorWhite: Color.lerp(
        value.colorWhite,
        otherValue.colorWhite,
        t,
      )!,
      backPrimary: Color.lerp(
        value.backPrimary,
        otherValue.backPrimary,
        t,
      )!,
      backSecondary: Color.lerp(
        value.backSecondary,
        otherValue.backSecondary,
        t,
      )!,
      backElevated: Color.lerp(
        value.backElevated,
        otherValue.backElevated,
        t,
      )!,
    );
  }

  @override
  bool operator ==(Object other) {
    final value = this as AppColorsTheme;

    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is AppColorsTheme &&
            identical(value.supportSeparator, other.supportSeparator) &&
            identical(value.supportOverlay, other.supportOverlay) &&
            identical(value.labelPrimary, other.labelPrimary) &&
            identical(value.labelSecondary, other.labelSecondary) &&
            identical(value.labelTertiary, other.labelTertiary) &&
            identical(value.labelDisable, other.labelDisable) &&
            identical(value.colorRed, other.colorRed) &&
            identical(value.colorGreen, other.colorGreen) &&
            identical(value.colorBlue, other.colorBlue) &&
            identical(value.colorGray, other.colorGray) &&
            identical(value.colorLightGray, other.colorLightGray) &&
            identical(value.colorWhite, other.colorWhite) &&
            identical(value.backPrimary, other.backPrimary) &&
            identical(value.backSecondary, other.backSecondary) &&
            identical(value.backElevated, other.backElevated));
  }

  @override
  int get hashCode {
    final value = this as AppColorsTheme;

    return Object.hash(
      runtimeType,
      value.supportSeparator,
      value.supportOverlay,
      value.labelPrimary,
      value.labelSecondary,
      value.labelTertiary,
      value.labelDisable,
      value.colorRed,
      value.colorGreen,
      value.colorBlue,
      value.colorGray,
      value.colorLightGray,
      value.colorWhite,
      value.backPrimary,
      value.backSecondary,
      value.backElevated,
    );
  }
}

extension AppColorsBuildContext on BuildContext {
  AppColorsTheme get appColors => Theme.of(this).extension<AppColorsTheme>()!;
}
