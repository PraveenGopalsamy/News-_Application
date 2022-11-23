import 'dart:convert';
import 'dart:io';
import 'package:newsplus_application/services/api_service.dart';
import 'package:path_provider/path_provider.dart';

class FileUtils {
  static Future<String> get getFilePath async {
    final directory = await getApplicationDocumentsDirectory();
    return directory.path;
  }

  static Future<File> get getFile async {
    final path = await getFilePath;
    return File('$path/newsplus.json');
  }

  static Future<void> saveToFile(List<Article> data) async {
    final articleMap = data.map((e) => e.toJson()).toList();
    final file = await getFile;
    await file.writeAsString(jsonEncode(articleMap));
  }

  static Future<List<Article>> readFromFile() async {
    try {
      final file = await getFile;
      String fileContents = await file.readAsString();
      final List<dynamic> jsonData = jsonDecode(fileContents);
      return jsonData
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (e) {
      return <Article>[];
    }
  }
}
