import 'package:digital_itikaf/backend/bloc/blocked_apps/bloc.dart';
import 'package:digital_itikaf/backend/bloc/blocked_apps/blocked_apps_events.dart';
import 'package:digital_itikaf/backend/bloc/blocked_apps/blocked_apps_states.dart';
import 'package:digital_itikaf/frontend/components/blocked_app_card.dart';
import 'package:digital_itikaf/util/Theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AppsScreen extends StatefulWidget {
  const AppsScreen({super.key});

  @override
  State<AppsScreen> createState() => _AppsScreenState();
}

class _AppsScreenState extends State<AppsScreen> {
  @override
  void initState() {
    super.initState();

    context.read<BlockedAppsBloc>().add(LoadBlockedApps());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return BlocBuilder<BlockedAppsBloc, BlockedAppsStates>(
      builder: (context, state) {
        if (state is BlockedAppsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is BlockedAppsLoaded) {
          final apps = state.blockedApps;

          return CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Blocked Apps",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w900,
                          color: isDark
                              ? AppTheme.textDark
                              : AppTheme.textLight,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        "Focusing on your spiritual journey",
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
              ),
              apps.isEmpty
                  ? SliverFillRemaining(
                      child: const Center(
                        child: Text("No blocked apps found."),
                      ),
                    )
                  : SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final app = apps[index];
                        return Padding(
                          padding: const EdgeInsets.only(left: 24, right: 24),
                          child: BlockedAppCard(
                            appName: app.appName,
                            packageName: app.packageName,
                            isBlocked: app.isBlocked,
                            icon: app.iconBytes != null
                                ? Image.memory(
                                    app.iconBytes!,
                                    width: 24,
                                    height: 24,
                                  )
                                : const Icon(Icons.apps),
                            onToggle: (val) {
                              // handle toggle
                            },
                          ),
                        );
                      }, childCount: apps.length),
                    ),
            ],
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}
