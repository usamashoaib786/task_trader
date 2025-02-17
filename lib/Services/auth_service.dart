import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      FirebaseFirestore firestore = FirebaseFirestore.instance;

      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);

      await userCredential.user?.updateDisplayName(name);
      showToast("Signup successful!");

      // Get the user's UID
      String uid = userCredential.user!.uid;
      DocumentReference docRef =
          FirebaseFirestore.instance.collection("users").doc(uid);
      // Use the same document ID for storing profile and rules
      await docRef.set({
        'profile': {
          'name': name,
          'email': email,
          'created_at': FieldValue.serverTimestamp(),
        },
        'Rules': [] // Initialize rules as an empty array
      });

      Future.delayed(const Duration(seconds: 1), () {
        pushReplacement(context, BottomNavView());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast("An account already exists with this email, Try Login!");
      } else {
        _handleAuthError(e, context);
      }
    }
  }

  Future<void> signin({
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavView()),
          (route) => false,
        );
      });
    } on FirebaseAuthException catch (e) {
      _handleAuthError(e, context);
    }
  }

  Future<bool> signOutUser() async {
    try {
      await FirebaseAuth.instance.signOut();
      return true;
    } catch (_) {
      return false;
    }
  }

  Future<void> updateUserInfo({
    String? name,
    String? number,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String uid = FirebaseAuth.instance.currentUser!.uid;

      if (user != null) {
        await user.updateDisplayName(name);

        DocumentReference docRef =
            FirebaseFirestore.instance.collection("users").doc(uid);

        // Use merge option to update without deleting existing fields
        await docRef.set({
          "profile": {
            if (name != null) "name": name,
            if (number != null) "number": number,
          }
        }, SetOptions(merge: true));

        showToast("User info updated successfully!");
      } else {
        throw Exception("No user is signed in.");
      }
    } catch (e) {
      throw Exception("Failed to update user info: $e");
    }
  }

  void _handleAuthError(FirebaseAuthException e, BuildContext context) {
    String message;
    switch (e.code) {
      case 'weak-password':
        message = 'The password provided is too weak.';
        break;
      case 'email-already-in-use':
        message = 'An account already exists with that email.';
        break;
      case 'invalid-email':
        message = 'Invalid email.';
        break;
      case 'user-not-found':
        message = 'No user found for that email.';
        break;
      case 'wrong-password':
        message = 'Wrong password provided.';
        break;
      case 'invalid-credential':
        message = 'Invalid Credentials';
        break;
      default:
        message = e.code.toString();
    }
    showToast(message);
  }

  void showToast(String message) {
    print("Error Message details" + message);
    Fluttertoast.showToast(
      msg: message,
    );
  }

  // Future<void> saveUserProfile(String name, int number) async {
  //   String uid = FirebaseAuth.instance.currentUser!.uid;

  //   await FirebaseFirestore.instance.collection("users").doc(uid).set({
  //     "profile": {
  //       "name": name,
  //       "number": number,
  //     },
  //   });
  // }

  Future<void> addNewRules(String rule) async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentReference docRef =
        FirebaseFirestore.instance.collection("users").doc(uid);

    await docRef.set({
      "Rules": FieldValue.arrayUnion([rule])
    }, SetOptions(merge: true));
  }

  Future<List<String>> fetchRules() async {
    String uid = FirebaseAuth.instance.currentUser!.uid;
    DocumentSnapshot docSnapshot =
        await FirebaseFirestore.instance.collection("users").doc(uid).get();

    if (docSnapshot.exists) {
      // Get the "Rules" field as a List
      List<dynamic>? rulesList = docSnapshot.get("Rules");

      if (rulesList != null) {
        return List<String>.from(rulesList);
      }
    }
    return []; // Return empty list if no rules found
  }
}
