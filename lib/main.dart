import 'package:flutter/material.dart';
import 'src/services/app_init.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'src/services/auth_provider.dart';
import 'src/theme/app_theme.dart';
import 'src/screens/login_screen.dart';
import 'src/screens/dashboard_screen.dart';
import 'src/screens/projects_screen.dart';
import 'src/screens/create_project_screen.dart';
import 'src/screens/settings_screen.dart';

const BACKEND_BASE = 'http://192.168.0.248:3000';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final auth = AuthProvider(baseUrl: BACKEND_BASE);
  await auth.loadFromStorage();

  // Initialize app (connectivity listener / lookup prefetch) after auth is loaded
  await AppInit().initialize(BACKEND_BASE);

  runApp(ChangeNotifierProvider.value(
    value: auth,
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final router = GoRouter(
      initialLocation: '/',
      redirect: (context, state) {
        final auth = Provider.of<AuthProvider>(context, listen: false);
    final loggedIn = auth.isAuthenticated;
    final loggingIn = state.uri.path == '/';
        if (!loggedIn && !loggingIn) return '/';
        if (loggedIn && loggingIn) return '/dashboard';
        return null;
      },
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

    return MaterialApp.router(
      title: 'PGA 2025 - Fatec Votorantim',
      locale: const Locale('pt', 'BR'),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('pt', 'BR'), Locale('en', 'US')],
      theme: AppTheme.lightTheme,
      routerConfig: router,
      debugShowCheckedModeBanner: false,
    );
  }
}
