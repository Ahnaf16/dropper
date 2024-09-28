import 'dart:math';

import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ScatterItem<T> {
  ScatterItem({
    required this.item,
    required this.offset,
    required this.angle,
    required this.id,
  });

  final double angle;
  final String id;
  final T item;
  final Offset offset;

  static ScatterItem<XFile> fromXfile(XFile file) {
    final angle = (Random().nextDouble() - 0.5) * (pi / 6);
    final offsetX = Random().nextDouble() * 10 - 5;
    final offsetY = Random().nextDouble() * 10 - 5;

    final id = const Uuid().v4();

    return ScatterItem<XFile>(
      id: id,
      item: file,
      offset: Offset(offsetX, offsetY),
      angle: angle,
    );
  }
}
