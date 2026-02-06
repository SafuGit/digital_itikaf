import 'dart:ui';

import 'package:digital_itikaf/util/Theme/app_theme.dart';
import 'package:flutter/material.dart';

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  final List<BottomNavigationBarItem> _items = [
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.grid_view), label: 'Apps'),
    BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Settings'),
  ];

  int _indexFromRoute(BuildContext context) {
    final route = ModalRoute.of(context)?.settings.name;

    switch (route) {
      case '/':
        return 0;
      case '/apps':
        return 1;
      case '/settings':
        return 2;
      default:
        return 0;
    }
  }

  void _onItemTapped(int index) {
    switch (index) {
      case 0:
        Navigator.pushNamed(context, '/');
        break;
      case 1:
        Navigator.pushNamed(context, '/apps');
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentIndex = _indexFromRoute(context);

    return ClipRRect(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
        child: BottomNavigationBar(
          currentIndex: currentIndex,
          onTap: _onItemTapped,
          backgroundColor: Theme.of(context).brightness == Brightness.light
              ? AppTheme.backgroundLight.withValues()
              : AppTheme.backgroundDark.withValues(),
          selectedItemColor: AppTheme.primary,
          unselectedItemColor: Colors.grey,
          showSelectedLabels: true,
          showUnselectedLabels: true,
          type: BottomNavigationBarType.fixed,
          items: _items.map((item) {
            return BottomNavigationBarItem(icon: item.icon, label: item.label);
          }).toList(),
        ),
      ),
    );
  }
}
