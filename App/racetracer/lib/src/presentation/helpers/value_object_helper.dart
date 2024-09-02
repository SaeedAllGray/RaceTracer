import 'package:deep_pick/deep_pick.dart';
import 'package:racetracer/src/domain/entries/value_object.dart';

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

  static ValueObject convert(ValueObject valueObject) {
    return ValueObject(
        topic: valueObject.topic,
        label: valueObject.valueKey,
        value: pickDeep(valueObject.value,
                ValueObjectHelper.parseData(valueObject.valueKey!))
            .asStringOrNull());
  }
}
