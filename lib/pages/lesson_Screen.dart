import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:intl/intl.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:m_learning/models/model.dart';
import 'package:m_learning/constant/color.dart';
import '../Widgets/category_card.dart';
import '../constant/fullcustomapp.dart';
import '../models/category.dart';

class LessonScreen extends StatefulWidget {
  const LessonScreen({super.key});

  @override
  State<LessonScreen> createState() => _LessonScreenState();
}

class _LessonScreenState extends State<LessonScreen> {
  final currentUser = FirebaseAuth.instance.currentUser!;

  void _openChatDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) => const GeminiChatBotDialog(),
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
            const Expanded(
              child: Body(),
            ),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _openChatDialog,
          backgroundColor: Colors.white,
          child: Image.asset(
            'assets/icons/male.png',
            height: 24, // Adjust size as needed
          ),
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

class GeminiChatBotDialog extends StatefulWidget {
  const GeminiChatBotDialog({super.key});
  @override
  State<GeminiChatBotDialog> createState() => _GeminiChatBotDialogState();
}

class _GeminiChatBotDialogState extends State<GeminiChatBotDialog> {
  TextEditingController promprController = TextEditingController();
  static const apiKey = "AIzaSyDg1LHpbUz02J_hflkoG5Yh9sxWjU8F4Hs";
  final model = GenerativeModel(model: "gemini-pro", apiKey: apiKey);

  final List<ModelMessage> prompt = [];

  Future<void> sendMessage() async {
    final message = promprController.text;
    // for prompt
    setState(() {
      promprController.clear();
      prompt.add(
        ModelMessage(
          isPrompt: true,
          message: message,
          time: DateTime.now(),
        ),
      );
    });
    // for respond
    final content = [Content.text(message)];
    final response = await model.generateContent(content);
    setState(() {
      prompt.add(
        ModelMessage(
          isPrompt: false,
          message: response.text ?? "",
          time: DateTime.now(),
        ),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25),
      ),
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(25),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  Image.asset('assets/icons/avatar.gif', height: 65), // Add your gif asset here
                  const SizedBox(width: 5),
                  Text(
                    "Tenzou ChatBot",
                    style: GoogleFonts.lato(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 22,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: const Icon(Icons.close, color: Colors.black),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1, color: Colors.grey),
            Expanded(
              child: ListView.builder(
                itemCount: prompt.length,
                itemBuilder: (context, index) {
                  final message = prompt[index];
                  return UserPrompt(
                    isPrompt: message.isPrompt,
                    message: message.message,
                    date: DateFormat('hh:mm a').format(
                      message.time,
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25),
              child: Row(
                children: [
                  Expanded(
                    flex: 20,
                    child: TextField(
                      controller: promprController,
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 20,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        hintText: "Enter a prompt here",
                      ),
                    ),
                  ),
                  const Spacer(),
                  GestureDetector(
                    onTap: () {
                      sendMessage();
                    },
                    child: const CircleAvatar(
                      radius: 29,
                      backgroundColor: kPrimaryColor,
                      child: Icon(
                        Icons.send,
                        color: Colors.white,
                        size: 32,
                      ),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container UserPrompt({
    required final bool isPrompt,
    required String message,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(15),
      margin: const EdgeInsets.symmetric(vertical: 15).copyWith(
        left: isPrompt ? 80 : 15,
        right: isPrompt ? 15 : 80,
      ),
      decoration: BoxDecoration(
        color: isPrompt ? kPrimaryColor : kPrimaryLight,
        borderRadius: BorderRadius.circular(20), // Make the chat box rounded
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // for prompt and respond
          Text(
            message,
            style: GoogleFonts.lato( // Use GoogleFonts to make the font more beautiful
              textStyle: TextStyle(
                fontWeight: isPrompt ? FontWeight.bold : FontWeight.normal,
                fontSize: 18,
                color: isPrompt ? Colors.white : Colors.black,
              ),
            ),
          ),
          // for prompt and respond time
          Text(
            date,
            style: GoogleFonts.lato(
              textStyle: TextStyle(
                fontSize: 14,
                color: isPrompt ? Colors.white : Colors.black,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
