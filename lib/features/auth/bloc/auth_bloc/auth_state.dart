import 'dart:convert';

import 'package:equatable/equatable.dart';

class AuthState extends Equatable {
  const AuthState({
    required this.otp,
    required this.phoneNumber,
    required this.verificationID,
    required this.isVerifying,
  });

  factory AuthState.fromMap(Map<String, dynamic> map) {
    return AuthState(
      otp: map['otp'] ?? '',
      phoneNumber: map['phoneNumber'] ?? '',
      verificationID: map['verificationID'] ?? '',
      isVerifying: map['isVerifying'] ?? false,
    );
  }

  final String otp;
  final String phoneNumber;
  final String verificationID;
  final bool isVerifying;

  @override
  List<Object> get props => [otp, phoneNumber, verificationID, isVerifying];

  @override
  String toString() {
    return 'AuthState(otp: $otp, phoneNumber: $phoneNumber, verificationID: $verificationID, isVerifying: $isVerifying)';
  }

  AuthState copyWith({
    String? otp,
    String? phoneNumber,
    String? verificationID,
    bool? isVerifying,
  }) {
    return AuthState(
      otp: otp ?? this.otp,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      verificationID: verificationID ?? this.verificationID,
      isVerifying: isVerifying ?? this.isVerifying,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'otp': otp,
      'phoneNumber': phoneNumber,
      'verificationID': verificationID,
      'isVerifying': isVerifying,
    };
  }

  String toJson() => json.encode(toMap());
}
