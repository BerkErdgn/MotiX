import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:motix_app/data/repo/MotiXRepository.dart';

class RegisterCubit extends Cubit<void> {
  RegisterCubit() : super(0);

  var mrepo = MotixRepository();

  Future<void> addUser(String userId, String userName, String userEmail,
      String profileIcon) async {
    //To save the user's data after registration,
    await mrepo.addUser(userId, userName, userEmail, profileIcon);
  } // end Future addUser
} // end class RegisterCubit
