import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../../core/utils/validators.dart';
import '../providers/auth_provider.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  _LoginFormState createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Trigger login via Riverpod provider
      ref.read(authStateProvider.notifier).login(
        _emailController.text.trim(), 
        _passwordController.text.trim()
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Listen to auth state changes
    final authState = ref.watch(authStateProvider);

    // Handle navigation and error states
    ref.listen<AuthState>(authStateProvider, (previous, next) {
      if (next.user != null) {
        // Successful login - navigate to dashboard
        Navigator.of(context).pushReplacementNamed('/dashboard');
      }
      
      if (next.error != null) {
        // Show error snackbar
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(next.error!),
            backgroundColor: Colors.red,
          )
        );
      }
    });

    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Email Field
          TextFormField(
            controller: _emailController,
            decoration: InputDecoration(
              labelText: 'Email Address',
              prefixIcon: Icon(Icons.email),
            ),
            validator: Validators.validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: 16),

          // Password Field
          TextFormField(
            controller: _passwordController,
            decoration: InputDecoration(
              labelText: 'Password',
              prefixIcon: Icon(Icons.lock),
              suffixIcon: IconButton(
                icon: Icon(
                  _obscurePassword 
                    ? Icons.visibility_off 
                    : Icons.visibility
                ),
                onPressed: () {
                  setState(() {
                    _obscurePassword = !_obscurePassword;
                  });
                },
              ),
            ),
            obscureText: _obscurePassword,
            validator: Validators.validatePassword,
          ),
          SizedBox(height: 24),

          // Login Button
          ElevatedButton(
            onPressed: authState.isLoading ? null : _submitForm,
            child: authState.isLoading
              ? CircularProgressIndicator()
              : Text('Login'),
          ),
        ],
      ),
    );
  }
}