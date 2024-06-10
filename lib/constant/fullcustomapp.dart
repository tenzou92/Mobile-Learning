import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:m_learning/constant/color.dart';
import '../Widgets/search_field.dart';

class CustomAppBarFull extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBarFull({super.key});

  void _showHelpDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          title: Column(
            children: [
              Image.asset(
                'assets/icons/how.gif',
                height: 150, // Adjust height as needed
              ),
              SizedBox(height: 10), // Add some spacing
              Text(
                'How to Use the App',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  '1. Navigate through different chapters by tapping on them.',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '2. Use the search bar to quickly find topics.',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '3. Tap on the chat icon to chat with AI called Tenzou to help with your learning',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '4. Access your profile from the bottom navigation bar.',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  '5. Participate in quizzes and track your progress.',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text(
                'Close',
                style: GoogleFonts.poppins(
                  textStyle: Theme.of(context).textTheme.labelLarge?.copyWith(
                    color: Colors.deepPurple,
                    fontSize: 18,
                  ),
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20), // Added padding to top
      height: 250, // Increased height to provide more space
      width: double.infinity,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
        gradient: LinearGradient(
          colors: [
            kPrimaryLight,
            kPrimaryColor,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 17), // Added padding to move down text and notification icon
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: 50),
                  child: Text(
                    'Hello, \nGood Evening',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontSize: 33,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.help_rounded),
                  iconSize: 35.0,
                  color: Colors.white,
                  onPressed: () => _showHelpDialog(context), // Show help dialog
                ),
              ],
            ),
            const SizedBox(height: 20), // Increased padding to move down the search bar
            const SearchTextField(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(250); // Updated preferred size to match new height
}
