import 'package:flutter/material.dart';
// import 'package:flutter_application_1/home_page.dart'; // Pastikan ini diimport agar HomePage dikenali

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green, // Warna hijau sesuai tema
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(
                context); // Navigasi kembali ke halaman sebelumnya (HomePage)
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildProfileHeader(),
            const SizedBox(height: 30),
            _buildProfileForm(),
            const SizedBox(height: 30),
            _buildEditButton(context),
          ],
        ),
      ),
    );
  }

  // Header dengan gambar dan nama pengguna
  Widget _buildProfileHeader() {
    return Stack(
      children: [
        Container(
          height: 115,
          decoration: const BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(25),
              bottomRight: Radius.circular(25),
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 1,
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.green,
                ), // Placeholder icon
              ),
              const SizedBox(height: 20),
              const Text(
                'Anisya',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  // Formulir detail profil pengguna
  Widget _buildProfileForm() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        children: [
          _buildProfileDetail(Icons.person, 'Anisya', false),
          _buildProfileDetail(Icons.cake, 'January 16, 2002', false),
          _buildProfileDetail(Icons.phone, '+62 818 123 4567', false),
          _buildProfileDetail(Icons.camera_alt, '@anisya_instagram', false),
          _buildProfileDetail(Icons.email, 'anisya@example.com', false),
          _buildProfileDetail(Icons.lock, '*********', true),
        ],
      ),
    );
  }

  // Item detail profil dengan ikon
  Widget _buildProfileDetail(IconData icon, String value, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          hintText: value,
          filled: true,
          fillColor: Colors.green[50],
          enabled: false, // Tidak bisa diedit langsung
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Tombol Edit Profile
  Widget _buildEditButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Logika untuk edit profil
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      child: const Text(
        'Edit Profile',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
