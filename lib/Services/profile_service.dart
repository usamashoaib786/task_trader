import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ProfileService {
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Map<String, dynamic>?> fetchUserProfile() async {
    DocumentSnapshot docSnapshot =
        await _firestore.collection("users").doc(uid).get();

    if (docSnapshot.exists) {
      Map<String, dynamic>? profileData = docSnapshot.get("profile");
      return profileData;
    }
    return null;
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
}
