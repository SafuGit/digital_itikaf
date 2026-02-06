import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class ItikafStatus {
  final bool isActive;
  final DateTime startTime;
  final DateTime? endTime;

  ItikafStatus({required this.isActive, required this.startTime, this.endTime});

  factory ItikafStatus.fromJson(Map<String, dynamic> json) => ItikafStatus(
    isActive: json["isActive"] as bool,
    startTime: DateTime.parse(json["startTime"] as String),
    endTime: json["endTime"] != null
        ? DateTime.parse(json["endTime"] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'isActive': isActive,
    'startTime': startTime,
    'endTime': endTime,
  };
}

class ItikafStatusAdapter extends TypeAdapter<ItikafStatus> {
  @override
  final typeId = 0;

  @override
  ItikafStatus read(BinaryReader reader) {
    final isActive = reader.readBool();
    final startTime = DateTime.parse(reader.readString());
    final endTimeString = reader.readString();
    final endTime = endTimeString.isNotEmpty
        ? DateTime.parse(endTimeString)
        : null;
    return ItikafStatus(
      isActive: isActive,
      startTime: startTime,
      endTime: endTime,
    );
  }

  @override
  void write(BinaryWriter writer, ItikafStatus obj) {
    writer.writeBool(obj.isActive);
    writer.writeString(obj.startTime.toIso8601String());
    writer.writeString(obj.endTime?.toIso8601String() ?? '');
  }
}
