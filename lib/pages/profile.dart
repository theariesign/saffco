import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'login_page.dart';

class ProfilePage extends StatefulWidget {
  final String username;

  const ProfilePage({Key? key, required this.username}) : super(key: key);

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController noTeleponController = TextEditingController();
  TextEditingController alamatController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool isLoading = true; // Untuk menampilkan indikator loading
  bool isSaving = false; // Untuk menampilkan efek blur saat proses simpan
  File? _avatarFile;
  String _avatarUrl = '';

  @override
  void initState() {
    super.initState();
    fetchUserData();
  }

  // Fungsi untuk mengambil data pengguna
  Future<void> fetchUserData() async {
    final url = 'http://127.0.0.1:5000/profile/${widget.username}';

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        setState(() {
          emailController.text = data['email'] ?? '';
          noTeleponController.text = data['no_telepon'] ?? '';
          alamatController.text = data['alamat'] ?? '';
          usernameController.text = data['username'] ?? '';
          if (data['avatar_path'] != null) {
            _avatarFile = File(data['avatar_path']);
          }
          isLoading = false;
        });
      } else {
        showError('Gagal memuat data pengguna');
      }
    } catch (e) {
      showError('Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk memperbarui data pengguna
  Future<void> updateUserData() async {
    setState(() {
      isSaving = true; // Tampilkan efek blur
    });

    final url = 'http://127.0.0.1:5000/profile/${widget.username}';
    final updatedData = {
      'email': emailController.text,
      'no_telepon': noTeleponController.text,
      'alamat': alamatController.text,
    };

    try {
      final response = await http.put(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(updatedData),
      );

      if (response.statusCode == 200) {
        // Tambahkan delay 1 detik untuk menampilkan blur
        await Future.delayed(const Duration(seconds: 1));

        setState(() {
          isSaving = false; // Matikan efek blur
        });

        showSuccessDialog('Pembaruan profil berhasil disimpan.');
      } else {
        setState(() {
          isSaving = false; // Matikan efek blur
        });
        showError('Gagal memperbarui profil');
      }
    } catch (e) {
      setState(() {
        isSaving = false; // Matikan efek blur
      });
      showError('Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk mengunggah avatar
  Future<void> uploadAvatar() async {
    if (_avatarFile == null) return; // Pastikan ada file foto

    final url = 'http://127.0.0.1:5000/profile/${widget.username}';
    var request = http.MultipartRequest('PUT', Uri.parse(url));

    // Menambahkan file foto
    request.files.add(await http.MultipartFile.fromPath(
      'file',
      _avatarFile!.path,
    ));

    // Menambahkan data lainnya seperti email, no_telepon, dan alamat
    request.fields['email'] = emailController.text;
    request.fields['no_telepon'] = noTeleponController.text;
    request.fields['alamat'] = alamatController.text;

    try {
      final response = await request.send();

      if (response.statusCode == 200) {
        final responseBody = await response.stream.bytesToString();
        final data = json.decode(responseBody);

        setState(() {
          // Update path avatar dengan yang baru
          _avatarUrl = data['avatar_url'] ?? '';
        });

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Avatar berhasil diperbarui!')),
        );
      } else {
        showError('Gagal mengunggah avatar');
      }
    } catch (e) {
      showError('Terjadi kesalahan: $e');
    }
  }

  // Fungsi untuk memilih gambar avatar
  Future<void> pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _avatarFile = File(pickedFile.path);
      });
    }
  }

  Future<void> showSuccessDialog(String message) async {
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Berhasil'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    );
  }

  void showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil'),
      ),
      body: Stack(
        children: [
          isLoading
              ? const Center(child: CircularProgressIndicator())
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      GestureDetector(
                        onTap:
                            pickImage, // Membuka galeri saat avatar atau ikon dikli
                        child: Stack(
                          alignment: Alignment.bottomRight,
                          children: [
                            CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey,
                              backgroundImage: _avatarUrl.isNotEmpty
                                  ? NetworkImage(
                                          'http://127.0.0.1:5000$_avatarUrl')
                                      as ImageProvider
                                  : (_avatarFile != null
                                      ? FileImage(_avatarFile!) as ImageProvider
                                      : null),
                              child: (_avatarFile == null && _avatarUrl.isEmpty)
                                  ? const Icon(Icons.person, size: 50)
                                  : null,
                            ),
                            Container(
                              padding: const EdgeInsets.all(4.0),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border:
                                    Border.all(color: Colors.grey, width: 1),
                              ),
                              child: const Icon(Icons.edit,
                                  color: Colors.grey, size: 18),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 8),
                      const Text(
                        'Edit Foto Profil',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        controller: emailController,
                        decoration: const InputDecoration(labelText: 'Email'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: noTeleponController,
                        decoration:
                            const InputDecoration(labelText: 'No Telepon'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: alamatController,
                        decoration: const InputDecoration(labelText: 'Alamat'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: usernameController,
                        decoration:
                            const InputDecoration(labelText: 'Username'),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: passwordController,
                        decoration:
                            const InputDecoration(labelText: 'Password'),
                        obscureText: true,
                      ),
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.red,
                                foregroundColor: Colors.white, // Teks putih
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              onPressed: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => LoginPage()),
                                );
                              },
                              child: const Text('Log Out'),
                            ),
                          ),
                          Expanded(
                            child: ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.green,
                                foregroundColor: Colors.white, // Teks putih
                                padding: const EdgeInsets.symmetric(
                                  vertical: 16,
                                ),
                              ),
                              onPressed: updateUserData,
                              child: const Text('Simpan'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
          if (isSaving)
            Container(
              color: Colors.black45,
              child: const Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }
}
