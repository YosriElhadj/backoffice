import 'package:flutter/material.dart';
import '../../../../core/constants/app_colors.dart';
import '../../../../core/constants/app_styles.dart';

class LoginForm extends StatefulWidget {
  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isLoading = false;

  // Simple authentication method
  Future<void> _performLogin() async {
    // Basic validation
    if (_emailController.text.isEmpty || _passwordController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter both email and password'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // Simulate login process
    setState(() {
      _isLoading = true;
    });

    try {
      // Simulated delay to mimic authentication process
      await Future.delayed(Duration(seconds: 2));

      // Simple hardcoded credentials check (replace with actual authentication later)
      if (_emailController.text == 'admin@theboost.com' && 
          _passwordController.text == 'admin123') {
        // Navigate to dashboard
        Navigator.of(context).pushReplacementNamed('/dashboard');
      } else {
        // Show error for invalid credentials
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Invalid email or password'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      // Handle any errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Login failed: ${e.toString()}'),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Administrator Login',
          style: AppStyles.headline2.copyWith(color: AppColors.primary),
        ),
        const SizedBox(height: 16),
        Text(
          'Please enter your admin credentials',
          style: AppStyles.bodyRegular,
        ),
        const SizedBox(height: 32),
        
        // Email TextField
        TextField(
          controller: _emailController,
          decoration: InputDecoration(
            labelText: 'Email Address',
            prefixIcon: Icon(Icons.email, color: AppColors.primary),
          ),
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 16),
        
        // Password TextField
        TextField(
          controller: _passwordController,
          decoration: InputDecoration(
            labelText: 'Password',
            prefixIcon: Icon(Icons.lock, color: AppColors.primary),
            suffixIcon: IconButton(
              icon: Icon(
                _obscurePassword ? Icons.visibility_off : Icons.visibility,
                color: AppColors.primary,
              ),
              onPressed: () {
                setState(() {
                  _obscurePassword = !_obscurePassword;
                });
              },
            ),
          ),
          obscureText: _obscurePassword,
          onSubmitted: (_) => _performLogin(), // Allow login on Enter key
        ),
        const SizedBox(height: 24),
        
        // Forgot Password
        Align(
          alignment: Alignment.centerRight,
          child: TextButton(
            onPressed: () {
              // TODO: Implement forgot password
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Forgot password functionality coming soon'),
                ),
              );
            },
            child: Text(
              'Forgot Password?',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ),
        const SizedBox(height: 16),
        
        // Login Button
        SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _isLoading ? null : _performLogin,
            child: _isLoading 
              ? CircularProgressIndicator(color: Colors.white)
              : Text('Login', style: AppStyles.buttonText),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}