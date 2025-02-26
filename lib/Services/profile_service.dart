// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class ProfileService {
//   final String uid = FirebaseAuth.instance.currentUser!.uid;
//   final FirebaseFirestore _firestore = FirebaseFirestore.instance;

//   Future<Map<String, dynamic>?> fetchUserProfile() async {
//     DocumentSnapshot docSnapshot =
//         await _firestore.collection("users").doc(uid).get();

//     if (docSnapshot.exists) {
//       Map<String, dynamic>? profileData = docSnapshot.get("profile");
//       return profileData;
//     }
//     return null;
//   }

import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class ProfileService {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch user profile from Firestore
  Future<Map<String, dynamic>?> fetchUserProfile() async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection("users").doc(uid).get();

    print("snapsot$docSnapshot");

    if (docSnapshot.exists) {
      return docSnapshot.get("profile") as Map<String, dynamic>?;
    }
    return null;
  }

  /// Uploads an image to Firebase Storage and returns the download URL
  Future<String?> uploadProfileImage(File imageFile) async {
    try {
      String uid = FirebaseAuth.instance.currentUser!.uid;
      Reference storageRef =
          FirebaseStorage.instance.ref().child("profile_images/$uid.jpg");

      UploadTask uploadTask = storageRef.putFile(imageFile);
      TaskSnapshot snapshot = await uploadTask;

      String downloadUrl = await snapshot.ref.getDownloadURL();
      return downloadUrl;
    } catch (e) {
      debugPrint("Error uploading image: $e");
      return null;
    }
  }

  /// Show toast message
  void showToast(String message) {
    print(message); // Replace with a proper Toast in a real app
  }
}

// //Shared Preferences
// Future<void> saveUserSharedProfile({
//   required String name,
//   required String email,
//   required String phoneNumber,
// }) async {
//   final prefs = await SharedPreferences.getInstance();
//   await prefs.setString('name', name);
//   await prefs.setString('email', email);
//   await prefs.setString('phoneNumber', phoneNumber);
// }

// Future<Map<String, String?>> fetchSharedUserProfile() async {
//   final prefs = await SharedPreferences.getInstance();
//   final name = prefs.getString('name');
//   final email = prefs.getString('email');
//   final phoneNumber = prefs.getString('phoneNumber');
//   return {
//     'name': name,
//     'email': email,
//     'phoneNumber': phoneNumber,
//   };
// }
