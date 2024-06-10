import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  File? _imageFile;
  String? _profilePicUrl;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      var userDoc = await FirebaseFirestore.instance.collection('users').doc(user.uid).get();
      if (userDoc.exists) {
        var userData = userDoc.data();
        _usernameController.text = userData?['name'] ?? '';
        _bioController.text = userData?['bio'] ?? '';
        _profilePicUrl = userData?['profilePicUrl'] ?? '';
        setState(() {});
      } else {
        // Initialize the document if it doesn't exist
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': '',
          'bio': '',
          'profilePicUrl': '',
        });
        _usernameController.text = '';
        _bioController.text = '';
        _profilePicUrl = '';
      }
    }
  }

  Future<void> _saveUserData() async {
    setState(() {
      _isLoading = true;
    });
    try {
      var user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        if (_imageFile != null) {
          String downloadUrl = await _uploadImageToFirebase(_imageFile!);
          _profilePicUrl = downloadUrl;
        }
        await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
          'name': _usernameController.text,
          'bio': _bioController.text,
          'profilePicUrl': _profilePicUrl,
        }, SetOptions(merge: true));
        
        // Update Firebase user display name
        await user.updateDisplayName(_usernameController.text);

        // Update the leaderboard collection
        await FirebaseFirestore.instance.collection('leaderboard').doc(user.uid).update({
          'name': _usernameController.text,
          'profilePicUrl': _profilePicUrl,
        });
        
        // Navigate back to profile page after saving
        Navigator.pop(context);
      }
    } catch (e) {
      // Handle errors
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save profile: $e')),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  Future<String> _uploadImageToFirebase(File image) async {
    var user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      String fileName = '${user.uid}.jpg';
      Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');
      UploadTask uploadTask = storageRef.putFile(image);

      await uploadTask.whenComplete(() => null);
      String downloadUrl = await storageRef.getDownloadURL();
      return downloadUrl;
    }
    throw Exception("User not authenticated");
  }

  Future<void> _pickImage() async {
    final pickedFile = await ImagePicker().pickImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _imageFile = File(pickedFile.path);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Profile'),
        backgroundColor: const Color(0xff886ff2),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            children: [
              GestureDetector(
                onTap: _pickImage,
                child: CircleAvatar(
                  radius: 40,
                  backgroundImage: _imageFile != null
                      ? FileImage(_imageFile!)
                      : (_profilePicUrl != null && _profilePicUrl!.isNotEmpty)
                          ? NetworkImage(_profilePicUrl!)
                          : const AssetImage('assets/images/bg.jpeg') as ImageProvider,
                  child: const Icon(Icons.camera_alt, color: Colors.white),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _usernameController,
                decoration: const InputDecoration(labelText: 'Username'),
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _bioController,
                decoration: const InputDecoration(labelText: 'Bio'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              _isLoading
                  ? const CircularProgressIndicator()
                  : ElevatedButton(
                      onPressed: _saveUserData,
                      child: const Text('Save'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff886ff2), // Updated from `primary`
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
