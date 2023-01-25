import 'dart:io';

extension SkadiFileExtension on File {
  ///Get file's name
  String get name {
    return path.split("/").last;
  }

  ///Get file's name without extension
  String get nameWithoutExt {
    return name.split(".").last;
  }

  ///Get file's extension
  String get fileExt {
    return path.split(".").last;
  }
}
