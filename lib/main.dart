import 'package:dropper/features/drag/view/drag_view.dart';
import 'package:dropper/features/tray_init_page.dart';
import 'package:dropper/main.export.dart';
import 'package:dropper/start_up.dart';
import 'package:dropper/theme/app_theme.dart';
import 'package:flutter/material.dart';

void main() async {
  await appStartUp();
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Ex',
      theme: AppTheme.theme(true),
      darkTheme: AppTheme.theme(false),
      themeMode: ThemeMode.dark,
      home: const TrayInitPage(child: DragView()),
    );
  }
}
