import 'package:digital_itikaf/backend/models/itikaf_status.dart';

abstract class ItikafStatusEvents {}

class ToggleStatus extends ItikafStatusEvents {
  final bool newStatus;

  ToggleStatus(this.newStatus);
}

class AddNewStatus extends ItikafStatusEvents {
  final ItikafStatus status;

  AddNewStatus(this.status);
}

class LoadStatus extends ItikafStatusEvents {
  final String statusName;

  LoadStatus(this.statusName);
}