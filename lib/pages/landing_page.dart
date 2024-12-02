import 'package:flutter/material.dart';
import 'login_page.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    // Mendapatkan ukuran layar
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: PageView(
        controller: _pageController,
        children: [
          buildImagePage('assets/page1.png', size),
          buildImagePage('assets/page2.png', size),
          buildImagePage('assets/page3.png', size),
          buildLoginPage(
              size), // Halaman login ditambahkan sebagai halaman ke-4
        ],
        onPageChanged: (index) {
          if (index == 3) {
            // Navigasi ke halaman login jika sudah berada di halaman login
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          }
        },
      ),
    );
  }

  // Fungsi untuk membangun halaman dengan gambar
  Widget buildImagePage(String imagePath, Size size) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  // Fungsi untuk membangun halaman login sebagai halaman ke-4
  Widget buildLoginPage(Size size) {
    return Container(
      width: size.width,
      height: size.height,
      color: const Color(0xFFEADCF8), // Warna background halaman login
      child: Center(
        child: ElevatedButton(
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => LoginPage()),
            );
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF6A1B9A), // Warna tombol login
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            textStyle: const TextStyle(fontSize: 16),
          ),
          child: const Text('Masuk'),
        ),
      ),
    );
  }
}
