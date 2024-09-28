import 'dart:io';

bool isDirectory(String path) {
  final entity = FileSystemEntity.typeSync(path);

  return entity == FileSystemEntityType.directory;
}
