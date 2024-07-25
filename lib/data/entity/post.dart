import 'package:cloud_firestore/cloud_firestore.dart';

class Post {
  String postId;
  String postOwnerName;
  String postOwnerEmail;
  String postTitle;
  String postDescription;
  String postOwnerProfileIcon;
  Timestamp postDate;
  List<String> postCategories;

  Post({
    required this.postId,
    required this.postOwnerName,
    required this.postOwnerEmail,
    required this.postTitle,
    required this.postDescription,
    required this.postOwnerProfileIcon,
    required this.postDate,
    required this.postCategories,
  });

  factory Post.fromJson(Map<dynamic, dynamic> json, String key) {
    return Post(
      postId: key,
      postOwnerName: json["postOwnerName"] as String? ?? "",
      postOwnerEmail: json["postOwnerEmail"] as String? ?? "",
      postTitle: json["postTitle"] as String? ?? "",
      postDescription: json["postDescription"] as String? ?? "",
      postOwnerProfileIcon: json["postOwnerProfileIcon"] as String? ?? "",
      postDate: json["postDate"] as Timestamp? ?? Timestamp.now(),
      postCategories: List<String>.from(json['postCategories'] ?? []),
    );
  }
}