import 'package:collection/collection.dart';
import 'package:dropper/features/drag/controller/drag_ctrl.dart';
import 'package:dropper/features/drag/view/draggable_widget.dart';
import 'package:dropper/main.export.dart';
import 'package:dropper/start_up.dart';
import 'package:flutter/material.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';
import 'package:window_manager/window_manager.dart';

class DragView extends HookConsumerWidget {
  const DragView({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final dragFiles = ref.watch(dragCtrlProvider);
    final dragCtrl = useCallback(() => ref.read(dragCtrlProvider.notifier));
    final isDragOver = useState(false);
    final isExpanded = useState(false);

    return LayoutPage(
      onClose: () {
        ref.invalidate(dragCtrlProvider);
      },
      footer: dragFiles.isEmpty
          ? null
          : GestureDetector(
              onTap: () async {
                final ex = isExpanded.value;

                final size = ex ? kWindowSize : kWindowSizeExpanded;

                await windowManager.setSize(size);
                isExpanded.value = !ex;
              },
              child: Row(
                children: [
                  const Gap(10),
                  Icon(Icons.keyboard_arrow_down_rounded, color: context.colors.onSecondary),
                  const Gap(10),
                  Text(
                    dragFiles.length == 1 ? dragFiles.first.item.name : '${dragFiles.length} files',
                    style: context.textTheme.labelLarge!.textColor(context.colors.onSecondary),
                  ),
                ],
              ).decorated(borderRadius: BorderRadius.circular(20), color: context.colors.secondary).padding(all: 10),
            ),
      child: DropRegion(
        formats: Formats.standardFormats,
        hitTestBehavior: HitTestBehavior.opaque,
        onDropOver: (x) {
          isDragOver.value = true;
          final local = x.session.items.map((e) => e.localData).toList();
          if (!local.contains(null)) {
            isDragOver.value = false;
            return DropOperation.none;
          }
          return x.session.allowedOperations.firstOrNull ?? DropOperation.none;
        },
        onPerformDrop: (x) async {
          final items = x.session.items;
          final local = items.map((e) => e.localData).toList();

          if (!local.contains(null)) {
            isDragOver.value = false;
            return;
          }

          dragCtrl().addFromDropItem(items);
        },

        onDropLeave: (_) => isDragOver.value = false,
        onDropEnded: (_) => isDragOver.value = false,
        child: AnimatedContainer(
          constraints: const BoxConstraints.expand(),
          duration: kThemeAnimationDuration,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: isDragOver.value ? Border.all(width: 3, color: context.colors.primary) : null,
          ),
          alignment: Alignment.center,
          child: ScatterGridView(
            items: dragFiles,
            isExpanded: isExpanded.value,
            emptyWidget: const Center(child: Text('Drop Here')),
            builder: (context, item, index) {
              return DragWidget(file: item);
            },
          ),
        ),
      ),
    );
  }
}
