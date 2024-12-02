import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'artikel_pages.dart';
import 'search_page.dart';
import 'treatment.dart';
import 'favorit_pages.dart';
import 'profile.dart';
import 'user_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  // List of screens for each tab
  final List<Widget> _pages = [
    HomeContent(), // Konten utama (halaman Home)
    ArtikelPage(), // Halaman Artikel
    SearchPage(),
    KlinikCantikScreen(), // Halaman Treatment
    FavoritPage(), // Halaman Favorit
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEADCF8), // Warna ungu muda
      body: _pages[_currentIndex], // Menampilkan halaman sesuai index
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Mengganti halaman saat tab ditekan
          });
        },
        backgroundColor: Colors.white,
        selectedItemColor:
            const Color(0xFF6A1B9A), // Warna ungu untuk item aktif
        unselectedItemColor:
            Colors.grey, // Warna abu-abu untuk item tidak aktif
        showUnselectedLabels: true, // Menampilkan label di item tidak aktif
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Home",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.article),
            label: "Artikel",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: "Search",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.medical_services),
            label: "Treatment",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: "Favorit",
          ),
        ],
      ),
    );
  }
}

class HomeContent extends StatelessWidget {
  const HomeContent({super.key});

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final username = Provider.of<UserProvider>(context).username;

    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(screenWidth * 0.04), // Padding responsif
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header dengan avatar dan salam
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Container putih untuk box header
                  Container(
                    padding:
                        EdgeInsets.all(screenWidth * 0.03), // Padding responsif
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Row(
                      children: [
                        // Kolom untuk teks salam
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hai $username...", // Teks salam
                              style: TextStyle(
                                fontSize:
                                    screenWidth * 0.06, // Ukuran font responsif
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF6A1B9A),
                              ),
                            ),
                            SizedBox(
                                height: screenHeight * 0.01), // Jarak vertikal
                            Text(
                              "Senang ketemu lagi sama kamu.",
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.04, // Ukuran font responsif
                                  color: Colors.black54),
                            ),
                            SizedBox(
                                height: screenHeight * 0.01), // Jarak vertikal
                            Text(
                              "Apa masalah kulitmu hari ini?",
                              style: TextStyle(
                                  fontSize: screenWidth *
                                      0.04, // Ukuran font responsif
                                  color: Colors.black54),
                            ),
                          ],
                        ),
                        SizedBox(
                            width: screenWidth *
                                0.04), // Jarak horizontal antara teks dan avatar
                        // Kolom untuk avatar dan tombol
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Avatar responsif
                            CircleAvatar(
                              radius:
                                  screenWidth * 0.1, // Ukuran radius responsif
                              backgroundImage: const AssetImage(
                                  'assets/profil.png'), // Ganti dengan gambar profil
                            ),
                            SizedBox(
                                height: screenHeight * 0.01), // Jarak vertikal
                            ElevatedButton(
                              onPressed: () {
                                final username = Provider.of<UserProvider>(
                                        context,
                                        listen: false)
                                    .username;

                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        ProfilePage(username: username),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF6A1B9A),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                              ),
                              child: const Text(
                                "Lihat Profil",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Masalah Wajah
              const Padding(
                padding: EdgeInsets.only(left: 5.0),
                child: Text(
                  "Apa Masalah Wajahmu Saat ini?",
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF6A1B9A),
                  ),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  buildProblemIcon(title: "Acne", imagePath: 'assets/acne.png'),
                  buildProblemIcon(
                      title: "Kusam", imagePath: 'assets/kusam.png'),
                  buildProblemIcon(
                      title: "Flek Hitam", imagePath: 'assets/flekhitam.png'),
                  buildProblemIcon(
                      title: "Kerutan", imagePath: 'assets/penuaandini.png'),
                ],
              ),
              SizedBox(height: screenHeight * 0.02),

              // Artikel dan Treatment
              Container(
                padding: EdgeInsets.all(screenWidth * 0.04),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ArtikelPage()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.article, color: Color(0xFF6A1B9A)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Baca Artikel Dulu Yuk...",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                    const Divider(height: 30, thickness: 1),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => KlinikCantikScreen()),
                        );
                      },
                      child: const Row(
                        children: [
                          Icon(Icons.medical_services,
                              color: Color(0xFF6A1B9A)),
                          SizedBox(width: 10),
                          Expanded(
                            child: Text(
                              "Treatment aja nih",
                              style: TextStyle(fontSize: 16),
                            ),
                          ),
                          Icon(Icons.arrow_forward_ios, size: 16),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: screenHeight * 0.02),

              // Produk Rekomendasi
              const Text(
                "Rekomendasi buat kamu nih",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF6A1B9A),
                ),
              ),
              SizedBox(height: screenHeight * 0.02),
              GridView.builder(
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: 4,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10,
                  crossAxisSpacing: 10,
                  childAspectRatio: 0.75,
                ),
                itemBuilder: (context, index) {
                  return buildProductCard();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildProblemIcon({required String title, required String imagePath}) {
    return Column(
      children: [
        CircleAvatar(
          radius: 30,
          backgroundColor: Colors.purple[100],
          child: Image.asset(imagePath, fit: BoxFit.cover),
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: const TextStyle(fontSize: 14, color: Color(0xFF6A1B9A)),
        ),
      ],
    );
  }

  Widget buildProductCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                image: AssetImage('assets/sample_product.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  "Nama Produk",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 4),
                Text(
                  "Deskripsi singkat produk.",
                  style: TextStyle(fontSize: 12, color: Colors.black54),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
