class Course {
  String name;
  String thumbnail;

  Course({
    required this.name,
    required this.thumbnail,
  });
}

List<Course> functionCourses = [
  Course(
    name: "Print a Sentence using function",
    thumbnail: "assets/icons/number-one.png",
  ),
  Course(
    name: "Find the sum of Numbers Using a Function",
    thumbnail: "assets/icons/number-2.png",
  ),
  Course(
    name: "Check Prime Number Using Function",
    thumbnail: "assets/icons/number-3.png",
  ),
  Course(
    name: "Display Prime Number Between Two Intervals Using Functions",
    thumbnail: "assets/icons/number-four.png",
  ),
  Course(
    name: "Convert Binary Number to Decimal",
    thumbnail: "assets/icons/number-5.png",
  ),
  Course(
    name: "Find the square root of a number",
    thumbnail: "assets/icons/six.png",
  ),
  Course(
    name: "Check whether a character is an Alphabet or not",
    thumbnail: "assets/icons/seven.png",
  ),
];

List<Course> arrayCourses = [
  Course(
    name: "Calculate Average Using Arrays",
    thumbnail: "assets/icons/number-one.png",
  ),
  Course(
    name: "Find Largest Element in an Array",
    thumbnail: "assets/icons/number-2.png",
  ),
  Course(
    name: "Calculate Standard Deviation",
    thumbnail: "assets/icons/number-3.png",
  ),
  Course(
    name: "Calculate Standard Deviatio Using Function",
    thumbnail: "assets/icons/number-four.png",
  ),
  Course(
    name: "Add Two Matrices Using Multi-Dimensional Array",
    thumbnail: "assets/icons/number-5.png",
  ),
  Course(
    name: "Find Transpose of a Matrix",
    thumbnail: "assets/icons/six.png",
  ),
];

List<Course> pointerCourses = [
  Course(
    name: "Access Array Elements using Pointer",
    thumbnail: "assets/icons/number-one.png",
  ),
  Course(
    name: "Loop Through an Array Using Pointers",
    thumbnail: "assets/icons/number-2.png",
  ),
  Course(
    name: "Swap Numbers in Cyclic Order Using Call by Reference",
    thumbnail: "assets/icons/number-3.png",
  ),
  Course(
    name: "Find the Largest Number Using Dynamic Memory Allocation",
    thumbnail: "assets/icons/number-four.png",
  ),
  // Add more pointer courses here
];

List<Course> loopingCourses = [
  Course(
    name: "For Loop",
    thumbnail: "assets/icons/number-one.png",
  ),
  Course(
    name: "While Loop",
    thumbnail: "assets/icons/number-2.png",
  ),
  Course(
    name: "Do-While Loop",
    thumbnail: "assets/icons/number-3.png",
  ),
  // Add more looping courses here
];
