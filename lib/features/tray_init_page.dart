import 'package:flutter/material.dart';
import 'package:tray_manager/tray_manager.dart';
import 'package:window_manager/window_manager.dart';

class TrayInitPage extends StatefulWidget {
  const TrayInitPage({super.key, required this.child});

  final Widget child;

  @override
  State<TrayInitPage> createState() => _TrayInitPageState();
}

class _TrayInitPageState extends State<TrayInitPage> with TrayListener {
  @override
  void dispose() {
    trayManager.removeListener(this);
    super.dispose();
  }

  @override
  void initState() {
    _setupTray();
    super.initState();
  }

  @override
  void onTrayIconMouseDown() {
    trayManager.popUpContextMenu();
  }

  @override
  void onTrayMenuItemClick(menuItem) async {
    if (menuItem.label == 'Show App') {
      await windowManager.show();
      await windowManager.focus();
    }
    if (menuItem.label == 'Hide') {
      await windowManager.hide();
    }
    if (menuItem.label == 'Quit') {
      await windowManager.close();
    }
  }

  void _setupTray() async {
    await trayManager.setIcon('assets/app_icon.png');
    final menu = Menu(
      items: [
        MenuItem(label: 'Show App'),
        MenuItem(label: 'Hide'),
        MenuItem(label: 'Quit'),
      ],
    );
    await trayManager.setContextMenu(menu);

    trayManager.addListener(this);
  }

  @override
  Widget build(BuildContext context) {
    return widget.child;
  }
}
