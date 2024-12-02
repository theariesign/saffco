import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ResetPasswordPage extends StatefulWidget {
  const ResetPasswordPage({super.key});

  @override
  _ResetPasswordPageState createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmNewPasswordController =
      TextEditingController();

  // Function to reset password
  Future<void> resetPassword(
      String username, String newPassword, BuildContext context) async {
    const url =
        'http://127.0.0.1:5000/reset-password'; // Update your backend URL here

    // Password confirmation check
    if (newPassword != confirmNewPasswordController.text) {
      _showErrorDialog(context, 'Passwords do not match');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({
          'username': username,
          'new_password': newPassword,
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        _showSuccessDialog(context, data['message']);

        // Wait for 2 seconds before navigating back to login page
        Future.delayed(const Duration(seconds: 2), () {
          Navigator.pop(
              context); // Go back to login page after successful reset
        });
      } else {
        final error = json.decode(response.body);
        _showErrorDialog(context, error['message']);
      }
    } catch (e) {
      _showErrorDialog(context, 'Failed to connect to server');
    }
  }

  // Function to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // Function to show success dialog
  void _showSuccessDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Success'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEADCF8), // Light purple background color
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 100), // Space from top
              const Text(
                'Reset Password',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(height: 20),

              // Username Field
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Enter Username',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // New Password Field
              TextField(
                controller: newPasswordController,
                decoration: InputDecoration(
                  hintText: 'New Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // Confirm New Password Field
              TextField(
                controller: confirmNewPasswordController,
                decoration: InputDecoration(
                  hintText: 'Confirm New Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Reset Password Button
              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text;
                  String newPassword = newPasswordController.text;

                  // Input validation
                  if (username.isEmpty || newPassword.isEmpty) {
                    _showErrorDialog(context, 'Please fill all fields');
                    return;
                  }

                  // Call reset password function
                  resetPassword(username, newPassword, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Reset Password'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
