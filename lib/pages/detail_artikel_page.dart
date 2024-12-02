import 'package:flutter/material.dart';

class DetailArtikelPage extends StatelessWidget {
  // Ubah tipe artikel menjadi Map<String, dynamic> untuk mengakomodasi tipe data yang lebih fleksibel
  final Map<String, dynamic> article;

  DetailArtikelPage({required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel"),
        backgroundColor: Color(0xFFB39DDB),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Menampilkan gambar artikel dengan penanganan error jika gambar tidak ditemukan
            Image.asset(
              article['image'] ??
                  'assets/default_image.png', // fallback ke gambar default jika tidak ada
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Icon(Icons.image_not_supported,
                    size: 100, color: Colors.grey);
              },
            ),
            SizedBox(height: 16),
            // Judul Artikel
            Text(
              article['title'] ??
                  'No Title', // Menangani jika title kosong atau null
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Color(0xFF6A1B9A),
              ),
            ),
            SizedBox(height: 8),
            // Tanggal atau informasi tambahan (Opsional)
            Text(
              "Diterbitkan pada: 28 November 2024", // Bisa diganti dengan informasi dinamis jika ada
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            SizedBox(height: 16),
            // Konten Artikel
            Expanded(
              child: SingleChildScrollView(
                child: Text(
                  article['content'] ??
                      'No content available', // Menangani jika konten kosong atau null
                  style: TextStyle(
                      fontSize: 16, color: Colors.black87, height: 1.5),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
