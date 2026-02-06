import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_itikaf/bloc/itikaf_status/bloc.dart';
import 'package:digital_itikaf/bloc/itikaf_status/itikaf_status_events.dart';
import 'package:digital_itikaf/models/itikaf_status.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final dir = await getApplicationDocumentsDirectory();
  await Hive.initFlutter(dir.path);

  Hive.registerAdapter(ItikafStatusAdapter());
  final itikafStatusBox = await Hive.openBox<ItikafStatus>("itikafStatus");

  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
  AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

  if (itikafStatusBox.get(androidInfo.id) == null) {
    final defaultStatus = ItikafStatus(
      name: androidInfo.id,
      isActive: false,
      startTime: DateTime.now(),
    );
    await itikafStatusBox.put(androidInfo.id, defaultStatus);
  }

  runApp(MainApp(itikafStatusBox: itikafStatusBox, deviceId: androidInfo.id));
}

class MainApp extends StatelessWidget {
  final Box<ItikafStatus> itikafStatusBox;
  final String deviceId;
  
  const MainApp({super.key, required this.itikafStatusBox, required this.deviceId});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BlocProvider(
        create: (context) => ItikafStatusBloc(itikafStatusBox)
          ..add(LoadStatus(deviceId)),
        child: const Scaffold(
          body: Center(
            child: Text('Hello World!'),
          ),
        ),
      ),
    );
  }
}
