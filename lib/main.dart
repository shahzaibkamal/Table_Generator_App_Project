import 'dart:async';
import 'package:flutter/material.dart';

void main() {
  runApp(CountingTableGenerator());
}

class CountingTableGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Generator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    // Navigate to HomePage after 3 seconds
    Timer(Duration(seconds: 7), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    String backgroundImagePath = 'assets/background.jpg';  // Add your background image asset here

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Display your logo or any other splash content here
              Image.asset('assets/table.png', height: 200, width: 200),  // Change to your splash image
              SizedBox(height: 20),
              Text(
                    '                            Table Generator App \n \n \n'
                    '  This App Is Developed By '
                    'Shahzaib Kamal Arshad\n'
                    'In the Supervision Of'
                    ' Sir Abdullah (COMSATS Vehari) ',
                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tableLimit = 100;
  int startValue = 1;
  int endValue = 100;

  get between => null;

  @override
  Widget build(BuildContext context) {
    String backgroundImagePath = 'assets/background.jpg';  // Add your background image asset here

    return Scaffold(
      appBar: AppBar(
        title: Text('Table Generator App'),
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(backgroundImagePath),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset('assets/table.png', height: 200, width: 200),
              SizedBox(height: 40),
              _buildSlider(
                value: tableLimit.toDouble(),
                min: 1,
                max: 100,
                label: 'Set Table Number',
                onChanged: (newValue) {
                  setState(() {
                    tableLimit = newValue.round();
                  });
                },
              ),
              _buildSlider(
                value: startValue.toDouble(),
                min: 1,
                max: endValue.toDouble(),
                label: 'Table Starting Point',
                onChanged: (newValue) {
                  setState(() {
                    startValue = newValue.round();
                  });
                },
              ),
              _buildSlider(
                value: endValue.toDouble(),
                min: startValue.toDouble(),
                max: 100,
                label: 'Table Ending Limit',
                onChanged: (newValue) {
                  setState(() {
                    endValue = newValue.round();
                  });
                },
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => CountingTablePage(
                        tableLimit: tableLimit,
                        startValue: startValue,
                        endValue: endValue,
                      ),
                    ),
                  );
                },
                child: Text('Generate Table'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required double min,
    required double max,
    required String label,
    required Function(double) onChanged,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment. spaceBetween,
      children: [
        Text(
          '$label: ${value.round()}',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class CountingTablePage extends StatelessWidget {
  final int tableLimit;
  final int startValue;
  final int endValue;

  CountingTablePage({
    required this.tableLimit,
    required this.startValue,
    required this.endValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Table of $tableLimit'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.white, Colors.green],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DataTable(
                  columns: _generateColumns(),
                  rows: _generateRows(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellowAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => QuizPage(
                          startValue: startValue,
                          endValue: endValue,
                          tableLimit: tableLimit,
                        ),
                      ),
                    );
                  },
                  child: Text('Generate Quiz'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.yellow,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _generateColumns() {
    return [
      DataColumn(label: Text('Numbers')),
      DataColumn(label: Text('Results')),
    ];
  }

  List<DataRow> _generateRows() {
    List<DataRow> rows = [];
    for (int i = startValue; i <= endValue; i++) {
      rows.add(DataRow(
        cells: [
          DataCell(Text('$tableLimit x $i')),
          DataCell(Text('${tableLimit * i}')),
        ],
      ));
    }
    return rows;
  }
}

class QuizPage extends StatefulWidget {
  final int startValue;
  final int endValue;
  final int tableLimit;

  QuizPage({
    required this.startValue,
    required this.endValue,
    required this.tableLimit,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  late List<List<int>> _questions;
  late List<List<int>> _options;
  late List<int> _correctAnswers;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    _questions = [];
    _options = [];
    _correctAnswers = [];

    // Iterate through each table value
    for (int i = widget.startValue; i <= widget.endValue; i++) {
      // Iterate through multipliers for each table
      for (int j = 1; j <= 1; j++) {
        int table = widget.tableLimit;
        int multiplier = i;

        // Add the question to the lists
        _questions.add([table, multiplier]);
        int correctAnswer = table * multiplier;
        _correctAnswers.add(correctAnswer);
        _options.add(_generateOptions(correctAnswer));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quiz Questions'),
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.lightBlue, Colors.white, Colors.green],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '  SELECT CORRECT OPTION\n \n \n Question Number : ${_currentQuestionIndex + 1}= ${_questions[_currentQuestionIndex][0]} x ${_questions[_currentQuestionIndex][1]}',
                style: TextStyle(fontSize: 20),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _showResult(context, _options[_currentQuestionIndex][index]);
                      },
                      child: Text(
                        '${String.fromCharCode(index + 97)}) ${_options[_currentQuestionIndex][index]}',
                        style: TextStyle(fontSize: 16),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text('Generate Table'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.pinkAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_currentQuestionIndex < _questions.length - 1) {
                          _currentQuestionIndex++;
                        } else {
                          _currentQuestionIndex = 0;
                          _generateQuestions();
                        }
                      });
                    },
                    child: Text('Next Question'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightGreen,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<int> _generateOptions(int correctAnswer) {
    List<int> options = [correctAnswer];
    int incorrect1 = correctAnswer + 10;
    int incorrect2 = correctAnswer + 20;
    options.add(incorrect1);
    options.add(incorrect2);
    options.shuffle();
    return options;
  }

  void _showResult(BuildContext context, int selectedAnswer) {
    int correctAnswer = _correctAnswers[_currentQuestionIndex];
    String resultMessage = selectedAnswer == correctAnswer
        ? 'Correct! ${_questions[_currentQuestionIndex][0]} x ${_questions[_currentQuestionIndex][1]} = $correctAnswer'
        : 'Incorrect! The correct answer is $correctAnswer';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result'),
          content: Text(resultMessage),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
