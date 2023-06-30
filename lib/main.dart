import 'package:flutter/material.dart';
import 'quis_brain.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

QuisBrain quisBrain = QuisBrain();

void main() => runApp(Quizzler());

class Quizzler extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey.shade900,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: QuizPage(),
          ),
        ),
      ),
    );
  }
}

class QuizPage extends StatefulWidget {
  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  List<Icon> Scorekeeper = [];

  void Checker(bool userPickAnswer) {
    bool CorrectAnswer = quisBrain.getQuestionAnswer();

    setState(() {
      if (quisBrain.isFinished()) {
        Alert(
                context: context,
                title: 'Quizzler',
                desc: 'You have Finish the Game!')
            .show();
        quisBrain.reset();
        Scorekeeper.clear();
      } else {
        if (userPickAnswer == CorrectAnswer) {
          Scorekeeper.add(Icon(
            Icons.check,
            color: Colors.green,
          ));
        } else {
          Scorekeeper.add(Icon(Icons.close, color: Colors.red));
        }
        quisBrain.getQuestionNumber();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: <Widget>[
        Expanded(
          flex: 5,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Center(
              child: Text(
                quisBrain.getQuestionText(),
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                textStyle:
                    TextStyle(color: Colors.white), // Set text color to white
              ),
              onPressed: () {
                Checker(true);
              },
              child: Text(
                'True',
                style: TextStyle(
                  fontSize: 20.0,
                ),
              ),
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: EdgeInsets.all(15.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Checker(false);
              },
              child: Text(
                'False',
                style: TextStyle(
                  fontSize: 20.0,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        Row(
          children: Scorekeeper,
        ),
      ],
    );
  }
}

/*
question1: 'You can lead a cow down stairs but not up stairs.', false,
question2: 'Approximately one quarter of human bones are in the feet.', true,
question3: 'A slug\'s blood is green.', true,
*/
