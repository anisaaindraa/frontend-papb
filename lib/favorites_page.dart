import 'package:flutter/material.dart';
import 'api.dart'; // Import API class
import 'response_model.dart'; // Import ResponseModel class
import 'detail_fav.dart'; // Import DetailFavPage

class FavoritesPage extends StatefulWidget {
  final Set<String>? favoriteWords;
  final void Function(String)? onRemove; // Fungsi untuk menghapus kata favorit

  const FavoritesPage({super.key, this.favoriteWords, this.onRemove});

  @override
  _FavoritesPageState createState() => _FavoritesPageState();
}

class _FavoritesPageState extends State<FavoritesPage> {
  final Map<String, ResponseModel?> _wordDetails = {}; // Menyimpan detail kata

  @override
  void initState() {
    super.initState();
    _fetchWordDetails(); // Ambil detail kata saat halaman pertama kali dimuat
  }

  // Fungsi untuk mengambil detail dari API
  Future<void> _fetchWordDetails() async {
    if (widget.favoriteWords == null || widget.favoriteWords!.isEmpty) return;

    for (String word in widget.favoriteWords!) {
      try {
        final details = await API.fetchMeaning(word);
        setState(() {
          _wordDetails[word] = details;
        });
      } catch (e) {
        // Jika gagal mengambil data, simpan null sebagai detailnya
        setState(() {
          _wordDetails[word] = null;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Favorites',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Sesuaikan warna background AppBar
      ),
      backgroundColor: Colors.white, // Warna latar belakang utama
      body: _buildFavoritesList(),
    );
  }

  Widget _buildFavoritesList() {
    if (widget.favoriteWords == null || widget.favoriteWords!.isEmpty) {
      return const Center(
        child: Text(
          'Your Favorites will appear here.',
          style: TextStyle(
            fontSize: 24,
            color: Colors.black54, // Sesuaikan warna teks placeholder
          ),
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(10.0),
      itemCount: widget.favoriteWords!.length,
      itemBuilder: (context, index) {
        String word = widget.favoriteWords!.elementAt(index);
        final wordDetail = _wordDetails[word];
        return _buildWordCard(word, wordDetail);
      },
    );
  }

  Widget _buildWordCard(String word, ResponseModel? wordDetail) {
    return Card(
      color: Colors.green[50], // Menyamakan warna dengan input login
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16.0),
        title: Text(
          word,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.green[700], // Sesuaikan warna teks
          ),
        ),
        subtitle: Text(
          wordDetail?.meanings?.first.definitions?.first.definition ??
              'Definition not available.',
          style: TextStyle(
            fontSize: 16,
            color:
                wordDetail != null ? Colors.black87 : Colors.red, // Warna teks
          ),
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete, color: Colors.red),
          onPressed: () {
            if (widget.onRemove != null) {
              widget.onRemove!(word);
            }
          },
        ),
        onTap: () {
          // Navigasi ke halaman DetailFavPage
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => DetailFavPage(word: word),
            ),
          );
        },
      ),
    );
  }
}
