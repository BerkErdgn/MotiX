import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/entity/post.dart';

class SocialMediaCubit extends Cubit<List<Post>> {
  SocialMediaCubit() : super(<Post>[]);

  var collectionPosts = FirebaseFirestore.instance.collection("Posts");


  Future<void> getAllPost() async {
    collectionPosts.orderBy('postDate', descending: true).snapshots().listen((event) {
      var postsList = <Post>[];

      var documents = event.docs;
      for (var document in documents) {
        var key = document.id;
        var data = document.data();
        var post = Post.fromJson(data, key);
        postsList.add(post);
      }

      emit(postsList);
    });
  }

  Future<void> getPostsByCategory(String category) async {
    if (category == 'Trend') {
      // Trend kategorisinde, tüm postları getirmesi için
      await getAllPost();
    } else {
      collectionPosts
          .orderBy('postDate', descending: true)
          .where('postCategories', arrayContains: category)
          .snapshots()
          .listen((event) {
        var postsList = <Post>[];

        var documents = event.docs;
        for (var document in documents) {
          var key = document.id;
          var data = document.data();
          var post = Post.fromJson(data, key);
          postsList.add(post);
        }

        emit(postsList);
      });
    }
  }


}
