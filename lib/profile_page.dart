import 'package:flutter/material.dart';
import 'package:flutter_application_1/edit_profile.dart';
import 'package:flutter_application_1/utils.dart';
import 'package:flutter_application_1/login_page.dart'; // Import halaman login

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor:
            ColorPalette.secondaryBackgroundColor, // Warna hijau sesuai tema
        actions: [
          IconButton(
            icon: const Icon(
              Icons.logout,
              color: ColorPalette
                  .errorColor, // Menggunakan color untuk mengatur warna ikon
            ),
            onPressed: () {
              // Navigasi ke halaman login dan hapus semua rute sebelumnya
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (context) => const LoginPage()),
                (Route<dynamic> route) =>
                    false, // Menghapus semua rute sebelumnya
              );
            },
          ),
        ],
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
          height: 100,
          decoration: const BoxDecoration(
            color: ColorPalette.secondaryBackgroundColor,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
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
                radius: 40,
                backgroundColor: Colors.white,
                child: Icon(
                  Icons.person,
                  size: 50,
                  color: Colors.green,
                ), // Placeholder icon
              ),
              const SizedBox(height: 15),
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
          fillColor: ColorPalette.thirdBackgroundColor,
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
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const EditProfilePage()),
        );
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
