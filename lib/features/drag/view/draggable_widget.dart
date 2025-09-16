import 'package:cross_file/cross_file.dart';
import 'package:dropper/main.export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class DragWidget extends StatelessWidget {
  const DragWidget({super.key, required this.file});

  final ScatterItem<XFile> file;

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      allowedOperations: () => [DropOperation.copy],
      canAddItemToExistingSession: true,
      dragItemProvider: (request) async {
        final item = DragItem(localData: 'local');

        Logger(file.item.path);

        item.add(Formats.fileUri.lazy(() => Uri.file(file.item.path)));

        return item;
      },
      child: DraggableWidget(
        child: Stack(
          alignment: Alignment.center,
          clipBehavior: Clip.none,
          children: [
            Positioned(
              child: Container(
                width: 90,
                height: 120,
                padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 8),
                decoration: BoxDecoration(
                  color: context.colors.surface,
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(width: 1, color: context.colors.primary),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Gap(10),
                      HugeIcon(icon: strokeRoundedFile02, color: context.colors.primary, size: 70),
                      if (file.item.onlyName.isNotEmpty) ...[
                        const Gap(5),
                        Text(file.item.onlyName, maxLines: 1, style: context.textTheme.labelSmall),
                      ],
                    ],
                  ),
                ),
              ),
            ),
            if (file.item.ext != null)
              Positioned(
                top: -4,
                left: -2,
                child:
                    Text(
                          file.item.ext!.toUpperCase(),
                          maxLines: 1,
                          style: context.textTheme.labelSmall?.textColor(context.colors.onSecondary).bold,
                        )
                        .padding(vertical: 1, horizontal: 3)
                        .decorated(color: context.colors.secondary, borderRadius: BorderRadius.circular(5)),
              ),
          ],
        ),
      ),
    );
  }
}

const List<List<dynamic>> strokeRoundedFile02 = [
  [
    'path',
    {
      'key': '0',
      'd': 'M8 17H16',
      'stroke': 'currentColor',
      'strokeWidth': '.7',
      'strokeLinecap': 'round',
      'strokeLinejoin': 'round',
    },
  ],
  [
    'path',
    {
      'key': '1',
      'd': 'M8 13H12',
      'stroke': 'currentColor',
      'strokeWidth': '.7',
      'strokeLinecap': 'round',
      'strokeLinejoin': 'round',
    },
  ],
  [
    'path',
    {
      'key': '2',
      'd':
          'M13 2.5V3C13 5.82843 13 7.24264 13.8787 8.12132C14.7574 9 16.1716 9 19 9H19.5M20 10.6569V14C20 17.7712 20 19.6569 18.8284 20.8284C17.6569 22 15.7712 22 12 22C8.22876 22 6.34315 22 5.17157 20.8284C4 19.6569 4 17.7712 4 14V9.45584C4 6.21082 4 4.58831 4.88607 3.48933C5.06508 3.26731 5.26731 3.06508 5.48933 2.88607C6.58831 2 8.21082 2 11.4558 2C12.1614 2 12.5141 2 12.8372 2.11401C12.9044 2.13772 12.9702 2.165 13.0345 2.19575C13.3436 2.34355 13.593 2.593 14.0919 3.09188L18.8284 7.82843C19.4065 8.40649 19.6955 8.69552 19.8478 9.06306C20 9.4306 20 9.83935 20 10.6569Z',
      'stroke': 'currentColor',
      'strokeWidth': '.7',
      'strokeLinecap': 'round',
      'strokeLinejoin': 'round',
    },
  ],
];
