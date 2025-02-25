import 'package:college_connect_canteen/common_widget/custom_button.dart';
import 'package:college_connect_canteen/common_widget/custom_text_formfield.dart';
import 'package:college_connect_canteen/features/home/home_screen.dart';
import 'package:college_connect_canteen/theme/app_theme.dart';
import 'package:college_connect_canteen/util/value_validator.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(color: secondaryColor),
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Welcome Text
                  // Login Form
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15)),
                    width: 400,
                    child: Padding(
                      padding: const EdgeInsets.all(27.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          const Text(
                            'Welcome to \nCollege Connect',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            'Canteen',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          const Text(
                            'Sign in to continue',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                            ),
                          ),

                          const SizedBox(height: 48),

                          // Email Field
                          CustomTextFormField(
                              labelText: 'Email',
                              controller: _emailController,
                              validator: emailValidator,
                              isLoading: false),
                          const SizedBox(height: 16),
                          // Password Field
                          CustomTextFormField(
                              labelText: 'Password',
                              controller: _passwordController,
                              validator: notEmptyValidator,
                              isLoading: false),

                          const SizedBox(height: 32),
                          CustomButton(
                            color: Colors.white,
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ));
                            },
                            label: 'Signin',
                          ),
                          const SizedBox(height: 32),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 24),
                  // Sign Up Text
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
