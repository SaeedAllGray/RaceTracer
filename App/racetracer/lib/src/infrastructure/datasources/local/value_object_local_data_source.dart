import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:share_plus/share_plus.dart';

class ValueObjectLocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();
    log(directory.path);
    return directory.path;
  }

  Future<File> get _localFile async {
    final path = await _localPath;
    return File('$path/config.json');
  }

  Future<void> writeEntity(ValueObject valueObject) async {
    try {
      // Get the directory to save the file
      final file = await _localFile;

      List<ValueObject> jsonData = await getEntities();

      // If the file exists, read its contents

      // Append the new object to the list
      jsonData.add(valueObject);
      // Save the updated list back to the file
      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      rethrow;
    }
  }

  Future<List<ValueObject>> getEntities({File? importedFile}) async {
    List<ValueObject> jsonData = [];
    final file = importedFile ?? await _localFile;
    if (await file.exists()) {
      String contents = await file.readAsString();
      jsonData = (jsonDecode(contents) as List)
          .map(
            (e) => ValueObject.fromJson(e),
          )
          .toList();
    }

    return jsonData;
  }

  Future<void> removeEntity(int index) async {
    try {
      // Get the directory to save the file
      final file = await _localFile;

      List<ValueObject> jsonData = await getEntities();

      // If the file exists, read its contents

      // Append the new object to the list
      jsonData.removeAt(index);
      // Save the updated list back to the file
      await file.writeAsString(jsonEncode(jsonData));
    } catch (e) {
      rethrow;
    }
  }

  Future<void> shareFile() async {
    final file = await _localFile;

    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> importFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
        allowMultiple: false,
        allowedExtensions: ['json'],
        type: FileType.custom);

    try {
      final localFile = await _localFile;
      if (result != null) {
        File importedFile = File(result.files.single.path!);

        List<ValueObject> jsonData = await getEntities();
        jsonData.addAll(await getEntities(importedFile: importedFile));

        // Save the updated list back to the file
        await localFile.writeAsString(jsonEncode(jsonData));
      } else {
        // User canceled the picker
      }
    } catch (e) {}
  }
}
