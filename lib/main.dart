import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'constant/color.dart';
import 'pages/RegisterPage.dart';
import 'pages/auth_page.dart';
import 'pages/firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/leaderboard.dart';
import 'pages/login_page.dart';
import 'pages/profile.dart';
import 'pages/quiz.dart';
import 'services/edit_profile.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(); // Load environment variables
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'M-Learning C++',
          theme: ThemeData(
            primarySwatch: primaryColor,
            appBarTheme: const AppBarTheme(
              color: kPrimaryColor,
              elevation: 0,
            ),
            fontFamily: 'Poppins',
            textTheme: TextTheme(
              titleLarge: TextStyle(
                fontSize: 20.sp,
                color: Colors.white,
                fontWeight: FontWeight.w500,
              ),
              bodyLarge: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.w500,
              ),
              bodyMedium: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
              displayMedium: TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 18.sp,
                color: Colors.black,
              ),
            ),
          ),
          home: const AuthPage(),
          routes: {
            '/home': (context) => const Homepage(),
            '/login': (context) => const LoginPage(),
            '/register': (context) => const RegisterPage(),
            '/quiz': (context) => const QuizScreen(),
            '/leaderboard': (context) => const LeaderboardScreen(),
            '/profile': (context) => const Profile(),
            '/edit_profile': (context) => const EditProfileScreen(), 
          },
        );
      },
    );
  }
}
