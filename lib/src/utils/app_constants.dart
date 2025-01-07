import 'dart:ui';

class WebEvent {
  static const String AUTH_SUCCESS = "auth_success";
  static const String G_AUTH = "g_auth";
  static const String GO_BACK = "go_back";
  static const String COPY_TEXT = "copy_text";
}

abstract class DefaultTheme {
  static const Color textPrimaryColor = Color(0xFFFFFFFF);
  static const Color textSecondaryColor = Color(0xFFFFFFFF);
  static const Color textTertiaryColor = Color(0xFFFFFFFF);
  static const Color accent1Color = Color(0xFF905BF5);
  static const Color accent2Color = Color(0x80905BF5);
  static const Color strokeBorderColor = Color(0xFFACACAB);
  static const Color strokeDividerColor = Color(0x4DA8A8A8);
  static const Color surfaceColor = Color(0xFF262528);
  static const Color backgroundColor = Color(0xFF000000);
}