import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils.dart';
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
    if (widget.favoriteWords != null) {
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Favorites'),
        backgroundColor: ColorPalette.secondaryBackgroundColor,
      ),
      backgroundColor: Colors.white,
      body: (widget.favoriteWords != null && widget.favoriteWords!.isNotEmpty)
          ? ListView.builder(
              padding: const EdgeInsets.all(10.0),
              itemCount: widget.favoriteWords!.length,
              itemBuilder: (context, index) {
                String word = widget.favoriteWords!.elementAt(index);
                final wordDetail = _wordDetails[word];
                return Card(
                  color: ColorPalette.thirdBackgroundColor,
                  elevation: 4,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(16.0),
                    title: Text(
                      word,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: ColorPalette.textPrimaryColor,
                      ),
                    ),
                    subtitle: wordDetail != null
                        ? Text(
                            wordDetail.meanings?.first.definitions?.first
                                    .definition ??
                                'Definition not available.',
                            style: const TextStyle(
                                fontSize: 16,
                                color: ColorPalette.textSecondaryColor),
                          )
                        : const Text(
                            'Failed to load definition.',
                            style: TextStyle(
                                fontSize: 16, color: ColorPalette.errorColor),
                          ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete,
                          color: ColorPalette.errorColor),
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
              },
            )
          : const Center(
              child: Text(
                'Your Favorites will appear here.',
                style: TextStyle(
                    fontSize: 24, color: ColorPalette.textSecondaryColor),
              ),
            ),
    );
  }
}
