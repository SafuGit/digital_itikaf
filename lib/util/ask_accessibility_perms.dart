import 'package:flutter/material.dart';
import 'package:flutter_accessibility_service/flutter_accessibility_service.dart';
import 'package:digital_itikaf/util/Theme/app_theme.dart';

Future<void> checkAccessibilityAndShowDialog(State state) async {
  final isEnabled =
      await FlutterAccessibilityService.isAccessibilityPermissionEnabled();

  if (!isEnabled && state.mounted) {
    await showDialog(
      context: state.context,
      barrierDismissible: false,
      builder: (context) {
        return AlertDialog(
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppTheme.backgroundLight
              : AppTheme.backgroundDark,
          title: Text(
            'ERROR!',
            style: TextStyle(
              color: AppTheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          content: Text(
            'Accessibility is disabled.\nPlease enable it first!',
            style: TextStyle(
              color: Theme.of(context).brightness == Brightness.light
                  ? Colors.black87
                  : Colors.white70,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                await FlutterAccessibilityService.requestAccessibilityPermission();
              },
              child: Text(
                'ENABLE',
                style: TextStyle(
                  color: AppTheme.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}
