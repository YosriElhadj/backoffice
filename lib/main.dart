import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/properties/presentation/pages/properties_page.dart';
import 'features/users/presentation/pages/users_page.dart';

void main() {
  runApp(
    // Wrap the app with ProviderScope
    ProviderScope(
      child: const TheBoostBackofficeApp(),
    ),
  );
}

class TheBoostBackofficeApp extends StatelessWidget {
  const TheBoostBackofficeApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TheBoost Backoffice',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      initialRoute: '/login',
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/properties': (context) => PropertiesPage(),
        '/users': (context) => UsersPage(),
      },
    );
  }
}