// ignore_for_file: file_names

import 'package:path_provider/path_provider.dart';

class FileUtil{
  static String? appDocumentPath;
  static Future<void> init()async
  {
    final appDocDir = await getApplicationDocumentsDirectory();
    appDocumentPath = '${appDocDir.path}/';
  }
}
