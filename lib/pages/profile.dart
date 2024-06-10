import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:iconsax_flutter/iconsax_flutter.dart';
import 'package:logger/logger.dart';
import 'package:google_fonts/google_fonts.dart';
import 'subs.dart'; // Import the Subs screen

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final currentUser = FirebaseAuth.instance.currentUser!;
  final usersCollection = FirebaseFirestore.instance.collection("users");
  final leaderboardCollection = FirebaseFirestore.instance.collection("leaderboard");
  final logger = Logger();

  DocumentSnapshot<Map<String, dynamic>>? userData;
  bool isLoading = true;

  Future<void> editField(String field) async {
    String newValue = "";
    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                autofocus: true,
                decoration: InputDecoration(
                  hintText: "Enter new $field",
                ),
                onChanged: (value) {
                  newValue = value;
                },
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Cancel",
              style: TextStyle(color: Colors.blue),
            ),
          ),
          TextButton(
            onPressed: () => Navigator.of(context).pop(newValue),
            child: Text(
              "Save",
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
    );

    // Update in Firestore
    if (newValue.trim().isNotEmpty) {
      // Update the Firestore documents
      await usersCollection.doc(currentUser.uid).update({field: newValue});
      await leaderboardCollection.doc(currentUser.uid).update({field: newValue});

      // Update the display name of the Firebase Auth user
      if (field == 'name') {
        await currentUser.updateProfile(displayName: newValue);
        // Reload user data to reflect changes
        await currentUser.reload();
      }

      _loadUserData();
    }
  }

  Future<void> uploadImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);

      try {
        String fileName = '${currentUser.uid}.jpg';
        Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');
        UploadTask uploadTask = storageRef.putFile(imageFile);

        TaskSnapshot snapshot = await uploadTask;

        if (snapshot.state == TaskState.success) {
          String downloadUrl = await storageRef.getDownloadURL();
          logger.i("Image uploaded successfully. URL: $downloadUrl");

          // Update Firestore with the image URL
          await usersCollection.doc(currentUser.uid).update({'profilePicUrl': downloadUrl});
          await leaderboardCollection.doc(currentUser.uid).update({'profilePicUrl': downloadUrl});

          // Reload user data to reflect the new profile picture
          _loadUserData();
        } else {
          logger.e("Error uploading image: ${snapshot.state}");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: ${snapshot.state}')),
          );
        }
      } catch (e) {
        logger.e("Error uploading image: $e");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to upload image: $e')),
        );
      }
    }
  }

  Future<void> _loadUserData() async {
    try {
      var userDoc = await usersCollection.doc(currentUser.uid).get();
      if (userDoc.exists) {
        setState(() {
          userData = userDoc;
          isLoading = false;
        });
      } else {
        setState(() {
          isLoading = false;
        });
        logger.e("User document does not exist.");
      }
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      logger.e("Error loading user data: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: GoogleFonts.poppins(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.deepPurple,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 40,
                        backgroundImage: userData?.data()?['profilePicUrl'] != null && userData!.data()!['profilePicUrl'].isNotEmpty
                            ? NetworkImage(userData!.data()!['profilePicUrl'])
                            : const AssetImage('assets/images/bg.jpeg') as ImageProvider,
                        onBackgroundImageError: (exception, stackTrace) {
                          logger.e("Error loading profile image: $exception");
                        },
                      ),
                      const SizedBox(width: 20),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    currentUser.displayName ?? 'No Username',
                                    style: GoogleFonts.poppins(fontSize: 22, fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                SizedBox(width: 5), // Adjust width to make space between text and icon
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.deepPurple),
                                  onPressed: () => editField('name'),
                                ),
                              ],
                            ),
                            Text(
                              currentUser.email ?? '',
                              style: GoogleFonts.poppins(fontSize: 16, color: Colors.grey),
                            ),
                          ],
                        ),
                      ),
                      IconButton(
                        icon: const Icon(Icons.camera_alt, color: Colors.deepPurple),
                        onPressed: uploadImage,
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  if (userData != null)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Bio:',
                          style: GoogleFonts.poppins(fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData?.data()?['bio'] ?? 'No bio available',
                          style: GoogleFonts.poppins(fontSize: 16),
                        ),
                        const SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: () => editField('bio'),
                          child: Text('Edit Bio', style: GoogleFonts.poppins(color: Colors.white,fontSize: 17)),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.deepPurple,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                          ),
                        ),
                      ],
                    ),
                  const SizedBox(height: 20),
                  const Divider(),
                  const SizedBox(height: 20),
                  ListTile(
                    leading: const Icon(Iconsax.home, color: Colors.deepPurple),
                    title: Text('Home', style: GoogleFonts.poppins(fontSize: 16)),
                    onTap: () {
                      Navigator.pushNamed(context, '/home');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.book, color: Colors.deepPurple),
                    title: Text('Quiz', style: GoogleFonts.poppins(fontSize: 16)),
                    onTap: () {
                      Navigator.pushNamed(context, '/quiz');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.award, color: Colors.deepPurple),
                    title: Text('LeaderBoard', style: GoogleFonts.poppins(fontSize: 16)),
                    onTap: () {
                      Navigator.pushNamed(context, '/leaderboard');
                    },
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.wallet, color: Colors.deepPurple),
                    title: Text('Subscription', style: GoogleFonts.poppins(fontSize: 16)),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const Subs()),
                      );
                    },
                  ),
                  ListTile(
                    leading: const Icon(Iconsax.logout, color: Colors.deepPurple),
                    title: Text('Logout', style: GoogleFonts.poppins(fontSize: 16)),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.of(context).pushReplacementNamed('/login');
                    },
                  ),
                ],
              ),
      ),
    );
  }
}
