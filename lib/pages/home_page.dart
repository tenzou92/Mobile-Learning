import 'package:flutter/material.dart';
import 'package:get/get.dart'; 
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'leaderboard.dart';
import 'lesson_Screen.dart';
import 'profile.dart';
import 'quiz.dart'; // Ensure this import is correct

class Homepage extends StatelessWidget {
  const Homepage({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(NavigationController());
    
    return Scaffold(
      bottomNavigationBar: Obx(
        () => NavigationBar(
          height: 80,
          elevation: 0,
          selectedIndex: controller.selectedIndex.value,
          onDestinationSelected: (index) => controller.selectedIndex.value = index,
      
          destinations: const [
            NavigationDestination(icon: Icon(Iconsax.home), label: 'Home'),
            NavigationDestination(icon: Icon(Iconsax.book), label: 'Quiz'),
            NavigationDestination(icon: Icon(Iconsax.award), label: 'LeaderBoard'),
            NavigationDestination(icon: Icon(Iconsax.user), label: 'Profile'),
          ],
        ),
      ),
      body: Obx(() => controller.screens[controller.selectedIndex.value]),
    );
  }
}

class NavigationController extends GetxController {
  final Rx<int> selectedIndex = 0.obs;

  final screens = [
    const LessonScreen(),
    const QuizScreen(),
    const LeaderboardScreen(),
    const Profile(),
  ];
}
