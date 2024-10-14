import 'package:flutter/material.dart';
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

  static const List<Widget> _pages = <Widget>[
    HomePage(), // Search Page
    FavoritesPage(), // Favorites Page
    ProfilePage(), // Profile Page
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _pages.elementAt(_selectedIndex),
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
        selectedItemColor: const Color.fromARGB(255, 146, 223, 186),
        onTap: _onItemTapped,
      ),
    );
  }
}
