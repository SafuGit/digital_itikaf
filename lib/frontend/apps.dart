import 'package:digital_itikaf/util/Theme/app_theme.dart';
import 'package:flutter/material.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.all(24.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Blocked Apps",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
              color: isDark ? AppTheme.textDark : AppTheme.textLight,
            ),
          ),
          Text("Focusing on your spiritual journey", style: TextStyle(
            fontSize: 14,
            color: Colors.grey
          ))
        ],
      ),
    );
  }
}
