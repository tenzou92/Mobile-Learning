import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:logger/logger.dart';

class ImageUploadService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final Logger _logger = Logger();

  Future<void> uploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      File imageFile = File(pickedFile.path);
      User? currentUser = _auth.currentUser;

      if (currentUser != null) {
        try {
          String fileName = '${currentUser.uid}.jpg';
          Reference storageRef = FirebaseStorage.instance.ref().child('profile_images/$fileName');
          UploadTask uploadTask = storageRef.putFile(imageFile);

          TaskSnapshot snapshot = await uploadTask;

          if (snapshot.state == TaskState.success) {
            String downloadUrl = await storageRef.getDownloadURL();
            _logger.i("Image uploaded successfully. URL: $downloadUrl");

            // Update Firestore with the image URL
            await _firestore.collection('users').doc(currentUser.uid).update({'profilePicUrl': downloadUrl});
            await _firestore.collection('leaderboard').doc(currentUser.uid).update({'profilePicUrl': downloadUrl});

            // Reload user data to reflect the new profile picture
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Profile picture updated successfully!')),
            );
          } else {
            _logger.e("Error uploading image: ${snapshot.state}");
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to upload image: ${snapshot.state}')),
            );
          }
        } catch (e) {
          _logger.e("Error uploading image: $e");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Failed to upload image: $e')),
          );
        }
      }
    }
  }
}
