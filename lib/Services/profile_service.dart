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
}