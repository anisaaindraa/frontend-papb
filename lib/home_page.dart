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
  Set<String> favoriteWords = {}; // Set to store favorite words

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildSearchWidget(),
            const SizedBox(
              height: 12,
            ),
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
                color: Colors.purple.shade600,
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
        Text(responseModel!.phonetic ?? ""),
        const SizedBox(height: 16),
        Expanded(
            child: ListView.builder(
          itemBuilder: (context, index) {
            return _buildMeaningWidget(responseModel!.meanings![index]);
          },
          itemCount: responseModel!.meanings!.length,
        )),
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
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meanings.partOfSpeech!,
                style: TextStyle(
                  color: Colors.orange.shade600,
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
              Text(definitionList),
              _buildSet("Synonyms", meanings.synonyms),
              _buildSet("Antonyms", meanings.antonyms),
            ],
          )),
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
          Text(setList!
              .toSet()
              .toString()
              .replaceAll("{", "")
              .replaceAll("}", "")),
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
        style: const TextStyle(fontSize: 20),
      )),
    );
  }

  Widget _buildSearchWidget() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search word here',
        border: OutlineInputBorder(),
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
