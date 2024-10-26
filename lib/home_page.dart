import 'package:flutter/material.dart';
import 'package:flutter_application_1/api.dart';
import 'package:flutter_application_1/response_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool inProgress = false;
  ResponseModel? responseModel;
  String noDataText = "Welcome, Start searching";
  Set<String> favoriteWords = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Dictionary Pad',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green, // Gunakan warna hijau gelap
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchWidget(),
            const SizedBox(height: 12),
            if (inProgress)
              const LinearProgressIndicator()
            else if (responseModel != null)
              Expanded(child: _buildResponseWidget())
            else
              _noDataWidget(),
          ],
        ),
      ),
    );
  }

  Widget _buildResponseWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              responseModel!.word!,
              style: TextStyle(
                color: Colors.green[700], // Warna hijau untuk teks kata
                fontWeight: FontWeight.bold,
                fontSize: 22,
              ),
            ),
            IconButton(
              icon: Icon(
                favoriteWords.contains(responseModel!.word)
                    ? Icons.favorite
                    : Icons.favorite_border,
                color: favoriteWords.contains(responseModel!.word)
                    ? Colors.red
                    : Colors.grey,
              ),
              onPressed: () {
                setState(() {
                  if (favoriteWords.contains(responseModel!.word)) {
                    favoriteWords.remove(responseModel!.word);
                  } else {
                    favoriteWords.add(responseModel!.word!);
                  }
                });
              },
            ),
          ],
        ),
        Text(
          responseModel!.phonetic ?? "",
          style: TextStyle(color: Colors.grey[600]),
        ),
        const SizedBox(height: 16),
        Expanded(
          child: ListView.builder(
            itemBuilder: (context, index) {
              return _buildMeaningWidget(responseModel!.meanings![index]);
            },
            itemCount: responseModel!.meanings!.length,
          ),
        ),
      ],
    );
  }

  Widget _buildMeaningWidget(Meanings meanings) {
    String definitionList = "";
    meanings.definitions?.forEach((element) {
      int index = meanings.definitions!.indexOf(element);
      definitionList += "\n${index + 1}. ${element.definition}\n";
    });

    return Card(
      elevation: 4,
      color: Colors.green[50], // Warna hijau terang untuk latar belakang kartu
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              meanings.partOfSpeech!,
              style: TextStyle(
                color: Colors.green[700], // Warna hijau untuk part of speech
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            const SizedBox(height: 12),
            const Text(
              "Definitions :",
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.bold,
                fontSize: 16,
              ),
            ),
            Text(
              definitionList,
              style: const TextStyle(color: Colors.black),
            ),
            _buildSet("Synonyms", meanings.synonyms),
            _buildSet("Antonyms", meanings.antonyms),
          ],
        ),
      ),
    );
  }

  Widget _buildSet(String title, List<String>? setList) {
    if (setList?.isNotEmpty ?? false) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title: ",
            style: const TextStyle(
              color: Colors.black87,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            setList!.join(", "),
            style: const TextStyle(color: Colors.black),
          ),
          const SizedBox(height: 10),
        ],
      );
    } else {
      return const SizedBox.shrink();
    }
  }

  Widget _noDataWidget() {
    return SizedBox(
      height: 100,
      child: Center(
        child: Text(
          noDataText,
          style: const TextStyle(fontSize: 20, color: Colors.green),
        ),
      ),
    );
  }

  Widget _buildSearchWidget() {
    return TextField(
      decoration: InputDecoration(
        labelText: 'Search word here',
        labelStyle: const TextStyle(
          color: Colors.green, // Match login input label color
        ),
        prefixIcon: const Icon(
          Icons.search,
          color: Colors.green, // Icon color matching login
        ),
        filled: true,
        fillColor: Colors.green[50], // Match the background fill color
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10), // Rounded corners like login
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Colors.green, width: 2.0),
        ),
        floatingLabelBehavior: FloatingLabelBehavior.auto, // Similar to login
      ),
      onSubmitted: (value) {
        _getMeaningFromApi(value);
        print('Searching for: $value');
      },
    );
  }

  _getMeaningFromApi(String word) async {
    setState(() {
      inProgress = true;
    });
    try {
      responseModel = await API.fetchMeaning(word);
      setState(() {});
    } catch (e) {
      responseModel = null;
      noDataText = "Meaning can not be found";
    } finally {
      setState(() {
        inProgress = false;
      });
    }
  }
}
