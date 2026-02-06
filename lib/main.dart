import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_itikaf/bloc/itikaf_status/bloc.dart';
import 'package:digital_itikaf/bloc/itikaf_status/itikaf_status_events.dart';
import 'package:digital_itikaf/bloc/itikaf_status/itikaf_status_state.dart';
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
        child: Scaffold(
          body: Center(
            child: BlocBuilder<ItikafStatusBloc, ItikafStatusState>(
              builder: (context, state) {
                if (state is ItikafStatusLoading) {
                  return const CircularProgressIndicator();
                } else if (state is ItikafStatusLoaded) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Device ID: ${state.itikafStatus.name}'),
                      const SizedBox(height: 16),
                      Text('Is Active: ${state.itikafStatus.isActive}'),
                      const SizedBox(height: 16),
                      Text('Start Time: ${state.itikafStatus.startTime}'),
                    ],
                  );
                } else if (state is ItikafStatusNotFound) {
                  return const Text('Status not found');
                } else {
                  return const Text('Unknown state');
                }
              },
            ),
          ),
        ),
      ),
    );
  }
}
