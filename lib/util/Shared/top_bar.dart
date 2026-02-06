import 'package:digital_itikaf/util/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart'; // Material Symbols Flutter package

class TopBar extends StatelessWidget implements PreferredSizeWidget {
  const TopBar({super.key});

  @override
  Size get preferredSize => const Size.fromHeight(80);

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Left side: Logo + Title
            Row(
              children: [
                // Mosque Icon
                Container(
                  padding: const EdgeInsets.all(4),
                  child: const Icon(
                    Symbols.mosque,
                    color: AppTheme.primary,
                    size: 32,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "Digital I'tikaf",
                  style: TextStyle(
                    fontFamily: Theme.of(context).textTheme.headlineMedium?.fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: isDark ? AppTheme.textDark : AppTheme.textLight,
                  ),
                ),
              ],
            ),

            // Right side: Notifications + Account
            Row(
              children: [
                _iconButton(
                  icon: Symbols.notifications,
                  bgColor: isDark ? Colors.white10 : Colors.grey[200]!,
                ),
                const SizedBox(width: 8),
                _iconButton(
                  icon: Symbols.account_circle,
                  bgColor: isDark ? Colors.white10 : Colors.grey[200]!,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _iconButton({required IconData icon, required Color bgColor}) {
    return Container(
      decoration: BoxDecoration(
        color: bgColor,
        shape: BoxShape.circle,
      ),
      padding: const EdgeInsets.all(8),
      child: Icon(
        icon,
        color: AppTheme.primary,
        size: 24,
      ),
    );
  }
}
