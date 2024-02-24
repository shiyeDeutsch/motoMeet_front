import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';

import '../routing/routes.dart';
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
              child: Column(
                children: <Widget>[     
                  CustomTextFromField(
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
                  ElevatedButton(
                    onPressed: () {},
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
          ],
        ),
      ),
    );
  }

 
}
