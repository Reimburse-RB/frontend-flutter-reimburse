import 'dart:developer';
import 'dart:io';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:excel/excel.dart';

class ExcelApi {
  static Future<File> saveDocument({
    required String name,
    required Excel excel,
  }) async {
    final bytes = excel.encode();

    final dir = Platform.isAndroid
        ? await getExternalStorageDirectory()
        : await getApplicationDocumentsDirectory();

    final file = File('${dir!.path}/$name');
    await file.writeAsBytes(bytes!);

    return file;
  }

  static Future openFile(File file) async {
    final path = file.path;

    final result = await OpenFile.open(path);

    if (result.type != ResultType.done) {
      log("Gagal membuka file: ${result.message}");
    }
  }
}
