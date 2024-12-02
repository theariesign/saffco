import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FavoritPage extends StatefulWidget {
  @override
  _FavoritPageState createState() => _FavoritPageState();
}

class _FavoritPageState extends State<FavoritPage> {
  List<Map<String, String>> favoritList = [];
  bool showNotification = false;

  // Mengambil data favorit dari API
  Future<void> fetchFavorites() async {
    final response = await http.get(
      Uri.parse(
          'http://127.0.0.1:5000/favorites/username'), // Ganti dengan username yang sesuai
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      setState(() {
        favoritList = List<Map<String, String>>.from(
          data['favorites'].map((item) => {
                'name': item['product_name'],
                'image': item[
                    'product_image_url'], // Pastikan API mengirim URL gambar
              }),
        );
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error fetching favorites')),
      );
    }
  }

  // Menghapus favorit dari API
  Future<void> deleteFavorit(int index) async {
    final product = favoritList[index];
    final response = await http.delete(
      Uri.parse(
          'http://127.0.0.1:5000/favorites/username'), // Sesuaikan dengan endpoint untuk menghapus favorit
      body: json.encode({'product_name': product['name']}),
    );

    if (response.statusCode == 200) {
      setState(() {
        favoritList.removeAt(index);
        showNotification = true;
      });

      // Sembunyikan notifikasi setelah beberapa detik
      Future.delayed(Duration(seconds: 3), () {
        setState(() {
          showNotification = false;
        });
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error deleting product from favorites')),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetchFavorites(); // Ambil data favorit ketika halaman pertama kali dimuat
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Favorit"),
        backgroundColor: Colors.purple[200],
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        children: [
          // Jika tidak ada produk favorit
          if (favoritList.isEmpty)
            Center(
              child: Text(
                "Belum ada produk favorit",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          // Jika ada produk favorit
          if (favoritList.isNotEmpty)
            ListView.builder(
              padding: EdgeInsets.all(16),
              itemCount: favoritList.length,
              itemBuilder: (context, index) {
                final product = favoritList[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      // Gambar produk
                      ClipRRect(
                        borderRadius: BorderRadius.circular(12),
                        child: Image.network(
                          product['image']!,
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                        ),
                      ),
                      SizedBox(width: 16),
                      // Informasi produk
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              product['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                            SizedBox(height: 8),
                            ElevatedButton(
                              onPressed: () {
                                // Tampilkan detail produk (opsional)
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content:
                                        Text("Info produk: ${product['name']}"),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.purple[100],
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                              child: Text("Info",
                                  style: TextStyle(color: Colors.black)),
                            ),
                          ],
                        ),
                      ),
                      // Tombol hapus
                      IconButton(
                        icon: Icon(Icons.favorite, color: Colors.red),
                        onPressed: () {
                          deleteFavorit(index);
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
          // Notifikasi saat produk dihapus
          if (showNotification)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                color: Colors.purple[100],
                padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Produk Dihapus dari Favorit",
                      style: TextStyle(fontSize: 16),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          showNotification = false; // Sembunyikan notifikasi
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                      ),
                      child: Text("Batal"),
                    ),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: FavoritPage(),
  ));
}
