import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/response_model.dart';
// import 'package:flutter_application_1/utils.dart';

class DetailFavPage extends StatefulWidget {
  final String word; // Kata favorit yang dipilih

  const DetailFavPage({super.key, required this.word});

  @override
  _DetailFavPageState createState() => _DetailFavPageState();
}

class _DetailFavPageState extends State<DetailFavPage> {
  ResponseModel? _wordDetail;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchWordDetail(); // Ambil detail kata saat halaman pertama kali dimuat
  }

  // Fungsi untuk mengambil detail kata dari API
  Future<void> _fetchWordDetail() async {
    try {
      final details = await API.fetchMeaning(widget.word);
      setState(() {
        _wordDetail = details;
        _isLoading = false;
      });
    } catch (e) {
      setState(() {
        _wordDetail = null;
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.word, style: const TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : _wordDetail != null
              ? _buildDetailContent()
              : const Center(
                  child: Text(
                    'Failed to load word details.',
                    style: TextStyle(fontSize: 18, color: Colors.red),
                  ),
                ),
    );
  }

  Widget _buildDetailContent() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            _wordDetail!.word!,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _wordDetail!.phonetic ?? "",
            style: const TextStyle(
              fontSize: 18,
              color: Colors.black54,
            ),
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ListView.builder(
              itemCount: _wordDetail!.meanings!.length,
              itemBuilder: (context, index) {
                return _buildMeaningWidget(_wordDetail!.meanings![index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMeaningWidget(Meanings meaning) {
    String definitionList = "";
    meaning.definitions?.forEach((element) {
      int index = meaning.definitions!.indexOf(element);
      definitionList += "\n${index + 1}. ${element.definition}\n";
    });

    return Card(
      elevation: 4,
      color: Colors
          .green[50], // Warna latar belakang yang sama dengan halaman Favorites
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meaning.partOfSpeech!,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors
                    .green, // Konsisten dengan warna teks pada halaman Favorites
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Definitions:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            Text(
              definitionList,
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
            const SizedBox(height: 8),
            _buildSet("Synonyms", meaning.synonyms),
            _buildSet("Antonyms", meaning.antonyms),
          ],
        ),
      ),
    );
  }

  Widget _buildSet(String title, List<String>? items) {
    if (items != null && items.isNotEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "$title:",
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              items.join(', '),
              style: const TextStyle(fontSize: 16, color: Colors.black87),
            ),
          ],
        ),
      );
    } else {
      return const SizedBox.shrink();
    }
  }
}
