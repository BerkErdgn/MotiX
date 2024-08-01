import 'package:firebase_auth/firebase_auth.dart';

class Auth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // to get the current user
  User? get currentUser => _firebaseAuth.currentUser;

  bool checkIfUserSignIn() {
    // To check if the user is logged in,
    return _firebaseAuth.currentUser != null;
  } // end function checkIfUserSignIn

  Stream<User?> get authStateChanges => _firebaseAuth.authStateChanges();

  Future<void> signInWithEmailAndPassword({
    // User to register with email and password,
    required String email,
    required String password,
  }) async {
    await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  } // end Future signInWithEmailAndPassword

  Future<void> createUserWithEmailAndPassword(
      // For the user to register with email and password,
      {required String email,
      required String password}) async {
    await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  } // end  Future createUserWithEmailAndPassword

  Future<void> signOut() async {
    //For the user to log out,
    await _firebaseAuth.signOut();
  } // end Future signOut

  Future<void> sendPasswordResetLink(String email) async {
    //To send a password reset email if the user forgets password.
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (e) {
      print(e.toString());
    }
  } // end Future sendPasswordResetLink
} // end class Auth
