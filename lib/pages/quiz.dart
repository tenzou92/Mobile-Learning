import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/widgets.dart';
import 'package:m_learning/models/question.dart';
import '../constant/customappbar.dart';
import 'dart:async';
import 'package:google_fonts/google_fonts.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int _currentQuestionIndex = 0;
  int _score = 0;
  String? _selectedChapter;
  List<Map<String, Object>> _currentQuestions = [];
  Timer? _timer;
  int _timeRemaining = 120;

  void _answerQuestion(int score) {
    setState(() {
      _score += score;
      _currentQuestionIndex++;
      if (_currentQuestionIndex >= _currentQuestions.length) {
        _timer?.cancel();
        _showEndDialog();
      }
    });
  }

  Future<void> _submitScore() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('leaderboard').doc(user.uid).get();
      if (userDoc.exists) {
        await FirebaseFirestore.instance.collection('leaderboard').doc(user.uid).update({
          'score': FieldValue.increment(_score),
        });
      } else {
        await FirebaseFirestore.instance.collection('leaderboard').doc(user.uid).set({
          'name': user.displayName ?? 'Anonymous',
          'initials': (user.displayName?.isNotEmpty ?? false) ? user.displayName![0] : 'A',
          'score': _score,
        });
      }
    }
  }

  void _selectChapter(String chapter) {
    setState(() {
      _selectedChapter = chapter;
      _currentQuestionIndex = 0;
      _score = 0;
      _timeRemaining = 120;
      _currentQuestions = questions
          .firstWhere((element) => element['chapter'] == chapter)['questions'] as List<Map<String, Object>>;
      _startTimer();
    });
  }

  void _startTimer() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_timeRemaining > 0) {
          _timeRemaining--;
        } else {
          _timer?.cancel();
          _showTimeUpDialog();
        }
      });
    });
  }

  void _showTimeUpDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.alarm,
                size: 60,
                color: Colors.deepPurple,
              ),
              const SizedBox(height: 20),
              Text(
                'Time is up!',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                'The time for this quiz has ended.',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _submitScore();
                  setState(() {
                    _selectedChapter = null;
                  });
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showEndDialog() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (ctx) => Dialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Container(
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                blurRadius: 10,
                offset: const Offset(0, 5),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (_score >= 9)
                Column(
                  children: [
                    Image.asset(
                      'assets/icons/rocket.gif', // Rocket animation
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Congratulations, you passed!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                )
              else
                Column(
                  children: [
                    Image.asset(
                      'assets/icons/thumbs.gif', 
                      width: 150,
                      height: 150,
                    ),
                    const SizedBox(height: 20),
                    Text(
                      'Don\'t give up, try again!',
                      style: GoogleFonts.poppins(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 10),
              Text(
                'Your score: $_score',
                style: GoogleFonts.poppins(
                  fontSize: 18,
                  color: Colors.black54,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                  backgroundColor: Colors.deepPurple,
                ),
                onPressed: () {
                  Navigator.of(ctx).pop();
                  _submitScore();
                  setState(() {
                    _selectedChapter = null;
                  });
                },
                child: Text(
                  'OK',
                  style: GoogleFonts.poppins(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          CustomAppBar(
            title: _selectedChapter == null ? 'Chapters' : ' $_selectedChapter',
            onBackPressed: _selectedChapter != null
                ? () {
                    setState(() {
                      _selectedChapter = null;
                      _currentQuestionIndex = 0;
                      _score = 0;
                      _timer?.cancel();
                    });
                  }
                : null,
          ),
          Expanded(
            child: _selectedChapter == null
                ? ListView.builder(
                    itemCount: questions.length,
                    itemBuilder: (context, index) {
                      return ChapterItem(
                        index: index + 1,
                        chapter: questions[index]['chapter'] as String,
                        questionCount: (questions[index]['questions'] as List).length,
                        onTap: () => _selectChapter(questions[index]['chapter'] as String),
                      );
                    },
                  )
                : _currentQuestionIndex < _currentQuestions.length
                    ? Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          LinearProgressIndicator(
                            value: (_currentQuestionIndex + 1) / _currentQuestions.length,
                          ),
                          const SizedBox(height: 30),
                          Expanded(
                            child: SingleChildScrollView(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.stretch,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(15.0),
                                    child: Text(
                                      'Time remaining: ${_timeRemaining ~/ 60}:${(_timeRemaining % 60).toString().padLeft(2, '0')}',
                                      style: GoogleFonts.poppins(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                  if (_currentQuestions[_currentQuestionIndex].containsKey('image'))
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                      child: Image.asset(
                                        _currentQuestions[_currentQuestionIndex]['image'] as String,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  const SizedBox(height: 15),
                                  Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                                    child: Text(
                                      _currentQuestions[_currentQuestionIndex]['questionText'] as String,
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.poppins(
                                        fontSize: 24,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  ...(_currentQuestions[_currentQuestionIndex]['answers'] as List<Map<String, Object>>)
                                      .map((answer) {
                                    return Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 4.0),
                                      child: ElevatedButton(
                                        onPressed: () => _answerQuestion(answer['score'] as int),
                                        child: Text(
                                          answer['text'] as String,
                                          style: GoogleFonts.poppins(
                                            fontSize: 17,
                                          ),
                                        ),
                                      ),
                                    );
                                  }).toList(),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )
                    : Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Lesson completed!',
                              style: GoogleFonts.poppins(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              'Your reward: $_score XP',
                              style: GoogleFonts.poppins(
                                fontSize: 18,
                              ),
                            ),
                            const SizedBox(height: 20),
                            ElevatedButton(
                              onPressed: () async {
                                await _submitScore();
                                setState(() {
                                  _selectedChapter = null;
                                });
                              },
                              child: Text(
                                'Submit Score & Return to Chapters',
                                style: GoogleFonts.poppins(),
                              ),
                            ),
                          ],
                        ),
                      ),
          ),
        ],
      ),
    );
  }
}

class ChapterItem extends StatelessWidget {
  final int index;
  final String chapter;
  final int questionCount;
  final VoidCallback onTap;

  const ChapterItem({
    required this.index,
    required this.chapter,
    required this.questionCount,
    required this.onTap,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color bgColor;
    switch (index % 3) {
      case 0:
        bgColor = Colors.orangeAccent;
        break;
      case 1:
        bgColor = Colors.purpleAccent;
        break;
      case 2:
        bgColor = Colors.lightBlueAccent;
        break;
      default:
        bgColor = Colors.grey;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(15),
          ),
          padding: const EdgeInsets.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleAvatar(
                radius: 20,
                backgroundColor: Colors.white,
                child: Text(
                  index.toString(),
                  style: GoogleFonts.poppins(
                    color: bgColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chapter,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    '$questionCount questions',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
              Column(
                children: [
                  const Icon(
                    Icons.timer,
                    color: Colors.white,
                  ),
                  Text(
                    '2M',
                    style: GoogleFonts.poppins(
                      color: Colors.white,
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
}
