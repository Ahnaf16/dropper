import 'package:flutter/material.dart';

extension RouteEx on BuildContext {
  void nPop<T extends Object?>([T? result]) => Navigator.of(this).pop(result);

  void nPush<T extends Object?>(Widget page, {bool? isFullScreen}) {
    final route = MaterialPageRoute(
      builder: (c) => page,
      fullscreenDialog: isFullScreen ?? false,
    );
    Navigator.of(this).push(route);
  }
}

extension ContextEx on BuildContext {
  MediaQueryData get mq => MediaQuery.of(this);

  Size get size => MediaQuery.sizeOf(this);
  double get height => size.height;
  double get width => size.width;

  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colors => theme.colorScheme;

  Brightness get bright => theme.brightness;

  bool get isDark => bright == Brightness.dark;
  bool get isLight => bright == Brightness.light;
}
