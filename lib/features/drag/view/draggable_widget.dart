import 'package:cross_file/cross_file.dart';
import 'package:dropper/main.export.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

class DragWidget extends StatelessWidget {
  const DragWidget({
    super.key,
    required this.file,
  });

  final ScatterItem<XFile> file;

  @override
  Widget build(BuildContext context) {
    return DragItemWidget(
      allowedOperations: () => [DropOperation.copy],
      canAddItemToExistingSession: true,
      dragItemProvider: (request) async {
        final item = DragItem(
          localData: 'local',
        );

        item.add(Formats.fileUri(Uri.file(file.item.path)));

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
                  border: Border.all(
                    width: 3,
                    color: context.colors.primary,
                  ),
                ),
                child: SingleChildScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      HugeIcon(
                        icon: HugeIcons.strokeRoundedFile02,
                        color: context.colors.primary,
                        size: 70,
                      ),
                      const Gap(5),
                      Text(
                        file.item.onlyName,
                        maxLines: 1,
                        style: context.textTheme.labelSmall,
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (file.item.ext != null)
              Positioned(
                top: -4,
                left: -2,
                child: Text(
                  file.item.ext!.toUpperCase(),
                  maxLines: 1,
                  style: context.textTheme.labelSmall
                      ?.textColor(context.colors.onSecondary)
                      .bold,
                ).padding(vertical: 1, horizontal: 3).decorated(
                      color: context.colors.secondary,
                      borderRadius: BorderRadius.circular(5),
                    ),
              ),
          ],
        ),
      ),
    );
  }
}
