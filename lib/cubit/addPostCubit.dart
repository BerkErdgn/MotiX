import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/repo/MotiXRepository.dart';

class AddPostCubit extends Cubit<void> {
  AddPostCubit() : super(0);

  var mrepo = MotixRepository();

  Future<void> addPost(
    String postOwnerName,
    String postOwnerEmail,
    String postTitle,
    String postDescription,
    String postOwnerProfileIcon,
    List<String> postCategories,
  ) async {
    //To save the user's post;
    await mrepo.addPost(
      postOwnerName,
      postOwnerEmail,
      postTitle,
      postDescription,
      postOwnerProfileIcon,
      postCategories,
    );
  } // end Future addPost
} // end class AddPostCubit
