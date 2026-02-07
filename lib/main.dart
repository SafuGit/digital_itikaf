import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_itikaf/backend/bloc/blocked_apps/bloc.dart';
import 'package:digital_itikaf/backend/bloc/itikaf_status/bloc.dart';
import 'package:digital_itikaf/backend/bloc/itikaf_status/itikaf_status_events.dart';
import 'package:digital_itikaf/backend/models/blocked_apps.dart';
import 'package:digital_itikaf/backend/models/itikaf_status.dart';
import 'package:digital_itikaf/routes.dart';
import 'package:digital_itikaf/util/Theme/app_theme.dart';
import 'package:digital_itikaf/util/add_default_blocked_apps.dart';
import 'package:digital_itikaf/util/check_itikaf_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  Hive.registerAdapter(ItikafStatusAdapter());
  Hive.registerAdapter(BlockedAppAdapter());
  final itikafStatusBox = await Hive.openBox<ItikafStatus>("itikafStatus");
  final blockedAppsBox = await Hive.openBox<BlockedApp>("blockedApps");

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  await checkItikafStatus(itikafStatusBox, androidInfo);
  await addDefaultBlockedApps(blockedAppsBox);

  runApp(MainApp(itikafStatusBox: itikafStatusBox, deviceId: androidInfo.id, blockedAppsBox: blockedAppsBox,));
}

class MainApp extends StatelessWidget {
  final Box<ItikafStatus> itikafStatusBox;
  final Box<BlockedApp> blockedAppsBox;
  final String deviceId;

  const MainApp({
    super.key,
    required this.itikafStatusBox,
    required this.blockedAppsBox,
    required this.deviceId,
  });

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) =>
              ItikafStatusBloc(itikafStatusBox)..add(LoadStatus(deviceId)),
        ),
        BlocProvider(create: (context) => BlockedAppsBloc(blockedAppsBox))
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: "Digital I'tikaf",
        theme: AppTheme.lightTheme,
        darkTheme: AppTheme.darkTheme,
        themeMode: ThemeMode.system,
        initialRoute: AppRoutes.home,
        onGenerateRoute: AppRoutes.generateRoute,
      ),
    );
  }
}
