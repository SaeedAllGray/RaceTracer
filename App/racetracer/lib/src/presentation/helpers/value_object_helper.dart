import 'package:deep_pick/deep_pick.dart';

class ValueObjectHelper {
  static List<Object> parseData(String data) {
    List<String> parts =
        data.replaceAll('[', '.').replaceAll(']', '').split('.');

    List<Object> result = parts.map((part) {
      if (int.tryParse(part) != null) {
        return int.parse(part);
      } else {
        return part;
      }
    }).toList();

    return result;
  }

  static bool isValid(String input, dynamic message) {
    return !pickDeep(message, ValueObjectHelper.parseData(input)).isAbsent;
  }
}
