class Category {
  String thumbnail;
  String name;
  int noOfCourses;

  Category({
    required this.name,
    required this.noOfCourses,
    required this.thumbnail,
  });
}

List<Category> categoryList = [
  Category(
    name: 'Functions',
    noOfCourses: 7,
    thumbnail: 'assets/icons/function.png',
  ),
  Category(
    name: 'Array',
    noOfCourses: 6,
    thumbnail: 'assets/icons/parenthesis.png',
  ),
  Category(
    name: 'Pointers',
    noOfCourses: 4,
    thumbnail: 'assets/icons/cursor.png',
  ),
  Category(
    name: 'Looping',
    noOfCourses: 3,
    thumbnail: 'assets/icons/refresh.png',
  ),
];
