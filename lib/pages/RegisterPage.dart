import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'home_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  late Color myColor;
  late Size mediaSize;
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  Future<void> registerUser() async {
    if (passwordController.text != confirmPasswordController.text) {
      showErrorDialog("Passwords do not match!");
      return;
    }

    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      debugPrint("User registered successfully!");

      Navigator.pop(context); // Pop the loading circle

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const Homepage()), // Adjust as needed
      );
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // Pop the loading circle

      if (e.code == 'weak-password') {
        showErrorDialog("The password provided is too weak.");
      } else if (e.code == 'email-already-in-use') {
        showErrorDialog("An account already exists for that email.");
      } else {
        showErrorDialog(e.message ?? "An error occurred");
      }
    }
  }

  void showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Text('OK'),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    myColor = Theme.of(context).primaryColor;
    mediaSize = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
        color: myColor,
        image: DecorationImage(
          image: const AssetImage("assets/images/bg.jpeg"),
          fit: BoxFit.cover,
          colorFilter: ColorFilter.mode(
            myColor.withOpacity(0.2),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Stack(
          children: [
            Positioned(top: 70, child: _buildTop()),
            Positioned(bottom: 0, child: _buildBottom())
          ],
        ),
      ),
    );
  }

  Widget _buildTop() {
    return SizedBox(
      width: mediaSize.width,
      child: const Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.mobile_friendly,
            size: 100,
            color: Colors.white,
          ),
          Text(
            "M-LEARNING C++",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 40,
              letterSpacing: 2,
            ),
          )
        ],
      ),
    );
  }

  Widget _buildBottom() {
    return SizedBox(
      width: mediaSize.width,
      child: Card(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(32.0),
          child: _buildForm(),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Register",
          style: TextStyle(
            color: myColor,
            fontSize: 32,
            fontWeight: FontWeight.w500,
          ),
        ),
        _buildGreyText("Create your new account"),
        const SizedBox(height: 40),
        _buildGreyText("Email Address"),
        _buildInputField(emailController),
        const SizedBox(height: 10),
        _buildGreyText("Password"),
        _buildInputField(passwordController, isPassword: true),
        const SizedBox(height: 10),
        _buildGreyText("Confirm Password"),
        _buildInputField(confirmPasswordController, isPassword: true),
        const SizedBox(height: 10),
        _buildRegisterButton(),
        const SizedBox(height: 10),
        _buildOtherLogin(context),
      ],
    );
  }

  Widget _buildGreyText(String text) {
    return Text(
      text,
      style: const TextStyle(color: Colors.grey),
    );
  }

  Widget _buildInputField(TextEditingController controller, {bool isPassword = false}) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        suffixIcon: isPassword ? const Icon(Icons.remove_red_eye) : const Icon(Icons.done),
      ),
      obscureText: isPassword,
    );
  }

  Widget _buildRegisterButton() {
    return ElevatedButton(
      onPressed: registerUser,
      style: ElevatedButton.styleFrom(
        shape: const StadiumBorder(),
        elevation: 20,
        minimumSize: const Size.fromHeight(60),
      ),
      child: const Text("REGISTER"),
    );
  }

  Widget _buildOtherLogin(BuildContext context) {
    return Center(
      child: Column(
        children: [
          _buildGreyText("Or Register With"),
          const SizedBox(height: 10),
          GestureDetector(
            onTap: () {
              // Handle Google registration here
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Google Registration'),
                    content: const Text('Initiating Google registration...'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Close'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Image.asset(
              "assets/images/google.png",
              width: 50, // Adjust width as needed
              height: 50, // Adjust height as needed
            ),
          ),
        ],
      ),
    );
  }
}
