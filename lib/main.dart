import 'package:flutter/material.dart';
import 'package:quizz_project/question_logic.dart';

void main() {
  runApp(const TestingApp());
}

class TestingApp extends StatelessWidget {
  const TestingApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: SafeArea(
          child: TestingPage(),
        ),
      ),
    );
  }
}

class TestingPage extends StatefulWidget {
  const TestingPage({Key? key}) : super(key: key);

  @override
  _TestingPageState createState() => _TestingPageState();
}

class _TestingPageState extends State<TestingPage> {
  QuestionLogic questionLogic = QuestionLogic();
  List<Icon> score = [];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Expanded(
          flex: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Text(
                questionLogic.getQuestion(),
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 60),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                checkAnswer(true);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.green,
                ),
                child: Center(child: Text('Истина')),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: GestureDetector(
              onTap: () {
                checkAnswer(false);
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.red,
                ),
                child: Center(child: Text('Ложь')),
              ),
            ),
          ),
        ),
        Row(
          children: score,
        )
      ],
    );
  }

  checkAnswer(bool userAnswer) {
    bool correctAnswer = questionLogic.getAnswer();

    setState(() {
      questionLogic.nextQuestion();

      if (userAnswer == correctAnswer) {
        score.add(
          Icon(
            Icons.check,
            color: Colors.green,
          ),
        );
      } else {
        score.add(
          Icon(
            Icons.close,
            color: Colors.red,
          ),
        );
      }
    });
  }
}
