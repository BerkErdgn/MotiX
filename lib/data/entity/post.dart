class Post {
  String postId;
  String postOwnerName;
  String postOwnerEmail;
  String postTitle;
  String postDescription;
  String postOwnerProfileIcon;
  String postDate;
  List<String> postCategories;

  Post(
      {required this.postId,
      required this.postOwnerName,
      required this.postOwnerEmail,
      required this.postTitle,
      required this.postDescription,
      required this.postOwnerProfileIcon,
      required this.postDate,
      required this.postCategories});

  factory Post.froJson(Map<dynamic, dynamic> json, key) {
    return Post(
      postId: key,
      postOwnerName: json["postOwnerName"] as String? ?? "",
      postOwnerEmail: json["postOwnerEmail"] as String? ?? "",
      postTitle: json["postTitle"] as String? ?? "",
      postDescription: json["postDescription"] as String? ?? "",
      postOwnerProfileIcon: json["postOwnerProfileIcon"] as String? ?? "",
      postDate: json["postDate"] as String? ?? "",
      postCategories: List<String>.from(json['postCategories'] ?? []),
    );
  }
}
