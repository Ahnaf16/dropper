import 'dart:async';

import 'package:collection/collection.dart';
import 'package:cross_file/cross_file.dart';
import 'package:flutter/material.dart';
import 'package:mime/mime.dart';
import 'package:super_clipboard/super_clipboard.dart';

void processReaders(
  Iterable<ReaderInfo> readers,
  ValueChanged<List<XFile>> onProcess,
) {
  final widgets = Future.wait(readers.map((e) => _getUris(e)));
  widgets.then((value) {
    final uris = value.whereNotNull().toList();
    final files = uris.map((e) => e.toXFile).toList();
    onProcess(files);
  });
}

Future<Uri?> _getUris(ReaderInfo reader) async {
  final fileFutures = await reader.reader.readValue(Formats.fileUri);
  final uriFutures = await reader.reader.readValue(Formats.uri);

  return fileFutures ?? uriFutures?.uri;
}

class ReaderInfo {
  ReaderInfo._({
    required this.reader,
    this.localData,
  });

  final Object? localData;
  final DataReader reader;

  static Future<ReaderInfo> fromReader(
    DataReader reader, {
    Object? localData,
  }) async {
    return ReaderInfo._(
      reader: reader,
      localData: localData,
    );
  }
}

extension _ReadValue on DataReader {
  Future<T?> readValue<T extends Object>(ValueFormat<T> format) {
    final c = Completer<T?>();
    final progress = getValue<T>(
      format,
      (value) => c.complete(value),
      onError: (e) => c.completeError(e),
    );
    if (progress == null) {
      c.complete(null);
    }
    return c.future;
  }
}

extension XFileEX on XFile {
  String get name => path.split('/').last;
  String get onlyName => name.split('.').firstOrNull ?? name;
  String? get ext => name.split('.').lastOrNull;

  bool get isImage => mimeType?.startsWith('image') ?? false;
  bool get isVideo => mimeType?.startsWith('video') ?? false;
  bool get isAudio => mimeType?.startsWith('audio') ?? false;
}

extension URIEx on Uri {
  String get name => path.split('/').last;

  XFile get toXFile => XFile(path, name: name, mimeType: lookupMimeType(path));
}

List<SimpleFileFormat> imgFormats = [
  Formats.jpeg,
  Formats.png,
  Formats.svg,
  Formats.gif,
  Formats.webp,
  Formats.tiff,
  Formats.bmp,
  Formats.ico,
  Formats.heic,
  Formats.heif,
];
List<SimpleFileFormat> videoFormats = [
  Formats.mp4,
  Formats.mov,
  Formats.m4v,
  Formats.avi,
  Formats.mpeg,
  Formats.webm,
  Formats.ogg,
  Formats.wmv,
  Formats.flv,
  Formats.mkv,
  Formats.ts,
];
