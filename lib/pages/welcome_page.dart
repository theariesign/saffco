import 'package:flutter/material.dart';
import 'homepages.dart';

class WelcomePage extends StatefulWidget {
  final int userId; // Menyimpan userId jika diperlukan

  const WelcomePage({Key? key, required this.userId}) : super(key: key);

  @override
  _WelcomePageState createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  void initState() {
    super.initState();
    // Navigasi otomatis ke HomePage setelah 4 detik
    Future.delayed(Duration(seconds: 2), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    // Menentukan ukuran layar
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Colors.white, // Background putih
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            // Menampilkan gambar dengan ukuran responsif
            Container(
              width:
                  screenWidth * 0.8, // Gambar akan mengisi 80% dari lebar layar
              height: screenHeight *
                  0.5, // Gambar akan mengisi 50% dari tinggi layar
              child: FittedBox(
                fit: BoxFit.contain, // Gambar akan tetap proporsional
                child: Image.asset(
                  'assets/Welcome Page.png', // Ganti dengan nama file gambar Anda
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
