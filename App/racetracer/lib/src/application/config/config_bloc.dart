import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'config_event.dart';
part 'config_state.dart';

class ConfigBloc extends Bloc<ConfigEvent, ConfigState> {
  ConfigBloc() : super(ConfigInitial()) {
    on<ConfigEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
