import 'dart:io';

late File saveFile;
late Directory assetDir;

void main(List<String> args) async {
  String filesPath = args.isEmpty ? "assets" : args[0];
  String savePath = args.length < 2
      ? "./lib/src/core/constant/app_assets.dart"
      : "./lib/${args[1]}";
  saveFile = File(savePath);
  await saveFile.create(recursive: true);
  assetDir = Directory(filesPath);
  generateFile();
}

void generateFile() async {
  var buffer = StringBuffer();
  buffer.writeln("//this class is generated from assets/generator.dart");
  buffer.write("class AppAssets {");
  List<FileSystemEntity> filesSystem = assetDir.listSync(recursive: true);
  List<File> files = <File>[...filesSystem.whereType<File>()];
  //sort
  files.sort((a, b) {
    String an = a.uri.pathSegments.last.toLowerCase();
    String bn = b.uri.pathSegments.last.toLowerCase();
    return an.compareTo(bn);
  });

  for (final file in files) {
    buffer.write(generateImageAssetsClass(file.uri.path));
    await saveFile.writeAsString(buffer.toString());
  }
  saveFile.writeAsStringSync("\n}", mode: FileMode.append);
}

String generateImageAssetsClass(String path) {
  final String imageName = path.split("/").last.replaceAll("%20", " ");
  if (imageName.startsWith(".")) {
    return "";
  }
  final String imagePath = path.replaceAll("%20", " ");
  String imageFieldName =
      imageName.replaceAll(RegExp(r'[-_\s+\b|\b\s]'), " ").split(".").first;
  final List<String> words =
      imageFieldName.split(" ").map(_upperCaseFirstLetter).toList();
  if (words.isNotEmpty) {
    words[0] = words[0].toLowerCase();
  }
  imageFieldName = words.join("");
  return '\n  static const String $imageFieldName = "$imagePath";';
}

String _upperCaseFirstLetter(String word) {
  if (word.isEmpty) return "";
  return '${word[0].toUpperCase()}${word.substring(1).toLowerCase()}';
}
