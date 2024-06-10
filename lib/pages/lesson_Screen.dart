import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_learning/constant/color.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import '../Widgets/category_card.dart';
import '../constant/fullcustomapp.dart';
import '../models/category.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final List<Map<String, String>> _messages = [];
  final currentUser = FirebaseAuth.instance.currentUser!;
  bool _isLoading = false;

  Future<String> getAIResponse(String message) async {
    const apiKey = 'YOUR_OPENAI_API_KEY';
    const apiUrl = 'https://api.openai.com/v1/engines/davinci-codex/completions';

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {
        'Authorization': 'Bearer $apiKey',
        'Content-Type': 'application/json',
      },
      body: jsonEncode({
        'prompt': message,
        'max_tokens': 150,
        'n': 1,
        'stop': ['\n'],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['text'].trim();
    } else {
      throw Exception('Failed to fetch response from AI');
    }
  }

  void _openChatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        TextEditingController _controller = TextEditingController();
        return StatefulBuilder(
          builder: (context, setState) {
            return Dialog(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'assets/icons/chatbot.gif',
                      height: 150, // Adjust height as needed
                    ),
                    Text(
                      'Chat with Tenzou',
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: _messages.length,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Text(
                              _messages[index]['sender']!,
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                            subtitle: Text(
                              _messages[index]['message']!,
                              style: GoogleFonts.poppins(
                                textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      height: 50, // Adjust the height as needed
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                labelText: 'Type your message...',
                                labelStyle: GoogleFonts.poppins(
                                  textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                              ),
                            ),
                          ),
                          _isLoading
                              ? CircularProgressIndicator()
                              : IconButton(
                                  icon: Icon(Icons.send, color: Colors.deepPurple),
                                  onPressed: () async {
                                    if (_controller.text.isNotEmpty) {
                                      setState(() {
                                        _isLoading = true;
                                        _messages.add({
                                          'sender': currentUser.displayName ?? 'User',
                                          'message': _controller.text,
                                        });
                                      });

                                      try {
                                        String aiResponse = await getAIResponse(_controller.text);
                                        setState(() {
                                          _messages.add({
                                            'sender': 'Tenzou',
                                            'message': aiResponse,
                                          });
                                        });
                                      } catch (e) {
                                        print("Failed to fetch AI response: $e");
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(content: Text('Failed to fetch AI response')),
                                        );
                                      } finally {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }

                                      _controller.clear();
                                      Navigator.of(context).pop();
                                      _openChatDialog();
                                    }
                                  },
                                ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.light,
      child: Scaffold(
        body: Column(
          children: [
            const CustomAppBarFull(),
            Expanded(
              child: Body(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openChatDialog,
          backgroundColor: Colors.white,
          child: const Icon(Icons.rocket, color: kPrimaryColor),
        ),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Explore Chapters',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                        fontSize: 20,
                      ),
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'See All',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: kPrimaryColor,
                          fontSize: 20,
                        ),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: GridView.builder(
            itemCount: categoryList.length,
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 8,
            ),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.8,
              crossAxisSpacing: 20,
              mainAxisSpacing: 24,
            ),
            itemBuilder: (context, index) {
              return CategoryCard(
                category: categoryList[index],
              );
            },
          ),
        ),
      ],
    );
  }
}
