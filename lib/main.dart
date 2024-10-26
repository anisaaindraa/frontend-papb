import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'home_page.dart';
import 'login_page.dart';
import 'favorites_page.dart'; // Import halaman Favorites
import 'profile_page.dart';
import 'quis_page.dart'; // Import halaman Quiz

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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
      const HomePage(), // Search Page
      FavoritesPage(
        favoriteWords: favoriteWords,
        onRemove: _removeFavorite,
      ), // Favorites Page dengan kata favorit
      const QuizPage(), // Quiz Page
      const ProfilePage(), // Profile Page
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
            icon: Icon(Icons.search, color: Colors.green), // Set icon color
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.favorite, color: Colors.green), // Set icon color
            label: 'Favorites',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.quiz, color: Colors.green), // Set icon color
            label: 'Quiz',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person, color: Colors.green), // Set icon color
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.green, // Match the green theme
        unselectedItemColor: Colors.black54, // Set a suitable unselected color
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed, // Make icons stay in place
        backgroundColor: Colors.white, // Set background color of the navbar
      ),
    );
  }
}
