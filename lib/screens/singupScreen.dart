import 'package:flutter/material.dart';

import '../routing/routes.dart';
import '../widgets/customTextFromField.dart';

class SignupScreen extends StatelessWidget {
  SignupScreen({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();
  final confirmController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Image.asset(
                  'assets/images/Image (1).png'), // Replace with your asset image
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                    const Text(
                      'Create an account to join the',
                      textAlign: TextAlign.center,
                      style: TextStyle(fontSize: 16),
                    ),
                    const Text(
                      'MapSpiration',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    CustomTextFromField(
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter an email address';
                        } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                            .hasMatch(value!)) {
                          return 'Enter a valid email address';
                        }
                        return null;
                      },
                      suffixIcon: const Icon(
                        Icons.mail,
                      ),
                      hintText: 'email',
                      controller: emailController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter a password';
                        } else if (!RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{6,}$')
                            .hasMatch(value!)) {
                          return 'Invalid password. Should be at least 6 characters long\nwith at least one digit.';
                        }
                        return null;
                      },
                      isPassword: true,
                      suffixIcon: const Icon(
                        Icons.lock,
                      ),
                      hintText: 'password',
                      controller: passwordController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please confirm your password';
                        } else if (value != passwordController.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      isPassword: true,
                      suffixIcon: const Icon(
                        Icons.lock_outline_rounded,
                      ),
                      hintText: 'confirm password',
                      controller: confirmController,
                    ),
                    const SizedBox(height: 24),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          Navigator.of(context).pushNamed(
                            Routes.step1,
                            arguments: {
                              'email': emailController.text,
                              'password': passwordController.text,
                           
                            },
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black, // background (button) color
                        backgroundColor: Colors.white, // foreground (text) color
                      ),
                      child: const Padding(
                        padding: EdgeInsets.symmetric(vertical: 12),
                        child: Text('Sign up'),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.login);
                      },
                      child: const Text('Already a member? Log in'),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
