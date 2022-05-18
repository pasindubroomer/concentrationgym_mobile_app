import 'package:concentrationgym_mobile_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthenticationService {
  final FirebaseAuth _firebaseAuth;

  AuthenticationService(FirebaseAuth? firebaseAuth)
      : _firebaseAuth = firebaseAuth ?? FirebaseAuth.instance;

  Future<UserCredential> userSignIn(UserModel user) async {
    UserCredential? userModel = await _firebaseAuth.signInWithEmailAndPassword(
        email: user.email!, password: user.password!);

    return userModel;
  }
}
