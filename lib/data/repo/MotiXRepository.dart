import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';

class MotixRepository {
  var collectionUsers = FirebaseFirestore.instance.collection("Users");

  Future<void> addUser(String userId, String userName, String userEmail,
      String profileIcon) async {
    var newUser = HashMap<String, dynamic>();
    newUser["userId"] = "";
    newUser["userName"] = userName;
    newUser["userEmail"] = userEmail;
    newUser["profileIcon"] = profileIcon;
    collectionUsers.add(newUser);
  }
}
