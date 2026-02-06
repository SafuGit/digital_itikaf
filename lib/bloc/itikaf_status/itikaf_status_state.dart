import 'package:digital_itikaf/models/itikaf_status.dart';

abstract class ItikafStatusState {}

class ItikafStatusLoading extends ItikafStatusState {}

class ItikafStatusLoaded extends ItikafStatusState {
  final ItikafStatus itikafStatus;

  ItikafStatusLoaded(this.itikafStatus);
}

class ItikafStatusNotFound extends ItikafStatusState {}