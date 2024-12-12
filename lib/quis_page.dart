// import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/response_model.dart';
import 'package:flutter_application_1/api.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Map<String, dynamic>> quizData = [];
  int currentQuizIndex = 0;
  int scoreCorrect = 0;
  int scoreIncorrect = 0;
  bool showAnswer = false;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadQuizData();
  }

  Future<void> _loadQuizData() async {
    try {
      // Daftar kata untuk kuis
      List<String> words = [
        "aberration",
        "belligerent",
        "candid",
        "dauntless",
        "love",
        "truthful",
        "liar",
        "what"
      ];
      List<Map<String, dynamic>> data = [];

      for (var word in words) {
        try {
          ResponseModel response = await API.fetchMeaning(word);
          var definition = response.meanings?[0].definitions?[0].definition ??
              "Not available";
          List<String> dummyOptions = [
            "Deviation from the norm",
            "Hostile or aggressive behavior",
            "Straightforward and honest communication",
            "Fearless and determined attitude",
            "An intense feeling of affection",
            "Expressing sincerity and truth",
            "A person who tells lies",
            "A request for information or clarification"
          ];

          List<String> options = ([definition] + dummyOptions)..shuffle();

          data.add({
            "word": word,
            "definition": definition,
            "options": options,
          });
        } catch (_) {
          print("Failed to fetch definition for $word.");
        }
      }

      setState(() {
        quizData = data;
        isLoading = false;
      });
    } catch (e) {
      print("Error loading quiz data: $e");
    }
  }

  void _nextQuiz() {
    if (currentQuizIndex < quizData.length - 1) {
      setState(() {
        currentQuizIndex++;
        showAnswer = false;
      });
    } else {
      _showFinalScore();
    }
  }

  void _checkAnswer(String selectedOption) {
    if (!showAnswer) {
      setState(() {
        if (selectedOption == quizData[currentQuizIndex]["definition"]) {
          scoreCorrect++;
        } else {
          scoreIncorrect++;
        }
        showAnswer = true;
      });
    }
  }

  void _showFinalScore() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          backgroundColor: Colors.green[50],
          title: const Text(
            "Congratulations!",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.green,
            ),
          ),
          content: Text(
            "You've completed the quiz!\n"
            "Your Score:\n"
            "- Correct: $scoreCorrect\n"
            "- Incorrect: $scoreIncorrect",
            style: const TextStyle(fontSize: 18, color: Colors.black87),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
                setState(() {
                  currentQuizIndex = 0;
                  scoreCorrect = 0;
                  scoreIncorrect = 0;
                  showAnswer = false;
                });
              },
              child: const Text(
                "Restart",
                style: TextStyle(color: Colors.green),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return const Scaffold(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    final quizItem = quizData[currentQuizIndex];
    final options = quizItem["options"] as List<String>;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Word Quiz',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.green[50],
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Score: Correct $scoreCorrect | Incorrect $scoreIncorrect',
              style: const TextStyle(fontSize: 20, color: Colors.green),
            ),
            const SizedBox(height: 20),
            Text(
              'What is the definition of "${quizItem["word"]}"?',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: ListView(
                children: options.map((option) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: showAnswer
                            ? (option == quizItem["definition"]
                                ? Colors.green
                                : Colors.red)
                            : Colors.white,
                        minimumSize: const Size.fromHeight(50),
                        side: BorderSide(
                          color: showAnswer
                              ? (option == quizItem["definition"]
                                  ? Colors.green
                                  : Colors.red)
                              : Colors.green,
                        ),
                      ),
                      onPressed: () => _checkAnswer(option),
                      child: Text(
                        option,
                        style: TextStyle(
                          color: showAnswer ? Colors.white : Colors.green[700],
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const SizedBox(height: 20),
            if (showAnswer)
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: const Size.fromHeight(50),
                ),
                onPressed: _nextQuiz,
                child: Text(
                  currentQuizIndex < quizData.length - 1 ? "Next" : "Finish",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
