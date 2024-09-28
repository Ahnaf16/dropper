import 'package:flutter/material.dart';
import 'package:flutter_acrylic/window.dart';
import 'package:flutter_acrylic/window_effect.dart';
import 'package:hotkey_system/hotkey_system.dart';
import 'package:window_manager/window_manager.dart';

const kWindowSize = Size(200, 240);
const kWindowSizeExpanded = Size(550, 500);

Future<void> appStartUp() async {
  WidgetsFlutterBinding.ensureInitialized();
  await windowManager.ensureInitialized();
  await Window.initialize();
  await hotKeySystem.unregisterAll();
  await _setupHotKye();
  await _setUpWindow();
}

Future<void> _setUpWindow() async {
  const options = WindowOptions(
    size: kWindowSize,
    center: true,
    alwaysOnTop: true,
    windowButtonVisibility: false,
    skipTaskbar: true,
    titleBarStyle: TitleBarStyle.hidden,
  );

  windowManager.waitUntilReadyToShow(
    options,
    () async {
      await windowManager.setResizable(false);
      await Window.setEffect(
        effect: WindowEffect.acrylic,
        color: const Color(0xCC222222),
      );
    },
  );
}

Future<void> _setupHotKye() async {
  await hotKeySystem.register(
    HotKey(
      KeyCode.keyW,
      modifiers: [KeyModifier.alt, KeyModifier.control],
      scope: HotKeyScope.system,
    ),
    keyDownHandler: (hotKey) {
      windowManager.show();
      windowManager.focus();
    },
  );
}
