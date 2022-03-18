import 'dart:convert';

import 'package:equatable/equatable.dart';

enum OperationMode { edit, view }

class Profile extends Equatable {
  const Profile({
    required this.profileImage,
    required this.name,
    required this.uid,
    required this.email,
    required this.mode,
    required this.country,
  });

  factory Profile.fromMap(Map<String, dynamic> map) {
    return Profile(
      profileImage: map['profileImage'],
      name: map['name'] ?? '',
      uid: map['uid'] ?? '',
      email: map['email'] ?? '',
      mode: OperationMode.view,
      country: map['country'] ?? '',
    );
  }

  final dynamic profileImage;
  final String name;

  final String uid;
  final String email;
  final OperationMode mode;
  final String country;
  @override
  List<dynamic> get props {
    return [
      profileImage,
      name,
      uid,
      email,
      mode,
      country,
    ];
  }

  @override
  String toString() {
    return 'Profile(profileImage: $profileImage, name: $name, uid: $uid, email: $email, mode: $mode, country: $country)';
  }

  Profile copyWith({
    dynamic profileImage,
    String? name,
    String? uid,
    String? email,
    OperationMode? mode,
    String? country,
  }) {
    return Profile(
      profileImage: profileImage ?? this.profileImage,
      name: name ?? this.name,
      uid: uid ?? this.uid,
      email: email ?? this.email,
      mode: mode ?? this.mode,
      country: country ?? this.country,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'profileImage': profileImage,
      'name': name,
      'uid': uid,
      'email': email,
      'mode': mode.name,
      'country': country,
    };
  }

  String toJson() => json.encode(toMap());
}
