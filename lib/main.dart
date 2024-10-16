import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'favorites_page.dart'; // Import halaman Favorites
import 'profile_page.dart'; // Import halaman Profile

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Dictionary Pad',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const LoginPage(), // Set the initial route to LoginPage
    );
  }
}

class HomePageWithNav extends StatefulWidget {
  const HomePageWithNav({super.key});

  @override
  _HomePageWithNavState createState() => _HomePageWithNavState();
}

class _HomePageWithNavState extends State<HomePageWithNav> {
  int _selectedIndex = 0;
  Set<String> favoriteWords = {"chat", "mobile", "love"}; // Kata dummy

  // Fungsi untuk menghapus kata dari daftar favorit
  void _removeFavorite(String word) {
    setState(() {
      favoriteWords.remove(word);
    });
  }

  // Fungsi untuk mendapatkan halaman sesuai dengan index
  List<Widget> _getPages() {
    return [
      HomePage(), // Search Page
      FavoritesPage(
        favoriteWords: favoriteWords,
        onRemove: _removeFavorite,
      ), // Favorites Page dengan kata favorit
      ProfilePage(), // Profile Page
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _getPages().elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite),
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: ColorPalette.secondaryBackgroundColor,
        onTap: _onItemTapped,
      ),
    );
  }
}
