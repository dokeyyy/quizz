import 'package:quizz_project/question.dart';

class QuestionLogic {
  int _questionNumber = 0;

  List<bool> _dudeAnswers = [];

  List<Question> _questions = [
    Question('У кота 4 лапы', true),
    Question('У кота 5 лап', false),
    Question('У кота 3 лапы', false),
    Question('Андрей душнила', true),
    Question('Предыдущий вопрос верный', true),
    Question('Никита гусь', true),
  ];

  addAnswer(bool answer) {
    _dudeAnswers.add(answer);
  }

  getAnswerList() {
    return _dudeAnswers;
  }

  getQuestion() {
    return _questions[_questionNumber].questionText;
  }

  getAnswer() {
    return _questions[_questionNumber].questionAnswer;
  }

  nextQuestion() {
    if (_questionNumber < _questions.length - 1) {
      _questionNumber++;
    }
  }

  bool isFinished() {
    if (_questionNumber >= _questions.length - 1) {
      return true;
    } else {
      return false;
    }
  }

  reset() {
    _questionNumber = 0;
    _dudeAnswers.clear();
  }

  int getAllCount() {
    return _questions.length;
  }
}
