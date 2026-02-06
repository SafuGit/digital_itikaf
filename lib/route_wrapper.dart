import 'package:digital_itikaf/util/Shared/bottom_bar.dart';
import 'package:digital_itikaf/util/Shared/top_bar.dart';
import 'package:flutter/material.dart';

class RouteWrapper extends StatelessWidget {
  final Widget child;

  const RouteWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TopBar(),
      body: child,
      bottomNavigationBar: const BottomBar(),
    );
  }
}
