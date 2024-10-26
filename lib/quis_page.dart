import 'dart:math';
import 'package:flutter/material.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  final List<Map<String, dynamic>> quizData = [
    {
      "word": "aberration",
      "definition": "A departure from what is normal or expected.",
      "options": [
        "A natural disaster",
        "A departure from what is normal or expected.",
        "A mathematical equation",
        "A type of animal"
      ]
    },
    {
      "word": "belligerent",
      "definition": "Hostile and aggressive.",
      "options": [
        "Friendly and peaceful",
        "Curious and inquisitive",
        "Hostile and aggressive.",
        "Calm and collected"
      ]
    },
    {
      "word": "candid",
      "definition": "Truthful and straightforward.",
      "options": [
        "Deceptive and dishonest",
        "Truthful and straightforward.",
        "Unclear and ambiguous",
        "Complicated and confusing"
      ]
    },
    // Add more word quizzes as needed
  ];

  int currentQuizIndex = 0;
  int score = 0;
  bool showAnswer = false;

  void _nextQuiz() {
    setState(() {
      currentQuizIndex = (currentQuizIndex + 1) % quizData.length;
      showAnswer = false;
    });
  }

  void _checkAnswer(String selectedOption) {
    if (!showAnswer) {
      setState(() {
        if (selectedOption == quizData[currentQuizIndex]["definition"]) {
          score++;
        }
        showAnswer = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final quizItem = quizData[currentQuizIndex];
    final options = List<String>.from(quizItem["options"]);
    options.shuffle(Random());

    return Scaffold(
      appBar: AppBar(
        title: const Text('Word Quiz', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Score: $score',
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
            ...options.map((option) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: showAnswer
                        ? (option == quizItem["definition"]
                            ? Colors.green
                            : Colors.red)
                        : Colors.green[50], // Same as FavoritesPage
                    minimumSize: const Size.fromHeight(50),
                  ),
                  onPressed: () => _checkAnswer(option),
                  child: Text(
                    option,
                    style: TextStyle(
                      color: Colors.green[700], // Match text color
                    ),
                  ),
                ),
              );
            }).toList(),
            const SizedBox(height: 20),
            if (showAnswer)
              ElevatedButton(
                onPressed: _nextQuiz,
                child: const Text("Next"),
              )
          ],
        ),
      ),
    );
  }
}
