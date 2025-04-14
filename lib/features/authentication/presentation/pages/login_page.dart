import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';
import '../widgets/login_form.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              AppColors.primary,
              AppColors.primaryDark,
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Container(
              width: 400,
              padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 40),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Logo
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Center(
                      child: Icon(
                        Icons.dashboard,
                        size: 60,
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  SizedBox(height: 20),

                  // Title
                  Text(
                    'TheBoost Admin',
                    style: AppStyles.headline1.copyWith(
                      color: AppColors.primary,
                      fontSize: 28,
                    ),
                  ),
                  SizedBox(height: 10),
                  Text(
                    'Admin Management Platform',
                    style: AppStyles.bodyRegular.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                  SizedBox(height: 30),

                  // Login Form
                  LoginForm(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}