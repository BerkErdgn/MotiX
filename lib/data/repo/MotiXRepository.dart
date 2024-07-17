import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class MotixRepository {
  var collectionUsers = FirebaseFirestore.instance.collection("Users");

  var collectionPosts = FirebaseFirestore.instance.collection("Posts");

  Future<void> addUser(String userId, String userName, String userEmail,
      String profileIcon) async {
    var newUser = HashMap<String, dynamic>();
    newUser["userId"] = "";
    newUser["userName"] = userName;
    newUser["userEmail"] = userEmail;
    newUser["profileIcon"] = profileIcon;
    collectionUsers.add(newUser);
  }

  Future<void> addPost(
    String postId,
    String postOwnerName,
    String postOwnerEmail,
    String postTitle,
    String postDescription,
    String postOwnerProfileIcon,
    String postDate,
    List<String> postCategories,
  ) async {
    var newPost = HashMap<String,dynamic>();
    newPost["postId"]= "";
    newPost["postOwnerName"]= postOwnerName;
    newPost["postOwnerEmail"]= postOwnerEmail;
    newPost["postTitle"]= postTitle;
    newPost["postDescription"]= postDescription;
    newPost["postOwnerProfileIcon"]= postOwnerProfileIcon;
    newPost["postDate"]= postDate;
    newPost["postCategories"]= postCategories;

    collectionPosts.add(newPost);
    
  }
}
