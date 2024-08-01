import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';

class MotixRepository {
  var collectionUsers = FirebaseFirestore.instance.collection("Users");
  var collectionPosts = FirebaseFirestore.instance.collection("Posts");

  Future<void> addUser(String userId, String userName, String userEmail,
      String profileIcon) async {
    //To add a user,
    var newUser = HashMap<String, dynamic>();
    newUser["userId"] = "";
    newUser["userName"] = userName;
    newUser["userEmail"] = userEmail;
    newUser["profileIcon"] = profileIcon;
    collectionUsers.add(newUser);
  } // end Future addUser

  Future<void> addPost(
    String postOwnerName,
    String postOwnerEmail,
    String postTitle,
    String postDescription,
    String postOwnerProfileIcon,
    List<String> postCategories,
  ) async {
    //To add a post,
    var newPost = HashMap<String, dynamic>();
    newPost["postId"] = "";
    newPost["postOwnerName"] = postOwnerName;
    newPost["postOwnerEmail"] = postOwnerEmail;
    newPost["postTitle"] = postTitle;
    newPost["postDescription"] = postDescription;
    newPost["postOwnerProfileIcon"] = postOwnerProfileIcon;
    newPost["postDate"] = FieldValue.serverTimestamp();
    newPost["postCategories"] = postCategories;

    await collectionPosts.add(newPost);
  } // end Future addPost

  Future<void> delete(String post_id) async {
    //To delete a post,
    collectionPosts.doc(post_id).delete();
  } // end Future delete
} // end class MotixRepository
