import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'core/theme/app_theme.dart';
import 'features/authentication/presentation/pages/login_page.dart';
import 'features/dashboard/presentation/pages/dashboard_page.dart';
import 'features/properties/presentation/pages/properties_page.dart';
import 'features/users/presentation/pages/users_page.dart';
import 'features/authentication/presentation/providers/auth_provider.dart';

void main() {
  runApp(
    ProviderScope(
      child: TheBoostBackofficeApp(),
    ),
  );
}

class TheBoostBackofficeApp extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Check authentication status on app start
    ref.read(authStateProvider.notifier).checkAuthStatus();

    return MaterialApp(
      title: 'TheBoost Backoffice',
      theme: AppTheme.lightTheme,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          final authState = ref.watch(authStateProvider);
          
          return authState.isAuthenticated 
            ? DashboardPage() 
            : LoginPage();
        },
      ),
      routes: {
        '/login': (context) => LoginPage(),
        '/dashboard': (context) => DashboardPage(),
        '/properties': (context) => PropertiesPage(),
        '/users': (context) => UsersPage(),
      },
    );
  }
}