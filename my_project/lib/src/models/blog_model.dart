import 'package:cloud_firestore/cloud_firestore.dart';

class BlogModel {
  final String? id;
  final String title;
  final String description;
  final String category;
  final String authorId;
  final Timestamp createdAt;

  BlogModel({
    this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.authorId,
    required this.createdAt,
  });

  factory BlogModel.fromMap(Map<String, dynamic> map, String id) {
    return BlogModel(
      id: id,
      title: map['title'],
      description: map['description'],
      category: map['category'],
      authorId: map['authorId'],
      createdAt: map['createdAt'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'category': category,
      'authorId': authorId,
      'createdAt': createdAt,
    };
  }
}
