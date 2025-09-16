// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drag_ctrl.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DragCtrl)
const dragCtrlProvider = DragCtrlProvider._();

final class DragCtrlProvider
    extends $NotifierProvider<DragCtrl, List<ScatterItem<XFile>>> {
  const DragCtrlProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dragCtrlProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dragCtrlHash();

  @$internal
  @override
  DragCtrl create() => DragCtrl();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<ScatterItem<XFile>> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<ScatterItem<XFile>>>(value),
    );
  }
}

String _$dragCtrlHash() => r'e9f8e5ced1856cfd629bc7ba92988edcc2e409c9';

abstract class _$DragCtrl extends $Notifier<List<ScatterItem<XFile>>> {
  List<ScatterItem<XFile>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref =
        this.ref as $Ref<List<ScatterItem<XFile>>, List<ScatterItem<XFile>>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<List<ScatterItem<XFile>>, List<ScatterItem<XFile>>>,
              List<ScatterItem<XFile>>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
