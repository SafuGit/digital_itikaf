import 'package:digital_itikaf/backend/bloc/itikaf_status/itikaf_status_events.dart';
import 'package:digital_itikaf/backend/bloc/itikaf_status/itikaf_status_state.dart';
import 'package:digital_itikaf/backend/models/itikaf_status.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class ItikafStatusBloc extends Bloc<ItikafStatusEvents, ItikafStatusState> {
  final Box<ItikafStatus> itikafStatusBox;

  ItikafStatusBloc(this.itikafStatusBox) : super(ItikafStatusLoading()) {
    on<LoadStatus>((event, emit) {
      final status = itikafStatusBox.get(event.statusName);
      if (status == null) {
        emit(ItikafStatusNotFound());
      } else {
        emit(ItikafStatusLoaded(status));
      }
    });

    on<AddNewStatus>((event, emit) {
      itikafStatusBox.put(event.status.name, event.status);
      add(LoadStatus(event.status.name));
    });
  }
}