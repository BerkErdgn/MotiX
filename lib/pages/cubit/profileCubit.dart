import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/repo/MotiXRepository.dart';
import '../../data/entity/post.dart';

class ProfileCubit extends Cubit<List<Post>>{
  ProfileCubit() : super(<Post>[]);

  var collectionPosts = FirebaseFirestore.instance.collection("Posts");
  var motiXRepository = MotixRepository();

  Future<void> getAllPostByEmail(String email) async{
    collectionPosts.where("postOwnerEmail", isEqualTo: email).snapshots().listen((event){
      var postList = <Post>[];

      var documents = event.docs;
      for(var document in documents){
        var key = document.id;
        var data = document.data();
        var post = Post.fromJson(data, key);
        postList.add(post);
      }

      emit(postList);
    });
  }

  Future<void> delete(String post_id) async{
      await motiXRepository.delete(post_id);
  }

}

