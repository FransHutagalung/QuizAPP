import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseFirestoreService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<void> addUserToFirestore(User user) async {
    await _db.collection('users').doc(user.uid).set({
      'uid': user.uid,
      'email': user.email,
      'name': user.displayName,
    });
  }
}
