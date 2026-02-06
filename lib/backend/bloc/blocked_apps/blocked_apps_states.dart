import 'package:digital_itikaf/backend/models/blocked_apps.dart';

abstract class BlockedAppsStates {}

class BlockedAppsLoading extends BlockedAppsStates {}

class BlockedAppsLoaded extends BlockedAppsStates {
  final List<BlockedApp> blockedApps;

  BlockedAppsLoaded(this.blockedApps);
}

class BlockedAppsStatusNotFound extends BlockedAppsStates {}