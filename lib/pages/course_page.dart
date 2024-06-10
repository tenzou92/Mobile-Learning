import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import '../widgets/courses_container.dart';
import '../models/course.dart';
import '../models/category.dart';

class CourseScreen extends StatefulWidget {
  final Category category;

  const CourseScreen({super.key, required this.category});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late List<Course> filteredCourses;

  @override
  void initState() {
    super.initState();
    filteredCourses = _getCoursesForCategory(widget.category);
  }

  List<Course> _getCoursesForCategory(Category category) {
    switch (category.name) {
      case 'Array':
        return arrayCourses;
      case 'Pointers':
        return pointerCourses;
      case 'Looping':
        return loopingCourses;
      default:
        return functionCourses;
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle.dark,
      child: Scaffold(
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20).copyWith(top: 40),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                IntrinsicHeight(
                  child: Stack(
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          widget.category.name,
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context).textTheme.displayMedium?.copyWith(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                          ),
                        ),
                      ),
                      Positioned(
                        left: 0,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back_ios),
                          iconSize: 35,
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 20), // Add top padding here
                    child: ListView.separated(
                      shrinkWrap: true,
                      itemBuilder: (_, index) {
                        return CourseContainer(
                          course: filteredCourses[index],
                        );
                      },
                      separatorBuilder: (context, _) {
                        return const SizedBox(
                          height: 10,
                        );
                      },
                      itemCount: filteredCourses.length,
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
}
