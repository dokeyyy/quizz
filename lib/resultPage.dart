import 'dart:math';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:quizz_project/question_logic.dart';

import 'main.dart';

class resultPage extends StatefulWidget {
  const resultPage(
      {Key? key,
      required this.correctAnswerPercent,
      required this.score,
      required this.questionLogic})
      : super(key: key);

  final List<Icon> score;
  final String correctAnswerPercent;

  final QuestionLogic questionLogic;

  @override
  State<resultPage> createState() => _resultPageState();
}

class _resultPageState extends State<resultPage> with TickerProviderStateMixin {
  late AnimationController _containerController, _textController;
  late Animation _containerSizeAnimation,
      _textAnimation,
      _containerColorAnimation,
      _containerRadiusAnimation,
      _containerRotationAnimation,
      _containerBackgroundAnimation;

  @override
  void initState() {
    super.initState();
    _containerController = AnimationController(
        vsync: this, duration: Duration(milliseconds: 1500));
    _textController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _containerSizeAnimation = Tween(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(parent: _containerController, curve: Curves.bounceOut))
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _textController.forward();
        }
      });
    _containerColorAnimation =
        ColorTween(begin: Colors.amberAccent, end: Colors.orange)
            .animate(_containerController);
    _containerBackgroundAnimation =
        ColorTween(begin: Colors.white, end: Colors.black)
            .animate(_containerController);
    _textAnimation = Tween(begin: 0.0, end: 1.0).animate(_textController)
      ..addListener(() {
        setState(() {});
      });
    _containerRotationAnimation =
        Tween(begin: 0.0, end: 2.0).animate(_containerController);
    _containerRadiusAnimation = BorderRadiusTween(
            begin: BorderRadius.circular(200), end: BorderRadius.circular(100))
        .animate(_containerController);

    _containerController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: _containerBackgroundAnimation.value,
      body: Center(
          child: Transform.rotate(
        angle: pi * _containerRotationAnimation.value,
        child: Container(
          decoration: BoxDecoration(
              color: _containerColorAnimation.value,
              borderRadius: _containerRadiusAnimation.value),
          height: _containerSizeAnimation.value * 200.0,
          width: _containerSizeAnimation.value * width * 0.9,
          child: Opacity(
            opacity: _textAnimation.value,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                scoreRow(widget.questionLogic.getAnswerList(), 45.0, true),
                Text(
                  "Тест завершён на ${widget.correctAnswerPercent}%",
                  style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.bold),
                ),
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Ещё раз')),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
