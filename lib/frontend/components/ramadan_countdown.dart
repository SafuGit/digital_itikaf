import 'dart:async';
import 'package:digital_itikaf/util/get_time_before_ramadan.dart';
import 'package:flutter/material.dart';
import 'package:digital_itikaf/util/Theme/app_theme.dart';

class RamadanCountdown extends StatefulWidget {
  const RamadanCountdown({super.key});

  @override
  State<RamadanCountdown> createState() => _RamadanCountdownState();
}

class _RamadanCountdownState extends State<RamadanCountdown> {
  Duration remaining = Duration.zero;
  late Timer _timer;

  @override
  void initState() {
    super.initState();
    _updateCountdown();
    _timer = Timer.periodic(const Duration(seconds: 1), (_) => _updateCountdown());
  }

  void _updateCountdown() {
    setState(() {
      remaining = getTimeBeforeRamadan();
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  String _twoDigits(int n) => n.toString().padLeft(2, '0');

  @override
  Widget build(BuildContext context) {
    final days = remaining.inDays;
    final hours = remaining.inHours % 24;
    final minutes = remaining.inMinutes % 60;
    final seconds = remaining.inSeconds % 60;
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _timeBox(days, 'Days'),
            const SizedBox(width: 8),
            _timeBox(hours, 'Hours'),
            const SizedBox(width: 8),
            _timeBox(minutes, 'Mins'),
            const SizedBox(width: 8),
            _timeBox(seconds, 'Secs'),
          ],
        ),
        const SizedBox(height: 6),
        Text(
          'Remaining in Ramadan',
          style: TextStyle(
            fontSize: 12,
            color: isDark ? AppTheme.textDark : AppTheme.textLight,
            fontWeight: FontWeight.w300,
          ),
        ),
      ],
    );
  }

  Widget _timeBox(int value, String label) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Column(
      children: [
        Container(
          width: 56,
          height: 56,
          decoration: BoxDecoration(
            color: AppTheme.backgroundLight.withOpacity(0.05),
            border: Border.all(color: AppTheme.primary.withOpacity(0.2)),
            borderRadius: BorderRadius.circular(16),
          ),
          alignment: Alignment.center,
          child: Text(
            _twoDigits(value),
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: AppTheme.accentGold,
              shadows: [
                Shadow(
                  color: AppTheme.accentGold.withOpacity(0.5),
                  blurRadius: 8,
                  offset: const Offset(0, 0),
                )
              ],
            ),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label.toUpperCase(),
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: isDark ? AppTheme.textDark : AppTheme.textLight,
            letterSpacing: 1.5,
          ),
        ),
      ],
    );
  }
}
