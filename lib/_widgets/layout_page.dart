import 'package:dropper/main.export.dart';
import 'package:flutter/material.dart';
import 'package:window_manager/window_manager.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key, required this.child, this.footer, this.onClose});

  final Widget child;
  final Widget? footer;
  final VoidCallback? onClose;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: Stack(
              children: [
                Row(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        onClose?.call();
                        windowManager.close();
                      },
                      child: Container(
                        decoration: BoxDecoration(color: context.colors.error, shape: BoxShape.circle),
                        padding: const EdgeInsets.all(4),
                        height: 18,
                        child: FittedBox(child: const Icon(Icons.close_rounded)),
                      ),
                    ),
                  ],
                ),
                Positioned.fill(
                  child: Center(
                    child: Container(
                      height: 3,
                      width: 50,
                      decoration: BoxDecoration(color: context.colors.primary, borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Expanded(child: child),
          if (footer != null) footer!,
        ],
      ),
    );
  }
}
