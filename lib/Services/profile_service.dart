import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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
}
