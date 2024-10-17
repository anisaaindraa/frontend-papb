import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _dobController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _instagramController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Set initial values here
    _nameController.text = 'Anisya';
    _dobController.text = 'January 16, 2002';
    _phoneController.text = '+62 818 123 4567';
    _instagramController.text = '@anisya_instagram';
    _emailController.text = 'anisya@example.com';
    _passwordController.text = '*********';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _dobController.dispose();
    _phoneController.dispose();
    _instagramController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorPalette.secondaryBackgroundColor,
        title: const Text('Edit Profile'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              _buildTextField(
                  Icons.person, 'Full Name', _nameController, false),
              _buildTextField(
                  Icons.cake, 'Date of Birth', _dobController, false),
              _buildTextField(
                  Icons.phone, 'Phone Number', _phoneController, false),
              _buildTextField(
                  Icons.camera_alt, 'Instagram', _instagramController, false),
              _buildTextField(Icons.email, 'Email', _emailController, false),
              _buildTextField(
                  Icons.lock, 'Password', _passwordController, true),
              const SizedBox(height: 30),
              _buildSaveButton(context),
            ],
          ),
        ),
      ),
    );
  }

  // Widget untuk membuat TextField
  Widget _buildTextField(IconData icon, String label,
      TextEditingController controller, bool isPassword) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: TextField(
        controller: controller,
        obscureText: isPassword,
        decoration: InputDecoration(
          prefixIcon: Icon(icon, color: Colors.green),
          labelText: label,
          filled: true,
          fillColor: ColorPalette.thirdBackgroundColor,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  // Tombol Save untuk menyimpan perubahan
  Widget _buildSaveButton(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Tambahkan logika untuk menyimpan perubahan profil di sini
        // Contoh: validasi dan pengiriman data ke server
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
        Navigator.pop(context);
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 32),
      ),
      child: const Text(
        'Save Changes',
        style: TextStyle(
          fontSize: 18,
          color: Colors.white,
        ),
      ),
    );
  }
}
