import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

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
}
