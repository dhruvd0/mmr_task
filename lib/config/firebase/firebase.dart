
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirebaseConfig {
  FirebaseConfig({
    required this.auth,
    required this.firestore,
    required this.storage,
  });

  factory FirebaseConfig.defaultInstances() {
    return FirebaseConfig(
      auth: FirebaseAuth.instance,
      firestore: FirebaseFirestore.instance,
      storage: FirebaseStorage.instance
    );
  }

  final FirebaseAuth auth;
  final FirebaseFirestore firestore;
  final FirebaseStorage storage;

  
}
