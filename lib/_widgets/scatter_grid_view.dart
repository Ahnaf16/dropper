import 'package:cross_file/cross_file.dart';
import 'package:dropper/main.export.dart';
import 'package:flutter/material.dart';

class ScatterGridView extends StatelessWidget {
  const ScatterGridView({
    super.key,
    required this.items,
    required this.builder,
    this.emptyWidget,
    this.isExpanded = false,
  });

  final List<ScatterItem<XFile>> items;
  final Widget? emptyWidget;
  final bool isExpanded;
  final Widget Function(BuildContext context, ScatterItem<XFile> item, int index) builder;

  @override
  Widget build(BuildContext context) {
    if (emptyWidget != null && items.isEmpty) {
      return emptyWidget!;
    }

    return LayoutBuilder(
      builder: (context, c) {
        if (isExpanded) {
          return GridView.builder(
            padding: const EdgeInsets.all(8.0),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
            ),
            itemCount: items.length,
            itemBuilder: (context, i) {
              return AnimatedAlign(
                duration: kThemeAnimationDuration,
                curve: Curves.easeInOut,
                alignment: Alignment.center,
                child: Transform.rotate(
                  angle: 0,
                  child: builder(context, items[i], i),
                ),
              );
            },
          );
        }
        return Stack(
          children: [
            for (int i = 0; i < items.length; i++)
              AnimatedAlign(
                duration: kThemeAnimationDuration,
                curve: Curves.easeInOut,
                alignment: _convertOffsetToAlignment(items[i].offset, c),
                child: Transform.rotate(
                  angle: items[i].angle,
                  child: builder(context, items[i], i),
                ),
              ),
          ],
        );
      },
    );
  }

  Alignment _convertOffsetToAlignment(Offset offset, BoxConstraints constraints) {
    double normalizedX = (offset.dx / (constraints.maxWidth / 2));
    double normalizedY = (offset.dy / (constraints.maxHeight / 2));

    return Alignment(normalizedX, normalizedY);
  }
}
