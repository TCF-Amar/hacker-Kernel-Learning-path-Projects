import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreAuthServices {
  final FirebaseFirestore _db = FirebaseFirestore.instance;


  Future<void> saveUser(User user) async {
    final docRef = _db.collection('users').doc(user.uid);
    final doc = await docRef.get();
    if (!doc.exists) {
      await docRef.set(user.toMap());
    } else {
      await docRef.update(user.toMap());
    }
  }

  Future<void> getUser(String uid) async {
    final docRef = _db.collection('users').doc(uid);
    final doc = await docRef.get();
    if (doc.exists) {
      final data = doc.data();
      // print(" Hahaha data mill h=gaya $data");
    } else {
      print('No such document!');
    }
  }

}

extension on User {
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'displayName': displayName,
      'photoURL': photoURL,
      'phoneNumber': phoneNumber,
      'createdAt': FieldValue.serverTimestamp(),
      'lastLoginAt': FieldValue.serverTimestamp(),
    };
  }
}
