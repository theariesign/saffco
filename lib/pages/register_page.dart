import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'login_page.dart';  // Pastikan halaman LoginPage telah dibuat

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  // Function to register
  Future<void> register(
      String username, String password, BuildContext context) async {
    const url =
        'http://127.0.0.1:5000/register'; // Update your backend URL here

    if (password != confirmPasswordController.text) {
      _showErrorDialog(context, 'Password tidak cocok');
      return;
    }

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode({'username': username, 'password': password}),
      );

      if (response.statusCode == 201) {
        final data = json.decode(response.body);
        _showSuccessDialog(context, data['message']);
      } else {
        final error = json.decode(response.body);
        _showErrorDialog(context, error['message']);
      }
    } catch (e) {
      _showErrorDialog(context, 'Gagal terhubung ke server');
    }
  }

  // Function to show error dialog
  void _showErrorDialog(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Kesalahan'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to login page
                );
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
          title: const Text('Berhasil'),
          content: Text(message),
          actions: <Widget>[
            TextButton(
              child: const Text('OK'),
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to login page
                );
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
              // Register Title
              const Text(
                'Registrasi',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              const SizedBox(height: 20),

              // Registration Image
              Image.asset(
                'assets/rainbow.png', // Change with your rainbow asset
                height: 100,
              ),
              const SizedBox(height: 20),

              // Username Field
              TextField(
                controller: usernameController,
                decoration: InputDecoration(
                  hintText: 'Masukkan Username',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              const SizedBox(height: 10),

              // Password Field
              TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  hintText: 'Buat Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 10),

              // Confirm Password Field
              TextField(
                controller: confirmPasswordController,
                decoration: InputDecoration(
                  hintText: 'Konfirmasi Password',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                obscureText: true,
              ),
              const SizedBox(height: 20),

              // Register Button
              ElevatedButton(
                onPressed: () {
                  String username = usernameController.text;
                  String password = passwordController.text;

                  // Input validation
                  if (username.isEmpty ||
                      password.isEmpty ||
                      confirmPasswordController.text.isEmpty) {
                    _showErrorDialog(context, 'Harap isi semua kolom');
                    return;
                  }

                  // Hide keyboard after validation
                  FocusScope.of(context).unfocus();

                  // Call the register function
                  register(username, password, context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6A1B9A),
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Daftar Sekarang'),
              ),

              // Link to Login Page
              const SizedBox(height: 10),
              TextButton(
                onPressed: () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginPage()), // Redirect to login page
                  );
                },
                child: const Text(
                  'Sudah punya akun? Masuk disini',
                  style: TextStyle(color: Color(0xFF6A1B9A)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
