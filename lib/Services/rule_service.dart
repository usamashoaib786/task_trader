import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';

class RulesService {
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
      List<dynamic>? rulesList = docSnapshot.get("Rules");
      if (rulesList != null) {
        return List<String>.from(rulesList);
      }
    }
    return [];
  }

  Future<void> dellRule(String ruleToDelete) async {

String uid = FirebaseAuth.instance.currentUser!.uid;    
  try {
    await FirebaseFirestore.instance.collection('users').doc(uid).update({
      'Rules': FieldValue.arrayRemove([ruleToDelete]),
    });
    
    showToast("Item removed successfully!");
  } catch (e) {
    showToast("Error removing item: $e");
  }
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
