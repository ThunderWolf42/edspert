import 'package:cloud_firestore/cloud_firestore.dart';

class DiscussionModel {
  final String email;
  final String name;
  final String? pictureUrl;
  final Timestamp timestamp;
  final String message;

  DiscussionModel({
    required this.email,
    required this.name,
    required this.pictureUrl,
    required this.timestamp,
    required this.message,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      'pictureUrl': pictureUrl,
      'timestamp': timestamp,
      'message': message,
    };
  }

  factory DiscussionModel.fromMap(Map<String, dynamic> map) {
    return DiscussionModel(
      email: map['email'] as String,
      name: map['name'] as String,
      pictureUrl: map['pictureUrl'] as String?,
      timestamp: map['timestamp'] as Timestamp,
      message: map['message'] as String,
    );
  }
}
