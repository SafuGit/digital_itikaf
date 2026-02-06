import 'package:digital_itikaf/backend/bloc/blocked_apps/blocked_apps_states.dart';
import 'package:digital_itikaf/backend/models/blocked_apps.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:digital_itikaf/backend/bloc/blocked_apps/blocked_apps_events.dart';
import 'package:flutter_device_apps/flutter_device_apps.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

class BlockedAppsBloc extends Bloc<BlockedAppsEvents, BlockedAppsStates> {
  final Box<BlockedApp> appsBox;

  BlockedAppsBloc(this.appsBox) : super(BlockedAppsLoading()) {
    on<LoadBlockedApps>((event, emit) async {
      final installedApps = await FlutterDeviceApps.listApps(
        includeSystem: true,
        onlyLaunchable: true,
        includeIcons: true,
      );
      final appsInBox = appsBox.values.toList();

      final existingPackageNames = appsInBox.map((e) => e.packageName).toSet();

      final newApps = installedApps.where(
        (app) =>
            !existingPackageNames.contains(app.packageName) &&
            app.packageName != null &&
            app.appName != null,
      );

      for (final app in newApps) {
        final blockedApp = BlockedApp(
          packageName: app.packageName!,
          appName: app.appName!,
          isBlocked: false,
          iconBytes: app.iconBytes,
        );
        await appsBox.add(blockedApp);
      }

      emit(BlockedAppsLoaded(appsBox.values.toList()));
    });
  }
}
