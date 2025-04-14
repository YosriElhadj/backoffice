import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // Left Side - Branding
          Expanded(
            flex: 2,
            child: Container(
              color: AppColors.primary,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FlutterLogo(size: 100),
                    const SizedBox(height: 20),
                    Text(
                      'TheBoost Backoffice',
                      style: AppStyles.headline1.copyWith(color: Colors.white),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Admin Management Platform',
                      style: AppStyles.bodyRegular.copyWith(color: Colors.white70),
                    ),
                  ],
                ),
              ),
            ),
          ),
          
          // Right Side - Login Form
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 64, vertical: 32),
              child: LoginForm(),
            ),
          ),
        ],
      ),
    );
  }
}