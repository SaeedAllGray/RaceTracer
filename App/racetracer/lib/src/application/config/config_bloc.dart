import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_data_source.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final LocalDataSource localDataSource = LocalDataSource();
  ConfigBloc() : super(ConfigInitial()) {
    on<SaveEvent>(_onSaveEvent);
    on<FetchDataEvent>(_onFetchedDataEvent);
    on<SignoutEvent>(_onSignoutEvent);
  }

  FutureOr<void> _onSaveEvent(
      SaveEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigInProgressState());
    await localDataSource.saveHostIP(event.hostIP);
    await localDataSource.saveProjectID(event.projectID);
    await ApiConstants.setBaseUrl();
    await ApiConstants.setProjectId();
    emit(FetchSucceedState(hostIP: event.hostIP, projectID: event.projectID));
  }

  FutureOr<void> _onFetchedDataEvent(
      FetchDataEvent event, Emitter<ConfigState> emit) async {
    final String? hostIP = await localDataSource.getHostIP();
    final String? projectID = await localDataSource.getProjectID();
    if (projectID != null && hostIP != null) {
      emit(FetchSucceedState(hostIP: hostIP, projectID: projectID));
    }
  }

  FutureOr<void> _onSignoutEvent(
      SignoutEvent event, Emitter<ConfigState> emit) async {
    await localDataSource.signOut();
    emit(DataDeletedState());
  }
}
