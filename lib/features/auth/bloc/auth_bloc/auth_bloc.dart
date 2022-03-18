import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mmr_task/features/auth/bloc/auth_bloc/auth_state.dart';

import 'package:mmr_task/main.dart';
import 'package:regexpattern/regexpattern.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthState.fromMap(const {}));

  void changeOTP(String otp) {
    emit(state.copyWith(otp: otp));
  }

  void changePhoneNumber(String phone) {
    emit(state.copyWith(phoneNumber: phone));
  }

  Future<void> generateOTP() async {
    if (!validatePhoneNumber()) {
      return;
    }

    try {
      await firebaseConfig!.auth.verifyPhoneNumber(
        codeAutoRetrievalTimeout: (string) {},
        verificationFailed: (e) {
          throw e;
        },
        verificationCompleted: (credential) {},
        phoneNumber: '+91${state.phoneNumber}',
        codeSent: (verificationId, resendToken) async {
          emit(state.copyWith(verificationID: verificationId));
        },
      );
    } on FirebaseAuthException catch (e) {
      if (kDebugMode) {
        rethrow;
      }
      await Fluttertoast.showToast(msg: e.message ?? '');
    }
  }

  bool validatePhoneNumber() {
    if (state.phoneNumber.isPhone()) {
      Fluttertoast.showToast(msg: 'Phone should valid and be of 10 digits');
      return false;
    }
    return true;
  }

  Future<void> loginWithOTP() async {
    // Update the UI - wait for the user to enter the SMS code
    try {
      final smsCode = state.otp;
      assert(smsCode.length == 6);
      // Create a PhoneAuthCredential with the code
      final credential = PhoneAuthProvider.credential(
        verificationId: state.verificationID,
        smsCode: smsCode,
      );
      emit(state.copyWith(isVerifying: true));
      // Sign the user in (or link) with the credential
      await firebaseConfig!.auth.signInWithCredential(credential);
       emit(state.copyWith(isVerifying: false));
    } on FirebaseAuthException catch (e) {
      await Fluttertoast.showToast(msg: e.message ?? '');
    }
  }
}
