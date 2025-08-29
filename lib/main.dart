import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'src/theme/app_theme.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/dashboard_screen.dart';
import 'src/screens/projects_screen.dart';
import 'src/screens/create_project_screen.dart';
import 'src/screens/settings_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'PGA 2025 - Fatec Votorantim',
      theme: AppTheme.lightTheme,
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

final _router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      name: 'login',
      builder: (context, state) => const LoginScreen(),
    ),
    GoRoute(
      path: '/dashboard',
      name: 'dashboard',
      builder: (context, state) => const DashboardScreen(),
    ),
    GoRoute(
      path: '/projects',
      name: 'projects',
      builder: (context, state) => const ProjectsScreen(),
    ),
    GoRoute(
      path: '/create-project',
      name: 'create-project',
      builder: (context, state) => const CreateProjectScreen(),
    ),
    GoRoute(
      path: '/settings',
      name: 'settings',
      builder: (context, state) => const SettingsScreen(),
    ),
  ],
);
