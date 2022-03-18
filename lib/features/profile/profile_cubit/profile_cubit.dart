import 'dart:async';
import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mmr_task/features/profile/models/profile/profile.dart';

import 'package:mmr_task/main.dart';

class ProfileCubit extends Cubit<Profile> {
  ProfileCubit() : super(Profile.fromMap(const {})) {
    firebaseConfig!.auth.userChanges().asBroadcastStream().listen((user) {
      if (user != null) {
        addSnapshotListener();
      }
    });
  }
  void reset() {
    emit(Profile.fromMap(const {}));
    firestoreSubscription?.cancel();
  }

  StreamSubscription? firestoreSubscription;
  void addSnapshotListener() {
    try {
      var uid = firebaseConfig!.auth.currentUser!.uid;
      firestoreSubscription = firebaseConfig!.firestore
          .collection("users")
          .doc(uid)
          .snapshots()
          .listen((event) async {
        if (event.data() != null) {
          var data = event.data();
          emit(Profile.fromMap(data!).copyWith(uid: uid));
        } else {
          var uid = firebaseConfig!.auth.currentUser!.uid;
          await firebaseConfig!.firestore
              .collection("users")
              .doc(uid)
              .set(state.toMap());
          return;
        }
      });
    } on Exception {
      /// TODO
    }
  }

  void changeOpMode(OperationMode mode) {
    emit(state.copyWith(mode: mode));
  }

  Future<void> uploadAndUpdateFile(File file) async {
    var docID = state.uid;
    var path = 'users/$docID/profileImage.jpg';
    await firebaseConfig!.storage.ref(path).putFile(file);
    var downloadUrl = await firebaseConfig!.storage.ref(path).getDownloadURL();

    emit(state.copyWith(profileImage: downloadUrl));
  }

  void updateKey(String key, dynamic newValue) {
    assert(state.uid.isNotEmpty);
    var map = state.toMap();
    map[key] = newValue;
    emit(Profile.fromMap(map).copyWith(mode: OperationMode.edit));
  }

  Future<void> saveProfile() async {
    try {
      for (final key in state.toMap().keys) {
        var value = state.toMap()[key];
        if (value is File || value is XFile) {
          await uploadAndUpdateFile(
            value is XFile ? File(value.path) : value,
          );
        }
      }

      await firebaseConfig!.firestore
          .collection("users")
          .doc(state.uid)
          .update(state.toMap());

      changeOpMode(OperationMode.view);
    } on StateError {
      ///
    }
  }
}
