import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';
 
import 'package:motomeetfront/services/userService.dart';

import '../models/userModel.dart';
import '../routing/routes.dart';
import '../services/authService.dart';
import '../services/isar/isar_user_info.dart';
import '../services/isar/repository_provider.dart';
import '../services/loctionService.dart';
import '../widgets/customTextFromField.dart';
import '../widgets/dropdown.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            Image.asset(
                'assets/images/Image.png'), // Replace with your image asset
            SizedBox(
              height: 20,
            ),
            const Text(
              'Welcome to MapSpiration',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(
              height: 5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: <Widget>[
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
                      onChanged: (string) => setState(() {}),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    CustomTextFromField(
                      validator: (value) {
                        if (value?.isEmpty ?? false) {
                          return 'Please enter a password';
                        } else {
                          return null;
                        }
                      },
                      isPassword: true,
                      suffixIcon: const Icon(
                        Icons.lock,
                      ),
                      hintText: 'password',
                      controller: passwordController,
                      onChanged: (string) => setState(() {}),
                    ),
                    Text(
                      emailController.text,
                      style: TextStyle(color: Colors.blueAccent),
                    ),
                    const SizedBox(height: 24),
                    _isLoading
                        ? CircularProgressIndicator()
                        : ElevatedButton(
                            onPressed: () => _handleLogin(context),
                            child: const Text('Log in'),
                          ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushNamed(Routes.signUp);
                      },
                      child: const Text('Sign up'),
                    ),
                    TextButton(
                      onPressed: () {},
                      child: const Text('Forgot your password?'),
                    ),
                    const Divider(),
                    TextButton.icon(
                      icon: const Icon(Icons.login),
                      label: const Text('Or sign in with Google'),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
  
  Future<void> _handleLogin(BuildContext context) async {
    if (!_formKey.currentState!.validate()) return;
    
    setState(() {
      _isLoading = true;
    });
    
    try {
      final auth = GetIt.I<AuthService>();
      final token = await auth.login(
          emailController.text, passwordController.text);

      if (token != null) {
        final userService = GetIt.I<UserService>();
        UserInfo user = await userService.fetchUserProfile(token) ??
            UserInfo(token: token);
            
        // Store user profile to repository
        final repositoryProvider = GetIt.I<RepositoryProvider>();
        final isarService = repositoryProvider.userInfoRepository;
        await isarService.add(user);
        
        // Update location data
        final location  = await LocationService.getCurrentLocation; 
        await userService.sendGeoLocation(token, location);
       

        // Navigate to home page
        Navigator.of(context).pushReplacementNamed(Routes.homePage);
      } else {
        // Show error message
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Login failed. Please check your credentials.')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
