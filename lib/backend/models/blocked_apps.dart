import 'dart:convert';
import 'dart:typed_data';

import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class BlockedApp {
  final String packageName;
  final String appName;
  final bool isBlocked;
  final Uint8List? iconBytes;

  BlockedApp({
    required this.appName,
    required this.packageName,
    required this.isBlocked,
    this.iconBytes,
  });

  factory BlockedApp.fromJson(Map<String, dynamic> json) => BlockedApp(
    packageName: json['packageName'] as String,
    appName: json['appName'] as String,
    isBlocked: json['isBlocked'] as bool,
    iconBytes: json['iconBytes'] != null
        ? base64Decode(json['iconBytes'] as String)
        : null,
  );

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'appName': appName,
    'isBlocked': isBlocked,
    'iconBytes': iconBytes != null ? base64Encode(iconBytes!) : null,
  };
}

class BlockedAppAdapter extends TypeAdapter<BlockedApp> {
  @override
  final typeId = 1;

  @override
  BlockedApp read(BinaryReader reader) {
    final packageName = reader.readString();
    final appName = reader.readString();
    final isBlocked = reader.readBool();
    final iconBytes = reader.read() as Uint8List?;
    return BlockedApp(
      packageName: packageName,
      appName: appName,
      isBlocked: isBlocked,
      iconBytes: iconBytes,
    );
  }

  @override
  void write(BinaryWriter writer, BlockedApp obj) {
    writer.writeString(obj.packageName);
    writer.writeString(obj.appName);
    writer.writeBool(obj.isBlocked);
    writer.write(obj.iconBytes);
  }
}
