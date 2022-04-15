import 'package:flutter/material.dart';
import 'package:quizz_project/question_logic.dart';
import 'package:quizz_project/resultPage.dart';

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
        backgroundColor: Colors.amberAccent,
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
  int correctAnswersCount = 0;

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
                  borderRadius: BorderRadius.circular(150),
                  color: Color(0xFF00D734),
                ),
                child: Center(child: Text('!Yeap!')),
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
                  borderRadius: BorderRadius.circular(150),
                  color: Color(0xFCFF0000),
                ),
                child: Center(child: Text('!Nope!')),
              ),
            ),
          ),
        ),
        Hero(
          tag: 'scoreTag',
          child: scoreRow(questionLogic.getAnswerList(), 45.0, false),
        )
      ],
    );
  }

  checkAnswer(bool userAnswer) {
    bool correctAnswer = questionLogic.getAnswer();

    setState(() {
      if (userAnswer == correctAnswer) {
        correctAnswersCount++;
        questionLogic.addAnswer(true);
      } else {
        questionLogic.addAnswer(false);
      }
      if (questionLogic.isFinished()) {
        String correctAnswerPercent =
            (correctAnswersCount * 100 / questionLogic.getAllCount())
                .toStringAsFixed(0);

        // questionLogic.reset();
        // score = [];
        // correctAnswersCount = 0;

        onGoBack(dynamic value) {
          setState(() {
            questionLogic.reset();
            score = [];
            correctAnswersCount = 0;
          });
        }

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => resultPage(
              correctAnswerPercent: correctAnswerPercent,
              score: score,
              questionLogic: questionLogic,
            ),
          ),
        ).then(onGoBack);

        // showDialog(
        //     context: context,
        //     builder: (BuildContext context) {
        //       return AlertDialog(
        //         title: Text('Конец теста'),
        //         content: Text('Тест завершён на $correctAnswerPercent%'),
        //       );
        //     });
      } else {
        questionLogic.nextQuestion();
      }
    });
  }
}

Widget scoreRow(List<bool> answerList, double size, bool centered) {
  List<Icon> score = [];
  for (bool answer in answerList) {
    if (answer) {
      score.add(
        Icon(
          Icons.check,
          color: Color(0xFF0DFF3A),
          size: size,
        ),
      );
    } else {
      score.add(
        Icon(
          Icons.close,
          color: Color(0xFFFF3838),
          size: size,
        ),
      );
    }
  }

  return Row(
    mainAxisAlignment:
        centered ? MainAxisAlignment.center : MainAxisAlignment.start,
    children: score,
  );
}
