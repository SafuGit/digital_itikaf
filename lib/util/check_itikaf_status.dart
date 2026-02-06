import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_itikaf/backend/models/itikaf_status.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

Future<String> checkItikafStatus(
  Box<ItikafStatus> itikafBox,
  AndroidDeviceInfo androidInfo
) async {
  if (itikafBox.get(androidInfo.id) == null) {
    final defaultStatus = ItikafStatus(
      name: androidInfo.id,
      isActive: false,
      startTime: DateTime.now(),
    );
    await itikafBox.put(androidInfo.id, defaultStatus);
  }

  return "done";
}
