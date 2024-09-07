import 'dart:async';

import 'package:racetracer/src/domain/entries/value_object.dart';
import 'package:racetracer/src/infrastructure/datasources/local/value_object_local_data_source.dart';
import 'package:racetracer/src/infrastructure/datasources/remote/value_object_remote_data_source.dart';
import 'package:racetracer/src/presentation/helpers/value_object_helper.dart';

class ValueObjectRepository {
  ValueObjectLocalDataSource localDataSource = ValueObjectLocalDataSource();
  ValueObjectRemoteDataSource remoteDataSource = ValueObjectRemoteDataSource();

  Future<List<ValueObject>> getRemoteEntities() async {
    List<ValueObject> valueObjects = await getLocalEntities();

    dynamic response = await remoteDataSource.getEntities(
        valueObjects.where((element) => element.valueKey != null).toList(),
        valueObjects
            .where((element) => element.label != null)
            .map((e) => e.label!)
            .toList());

    return (response as List).map((e) {
      ValueObject valueObject = ValueObject.fromJson(e);
      if (valueObject.label != null) {
        return valueObject;
      } else {
        return ValueObjectHelper.convert(valueObject);
      }
    }).toList();
  }

  Future<List<ValueObject>> getLocalEntities() async {
    List<ValueObject> valueObjects = await localDataSource.getEntities();
    return valueObjects;
  }

  Future<List<ValueObject>> getScripts() async {
    dynamic response = await remoteDataSource.getScripts();
    return (response as List)
        .map(
          (e) => ValueObject.fromJson(e),
        )
        .toList();
  }

  Future<void> saveScript(ValueObject valueObject) async {
    await localDataSource.writeEntity(valueObject);
  }

  Future<void> removeEntity(int index) async {
    await localDataSource.removeEntity(index);
  }

  Stream<List<ValueObject>> streamEntities() async* {
    // Fetch the initial local entities
    List<ValueObject> valueObjects = await getLocalEntities();
    yield valueObjects; // Yield the local entities immediately

    // Return a Stream that periodically fetches and yields remote entities
    yield* Stream.periodic(Duration(seconds: 10), (_) async {
      // Fetch the remote entities periodically
      List<ValueObject> updatedValueObjects = await getRemoteEntities();
      return updatedValueObjects;
    }).asyncMap(
        (event) async => await event); // Unwrap the Future from periodic
  }

  Stream getEntitiesStream() {
    Stream stream = streamEntities();
    return stream;
  }
}
