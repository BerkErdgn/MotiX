import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/entity/post.dart';

class SocialMediaCubit extends Cubit<List<Post>> {
  SocialMediaCubit() : super(<Post>[]);

  var collectionPosts = FirebaseFirestore.instance.collection("Posts");

  Future<void> getAllPost() async {
    //to get all posts
    collectionPosts
        .orderBy('postDate', descending: true)
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
  } // end Future getAllPost

  Future<void> getPostsByCategory(String category) async {
    // To Get All Posts By Category
    if (category == 'Trend') {
      // To fetch all posts in the Trend category
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
  } //end Future getPostsByCategory
} // end class SocialMediaCubit
