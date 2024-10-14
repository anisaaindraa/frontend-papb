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
        title: const Text('Dictionary Pad',
            style: TextStyle(color: Colors.green)), // Set AppBar title color
        backgroundColor: Colors.white, // Change AppBar background color
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
                color: Colors.green, // Change word text color to match login
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
        Text(responseModel!.phonetic ?? "",
            style:
                TextStyle(color: Colors.green)), // Change phonetic text color
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
      color: Colors.green[50], // Change card background color to match login
      child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                meanings.partOfSpeech!,
                style: TextStyle(
                  color: Colors.green, // Change part of speech color
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
              Text(definitionList,
                  style: TextStyle(
                      color: Colors.black)), // Change definition color
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
          Text(
              setList!
                  .toSet()
                  .toString()
                  .replaceAll("{", "")
                  .replaceAll("}", ""),
              style: TextStyle(color: Colors.black)), // Change set list color
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
        style: const TextStyle(
            fontSize: 20, color: Colors.green), // Change no data text color
      )),
    );
  }

  Widget _buildSearchWidget() {
    return TextField(
      decoration: const InputDecoration(
        hintText: 'Search word here',
        border: OutlineInputBorder(),
        labelStyle: TextStyle(color: Colors.green), // Set hint text color
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              color: Colors.green, width: 2.0), // Change border color
        ),
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
