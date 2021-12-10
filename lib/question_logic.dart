import 'package:quizz_project/question.dart';

class QuestionLogic {
  int _questionNumber = 0;

  final List<Question> _questions = [
    Question('У кота 4 лапы', true),
    Question('У кота 5 лап', false),
  ];

  getQuestion() {
    return _questions[_questionNumber].questionText;
  }

  getAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  nextQuestion() {
    if (_questionNumber < _questions.length) {
      _questionNumber++;
    }
    ;
  }
}
