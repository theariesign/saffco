import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'detail_artikel_page.dart';

class ArtikelPage extends StatefulWidget {
  @override
  _ArtikelPageState createState() => _ArtikelPageState();
}

class _ArtikelPageState extends State<ArtikelPage> {
  // Mengubah tipe data menjadi List<Map<String, dynamic>> agar lebih fleksibel
  List<Map<String, dynamic>> articles = [];

  @override
  void initState() {
    super.initState();
    fetchArticles();
  }

  Future<void> fetchArticles() async {
    try {
      final response =
          await http.get(Uri.parse('http://127.0.0.1:5000/articles'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body)['articles'];

        setState(() {
          // Menggunakan Map<String, dynamic> sesuai dengan data yang diterima
          articles = data.map((article) {
            return {
              "title": article['title'], // Pastikan tipe yang sesuai
              "content": article['content'],
              "image": 'assets/${article['image_path']}',
            };
          }).toList();
        });
      } else {
        throw Exception('Failed to load articles');
      }
    } catch (error) {
      print('Error fetching articles: $error');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal memuat artikel.')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Artikel", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.purple[200],
      ),
      body: articles.isEmpty
          ? Center(
              child:
                  CircularProgressIndicator()) // Tampilkan loader saat data dimuat
          : ListView.builder(
              itemCount: articles.length,
              itemBuilder: (context, index) {
                final article = articles[index];
                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading:
                        Image.asset(article['image']!, width: 50, height: 50),
                    title: Text(article['title']!),
                    subtitle: Text("Baca Selengkapnya"),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              DetailArtikelPage(article: article),
                        ),
                      );
                    },
                  ),
                );
              },
            ),
    );
  }
}
