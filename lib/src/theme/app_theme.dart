import 'package:flutter/material.dart';

import '../utils/app_constants.dart';

abstract class AppTheme extends ThemeExtension<AppTheme> {
  Color get textPrimaryColor;

  Color get textSecondaryColor;

  Color get textTertiaryColor;

  Color get accent1Color;

  Color get accent2Color;

  Color get strokeBorderColor;

  Color get strokeDividerColor;

  Color get surfaceColor;

  Color get backgroundColor;
}

class VendorTheme implements AppTheme {
  Color _textPrimaryColor = DefaultTheme.textPrimaryColor;
  Color _textSecondaryColor = DefaultTheme.textSecondaryColor;
  Color _textTertiaryColor = DefaultTheme.textTertiaryColor;
  Color _accent1Color = DefaultTheme.accent1Color;
  Color _accent2Color = DefaultTheme.accent2Color;
  Color _strokeBorderColor = DefaultTheme.strokeBorderColor;
  Color _strokeDividerColor = DefaultTheme.strokeDividerColor;
  Color _surfaceColor = DefaultTheme.surfaceColor;
  Color _backgroundColor = DefaultTheme.backgroundColor;

  VendorTheme({
    Color? textPrimaryColor,
    Color? textSecondaryColor,
    Color? textTertiaryColor,
    Color? accent1Color,
    Color? accent2Color,
    Color? strokeBorderColor,
    Color? strokeDividerColor,
    Color? surfaceColor,
    Color? backgroundColor,
  }) {
    _textPrimaryColor = textPrimaryColor ?? DefaultTheme.textPrimaryColor;
    _textSecondaryColor = textSecondaryColor ?? DefaultTheme.textSecondaryColor;
    _textTertiaryColor = textTertiaryColor ?? DefaultTheme.textTertiaryColor;
    _accent1Color = accent1Color ?? DefaultTheme.accent1Color;
    _accent2Color = accent2Color ?? DefaultTheme.accent2Color;
    _strokeBorderColor = strokeBorderColor ?? DefaultTheme.strokeBorderColor;
    _strokeDividerColor = strokeDividerColor ?? DefaultTheme.strokeDividerColor;
    _surfaceColor = surfaceColor ?? DefaultTheme.surfaceColor;
    _backgroundColor = backgroundColor ?? DefaultTheme.backgroundColor;
  }

  @override
  Object get type => VendorTheme;

  @override
  Color get textPrimaryColor => _textPrimaryColor;

  @override
  Color get textSecondaryColor => _textSecondaryColor;

  @override
  Color get textTertiaryColor => _textTertiaryColor;

  @override
  Color get accent1Color => _accent1Color;

  @override
  Color get accent2Color => _accent2Color;

  @override
  Color get strokeBorderColor => _strokeBorderColor;

  @override
  Color get strokeDividerColor => _strokeDividerColor;

  @override
  Color get surfaceColor => _surfaceColor;

  @override
  Color get backgroundColor => _backgroundColor;

  @override
  ThemeExtension<AppTheme> copyWith(
      {Color? textPrimaryColor,
      Color? textSecondaryColor,
      Color? textTertiaryColor,
      Color? accent1Color,
      Color? accent2Color,
      Color? strokeBorderColor,
      Color? strokeDividerColor,
      Color? surfaceColor,
      Color? backgroundColor}) {
    return VendorTheme(
      textPrimaryColor: textPrimaryColor ?? _textPrimaryColor,
      textSecondaryColor: textSecondaryColor ?? _textSecondaryColor,
      textTertiaryColor: textTertiaryColor ?? _textTertiaryColor,
      accent1Color: accent1Color ?? _accent1Color,
      accent2Color: accent2Color ?? _accent2Color,
      strokeBorderColor: strokeBorderColor ?? _strokeBorderColor,
      strokeDividerColor: strokeDividerColor ?? _strokeDividerColor,
      surfaceColor: surfaceColor ?? _surfaceColor,
      backgroundColor: backgroundColor ?? _backgroundColor,
    );
  }

  @override
  ThemeExtension<AppTheme> lerp(
      covariant ThemeExtension<AppTheme>? other, double t) {
    return this;
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other.runtimeType != runtimeType) return false;
    return other is VendorTheme &&
        _textPrimaryColor == other._textPrimaryColor &&
        _textSecondaryColor == other._textSecondaryColor &&
        _textTertiaryColor == other._textTertiaryColor &&
        _accent1Color == other._accent1Color &&
        _accent2Color == other._accent2Color &&
        _strokeBorderColor == other._strokeBorderColor &&
        _strokeDividerColor == other._strokeDividerColor &&
        _surfaceColor == other._surfaceColor &&
        _backgroundColor == other._backgroundColor;
  }

  @override
  int get hashCode {
    return Object.hash(
      _textPrimaryColor,
      _textSecondaryColor,
      _textTertiaryColor,
      _accent1Color,
      _accent2Color,
      _strokeBorderColor,
      _strokeDividerColor,
      _surfaceColor,
      _backgroundColor,
    );
  }
}
