import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/repo/MotiXRepository.dart';

class AddPostCubit extends Cubit<void> {
  AddPostCubit() : super(0);

  var mrepo = MotixRepository();

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
    await mrepo.addPost(postId, postOwnerName, postOwnerEmail, postTitle,
        postDescription, postOwnerProfileIcon, postDate, postCategories);
  }
}