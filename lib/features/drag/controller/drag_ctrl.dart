import 'package:cross_file/cross_file.dart';
import 'package:dropper/main.export.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:super_drag_and_drop/super_drag_and_drop.dart';

part 'drag_ctrl.g.dart';

@riverpod
class DragCtrl extends _$DragCtrl {
  @override
  List<ScatterItem<XFile>> build() {
    return [];
  }

  void add(XFile file) {
    state = [...state, ScatterItem.fromXfile(file)];
  }

  void addAll(List<XFile> files) {
    final items = files.map((e) => ScatterItem.fromXfile(e));
    state = [...state, ...items];
  }

  void addFromDropItem(List<DropItem> items) async {
    final futures = items.map(
      (e) => ReaderInfo.fromReader(e.dataReader!, localData: e.localData),
    );
    final readers = await Future.wait(futures);

    processReaders(readers, (x) => addAll(x));
  }

  void clear() {
    state = [];
  }

  void remove(ScatterItem item) {
    state = state.where((r) => r.id != item.id).toList();
  }
}
