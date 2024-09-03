import 'dart:convert';
import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';

class ValueObjectLocalDataSource {
  Future<String> get _localPath async {
    final directory = await getApplicationDocumentsDirectory();

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

  Future<List<ValueObject>> getEntities() async {
    List<ValueObject> jsonData = [];
    final file = await _localFile;
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
}
