import 'package:flutter/material.dart';
import 'detail_klinik.dart';

class KlinikCantikScreen extends StatelessWidget {
  final List<Map<String, String>> clinics = [
    {"name": "Inusa Clinic", "image": "assets/inusa.png"},
    {"name": "Derma Exp", "image": "assets/derma.png"},
    {"name": "Benings", "image": "assets/benings.png"},
    {"name": "Beauty Lux", "image": "assets/beauty_lux.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Klinik Cantik"),
        backgroundColor: Colors.purple[200],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // Jumlah kolom
            crossAxisSpacing: 16, // Jarak horizontal antar item
            mainAxisSpacing: 16, // Jarak vertikal antar item
          ),
          itemCount: clinics.length,
          itemBuilder: (context, index) {
            final clinic = clinics[index];
            return ClinicCard(
              name: clinic['name']!,
              image: clinic['image']!,
              onTap: () {
                // Navigasi ke halaman detail
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailKlinikScreen(
                      name: clinic['name']!,
                      image: clinic['image']!,
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class ClinicCard extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;

  const ClinicCard({
    Key? key,
    required this.name,
    required this.image,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              image,
              height: 80,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

