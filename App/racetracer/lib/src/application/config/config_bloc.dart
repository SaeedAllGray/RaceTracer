import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:racetracer/src/domain/entries/oauth/oauth_attributes.dart';
import 'package:racetracer/src/infrastructure/datasources/local/local_storage_data_source.dart';
import 'package:racetracer/src/infrastructure/repositories/config_repository.dart';
import 'package:racetracer/src/presentation/constants/api_constant.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  final LocalStorageDataSource localDataSource = LocalStorageDataSource();
  final ConfigRepository configRepository = ConfigRepository();
  ConfigBloc() : super(ConfigInitial()) {
    on<SaveEvent>(_onSaveEvent);
    on<FetchDataEvent>(_onFetchedDataEvent);
    on<SignoutEvent>(_onSignoutEvent);
    on<DownloadDataEvent>(_onDownloadDataEvent);
  }

  FutureOr<void> _onSaveEvent(
      SaveEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigInProgressState());
    await localDataSource.saveHostIP(event.hostIP);

    await ApiConstants.setBaseUrl();
    await ApiConstants.setProjectId();
    emit(SavedSucceedState(hostIP: event.hostIP));
  }

  FutureOr<void> _onFetchedDataEvent(
      FetchDataEvent event, Emitter<ConfigState> emit) async {
    emit(ConfigInProgressState());
    final String? hostIP = await localDataSource.getHostIP();
    if (hostIP != null) {
      emit(FetchSucceedState(hostIP: hostIP));
    }
  }

  FutureOr<void> _onSignoutEvent(
      SignoutEvent event, Emitter<ConfigState> emit) async {
    await localDataSource.signOut();
    emit(DataDeletedState());
    emit(ConfigInitial());
  }

  FutureOr<void> _onDownloadDataEvent(
      DownloadDataEvent event, Emitter<ConfigState> emit) async {
    try {
      emit(ConfigInProgressState());

      final OauthAtrributes oauthAtrributes =
          await configRepository.setupConfigurations(event.hostIP);
      ApiConstants.setOauth = oauthAtrributes;

      await localDataSource.saveOauth(oauthAtrributes);
      await localDataSource.saveHostIP(event.hostIP);
      emit(DownloadSucceedState());
    } catch (e) {
      emit(DownloadFailedState());
    }
  }
}
