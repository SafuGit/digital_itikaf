import 'package:device_info_plus/device_info_plus.dart';
import 'package:digital_itikaf/backend/bloc/itikaf_status/bloc.dart';
import 'package:digital_itikaf/backend/bloc/itikaf_status/itikaf_status_events.dart';
import 'package:digital_itikaf/backend/bloc/itikaf_status/itikaf_status_state.dart';
import 'package:digital_itikaf/frontend/components/ramadan_countdown.dart';
import 'package:digital_itikaf/util/ask_accessibility_perms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future<AndroidDeviceInfo> getAndroidInfo() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    return androidInfo;
  }

  @override
  void initState() {
    super.initState();
    _loadDeviceIdAndStatus();
  }

  Future<void> _loadDeviceIdAndStatus() async {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;

    if (!mounted) return;

    final deviceId = androidInfo.id;

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<ItikafStatusBloc>().add(LoadStatus(deviceId));
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItikafStatusBloc, ItikafStatusState>(
      builder: (context, state) {
        if (state is ItikafStatusLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is ItikafStatusLoaded) {
          return FutureBuilder(
            future: checkAccessibilityAndShowDialog(this),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Column(children: [RamadanCountdown()]);
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
