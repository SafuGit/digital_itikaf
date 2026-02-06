import 'package:digital_itikaf/backend/models/blocked_apps.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

final defaultApps = [
  BlockedApp(packageName: 'com.instagram.android', appName: 'Instagram', isBlocked: true),
  BlockedApp(packageName: 'com.google.android.youtube', appName: 'YouTube', isBlocked: true),
  BlockedApp(packageName: 'com.twitter.android', appName: 'Twitter', isBlocked: true),
  BlockedApp(packageName: 'com.snapchat.android', appName: 'Snapchat', isBlocked: true),
  BlockedApp(packageName: 'com.discord', appName: 'Discord', isBlocked: true),
];

Future<void> addDefaultBlockedApps(Box<BlockedApp> appsBox) async {
  final installedApps = await FlutterDeviceApps.listApps(
    includeSystem: true,
    onlyLaunchable: true,
    includeIcons: true,
  );

  for (var defaultApp in defaultApps) {
    final installedApp = installedApps.firstWhere(
      (app) => app.packageName == defaultApp.packageName,
      orElse: () => AppInfo(
        appName: 'Unknown',
        packageName: 'unknown.package',
        versionName: '',
        versionCode: 0,
      ),
    );

    if (installedApp.packageName != 'unknown.package') {
      bool alreadyAdded = appsBox.values.any(
        (a) => a.packageName == defaultApp.packageName,
      );

      if (!alreadyAdded) {
        final blockedAppWithIcon = BlockedApp(
          packageName: defaultApp.packageName,
          appName: defaultApp.appName,
          isBlocked: defaultApp.isBlocked,
          iconBytes: installedApp.iconBytes,
        );

        await appsBox.add(blockedAppWithIcon);
        print('${defaultApp.appName} added to blocked apps');
      }
    } else {
      print('${defaultApp.appName} is not installed on this device');
    }
  }
}
