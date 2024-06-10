import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/course.dart';
import '../pages/detail_page.dart';

class CourseContainer extends StatelessWidget {
  final Course course;
  const CourseContainer({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailsScreen(
            title: course.name,
          ),
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 6.0,
              spreadRadius: 1.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                course.thumbnail,
                height: 60,
                width: 60,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  course.name,
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontSize: 16, // Ensure font size is appropriate
                          color: Colors.black, // Ensure text color contrasts with background
                          fontWeight: FontWeight.w600,
                        ),
                  ),
                  overflow: TextOverflow.ellipsis, // Ensure text doesn't overflow
                  maxLines: 2, // Limit to 2 lines
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
