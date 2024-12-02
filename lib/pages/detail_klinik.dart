import 'package:flutter/material.dart';

class DetailKlinikScreen extends StatelessWidget {
  final String name; // Nama klinik
  final String image; // Gambar klinik

  DetailKlinikScreen({super.key, required this.name, required this.image});

  final List<Map<String, String>> treatments = [
    {"name": "Laser", "image": "assets/laser.png"},
    {"name": "Facial", "image": "assets/facial.png"},
    {"name": "Hifu", "image": "assets/hilu.png"},
    {"name": "Peeling", "image": "assets/peeling.png"},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(name),
        backgroundColor: Colors.purple[200],
      ),
      body: Column(
        children: [
          // Tampilan header dengan gambar dan nama klinik
          Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                Image.asset(
                  image,
                  height: 120,
                  fit: BoxFit.cover,
                ),
                const SizedBox(height: 16),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(color: Colors.grey),
          // GridView untuk daftar treatment
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: treatments.length,
              itemBuilder: (context, index) {
                final treatment = treatments[index];
                return Container(
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
                        treatment['image']!,
                        height: 60,
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        treatment['name']!,
                        textAlign: TextAlign.center,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
