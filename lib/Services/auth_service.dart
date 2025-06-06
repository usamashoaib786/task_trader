import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:task_trader/Resources/pref_keys.dart';
import 'package:task_trader/Resources/utils.dart';
import 'package:task_trader/Services/profile_service.dart';
import 'package:task_trader/Views/bottom_navigation_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AuthService {
  final ValueNotifier<bool> isLoading = ValueNotifier(false);

  Future<void> signup({
    required String name,
    required String email,
    required String password,
    required BuildContext context,
  }) async {
    isLoading.value = true;
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      // FirebaseFirestore firestore = FirebaseFirestore.instance;

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
          'level': "Bronze",
          'points': "0",
          'created_at': FieldValue.serverTimestamp(),
        },
        'Rules': [] // Initialize rules as an empty array
      });

      isLoading.value = false;
      SharedPreferences prefs = await SharedPreferences.getInstance();

      prefs.setString(PrefKey.userName, name);
      prefs.setString(PrefKey.email, email);
      prefs.setString(PrefKey.userLevel, "Bronze");
      prefs.setString(PrefKey.userPoints, "0");

      Future.delayed(const Duration(seconds: 1), () {
        // ignore: use_build_context_synchronously
        pushUntil(context, BottomNavView());
      });
    } on FirebaseAuthException catch (e) {
      if (e.code == 'email-already-in-use') {
        showToast("An account already exists with this email, Try Login!");
      } else {
        if (!context.mounted) return;
        _handleAuthError(e, context);
      }
      if (!context.mounted) return;
      Navigator.of(context).pop();
    } catch (e) {
      showToast("Un-Known Error Occured");
      if (!context.mounted) return;
      Navigator.of(context).pop();
      isLoading.value = false; // Ensure loading state is reset on unknown error
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
      Map<String, dynamic>? userProfile =
          await ProfileService().fetchUserProfile();
      if (userProfile != null) {
        String userName = userProfile["name"];
        String userEmail = userProfile["email"];
        String userPhone = userProfile["number"] ?? "";
        String userLevel = userProfile["level"] ?? "";
        String userPoints = userProfile["points"] ?? "";
        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(PrefKey.userName, userName);
        prefs.setString(PrefKey.email, userEmail);
        prefs.setString(PrefKey.phone, userPhone);
        prefs.setString(PrefKey.userLevel, userLevel);
        prefs.setString(PrefKey.userPoints, userPoints);
      }

      Future.delayed(const Duration(seconds: 1), () {
        if (!context.mounted) return;
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (context) => const BottomNavView()),
          (route) => false,
        );
      });
    } on FirebaseAuthException catch (e) {
      if (!context.mounted) return;
      Navigator.of(context).pop();
      if (!context.mounted) return;
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
    String? imageUrl,
    required BuildContext context,
  }) async {
    try {
      User? user = FirebaseAuth.instance.currentUser;
      String uid = FirebaseAuth.instance.currentUser!.uid;

      if (user != null) {
        await user.updateDisplayName(name);

        DocumentReference docRef =
            FirebaseFirestore.instance.collection("users").doc(uid);

        await docRef.set({
          "profile": {
            if (name != null) "name": name,
            if (number != null) "number": number,
            if (imageUrl != null) "imageUrl": imageUrl,
          }
        }, SetOptions(merge: true));

        SharedPreferences prefs = await SharedPreferences.getInstance();

        prefs.setString(PrefKey.phone, number!);

        showToast("User info updated successfully!");
      } else {
        throw Exception("No user is signed in.");
      }
    } catch (e) {
      throw Exception("Failed to update user info: $e");
    }
  }

////////////////////////////////////////////////////////////
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
    if (kDebugMode) {
      print("Error Message details$message");
    }
    Fluttertoast.showToast(
      msg: message,
    );
  }
}
