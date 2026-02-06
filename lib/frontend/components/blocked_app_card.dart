import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:digital_itikaf/util/Theme/app_theme.dart';

class BlockedAppCard extends StatelessWidget {
  final String appName;
  final String packageName;
  final bool isBlocked;
  final Widget icon;
  final ValueChanged<bool>? onToggle;

  const BlockedAppCard({
    super.key,
    required this.appName,
    required this.packageName,
    required this.isBlocked,
    required this.icon,
    this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 18, sigmaY: 18),
          child: Container(
            decoration: BoxDecoration(
              color: isDark
                  ? AppTheme.backgroundDark.withOpacity(0.6)
                  : AppTheme.backgroundLight.withOpacity(0.75),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: isBlocked
                    ? AppTheme.primary.withOpacity(0.35)
                    : Colors.grey.withOpacity(0.15),
              ),
              boxShadow: isBlocked
                  ? [
                      BoxShadow(
                        color: AppTheme.primary.withOpacity(0.25),
                        blurRadius: 18,
                        spreadRadius: 1,
                      ),
                    ]
                  : [],
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              leading: _IconWrapper(
                isBlocked: isBlocked,
                child: icon,
              ),
              title: Text(
                appName,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: isDark
                      ? AppTheme.textDark
                      : AppTheme.textLight,
                ),
              ),
              subtitle: Text(
                packageName,
                style: TextStyle(
                  fontSize: 12,
                  color: (isDark
                          ? AppTheme.textDark
                          : AppTheme.textLight)
                      .withOpacity(0.6),
                ),
              ),
              trailing: Switch(
                value: isBlocked,
                activeColor: AppTheme.primary,
                onChanged: onToggle,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _IconWrapper extends StatelessWidget {
  final Widget child;
  final bool isBlocked;

  const _IconWrapper({
    required this.child,
    required this.isBlocked,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isBlocked
            ? AppTheme.primary.withOpacity(0.15)
            : Colors.grey.withOpacity(0.15),
      ),
      alignment: Alignment.center,
      child: SizedBox(
        width: 24,
        height: 24,
        child: child,
      ),
    );
  }
}