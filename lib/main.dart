import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'pages/user_provider.dart';
import 'pages/landing_page.dart';

void main() {
  runApp(const SkincareApp());
}

class SkincareApp extends StatelessWidget {
  const SkincareApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
            create: (_) => UserProvider()), // Inisialisasi UserProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        home: const LandingPage(), // LandingPage sebagai halaman pertama
        theme: ThemeData(
          primarySwatch: Colors.purple, // Warna utama aplikasi
        ),
      ),
    );
  }
}
