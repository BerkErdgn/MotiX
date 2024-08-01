import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/entity/userImageEntity.dart';

class Imagecubit extends Cubit<List<UserImageEntity>> {
  Imagecubit() : super(<UserImageEntity>[]);

  var collectionUsers = FirebaseFirestore.instance.collection("Users");

  Future<void> getUserImage(String email) async {
    // To get user's photo
    collectionUsers
        .where("userEmail", isEqualTo: email)
        .snapshots()
        .listen((event) {
      var userImageList = <UserImageEntity>[];
      var documents = event.docs;

      for (var document in documents) {
        var key = document.id;
        var data = document.data();
        var userImage = UserImageEntity.fromJson(data, key);
        userImageList.add(userImage);
      }

      emit(userImageList);
    });
  } //end Future getUserImage
} // end class Imagecubit
