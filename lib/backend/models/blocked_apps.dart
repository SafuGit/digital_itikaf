import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class BlockedApp {
  final String packageName;
  final String appName;

  BlockedApp({required this.appName, required this.packageName});

  factory BlockedApp.fromJson(Map<String, dynamic> json) => BlockedApp(
    packageName: json['packageName'] as String,
    appName: json['appName'] as String,
  );

  Map<String, dynamic> toJson() => {
    'packageName': packageName,
    'appName': appName,
  };
}

class BlockedAppAdapter extends TypeAdapter<BlockedApp> {
  @override
  final typeId = 1;

  @override
  BlockedApp read(BinaryReader reader) {
    final packageName = reader.readString();
    final appName = reader.readString();
    return BlockedApp(packageName: packageName, appName: appName);
  }

  @override
  void write(BinaryWriter writer, BlockedApp obj) {
    writer.writeString(obj.packageName);
    writer.writeString(obj.appName);
  }
}
