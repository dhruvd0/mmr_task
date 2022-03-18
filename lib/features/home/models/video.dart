import 'dart:convert';

import 'package:equatable/equatable.dart';

class Video extends Equatable {
  final String youtubeLink;
  final bool isCompleted;
  final String name;
  const Video({
    required this.youtubeLink,
    required this.isCompleted,
    required this.name,
  });

  Video copyWith({
    String? youtubeLink,
    bool? isCompleted,
    String? name,
  }) {
    return Video(
      youtubeLink: youtubeLink ?? this.youtubeLink,
      isCompleted: isCompleted ?? this.isCompleted,
      name: name ?? this.name,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'youtubeLink': youtubeLink,
      'isCompleted': isCompleted,
      'name': name,
    };
  }

  factory Video.fromMap(Map<String, dynamic> map) {
    return Video(
      youtubeLink: map['youtubeLink'] ?? '',
      isCompleted: map['isCompleted'] ?? false,
      name: map['name'] ?? '',
    );
  }

  String toJson() => json.encode(toMap());

  @override
  String toString() => 'Video(youtubeLink: $youtubeLink, isCompleted: $isCompleted, name: $name)';

  @override
  List<Object> get props => [youtubeLink, isCompleted, name];
}
