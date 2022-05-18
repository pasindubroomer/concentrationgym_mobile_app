import 'package:concentrationgym_mobile_app/core/exceptions/firebase_auth_exception.dart';
import 'package:concentrationgym_mobile_app/core/utils/cache_client.dart';
import 'package:concentrationgym_mobile_app/data/models/user_model.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;

class AuthenticationRepository {
  final firebase_auth.FirebaseAuth _firebaseAuth;
  final CacheClient _cache;

  static const userCacheKey = '__user_cache_key__';

  AuthenticationRepository(
      {firebase_auth.FirebaseAuth? firebaseAuth, CacheClient? cache})
      : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
        _cache = cache ?? CacheClient();

  Stream<UserModel> get user {
    return _firebaseAuth.authStateChanges().map((firebaseuser) {
      final user = firebaseuser == null ? UserModel.empty : firebaseuser.toUser;
      _cache.write(key: userCacheKey, value: user);
      return user;
    });
  }

  UserModel get currentUser {
    return _cache.read(key: userCacheKey) ?? UserModel.empty;
  }

  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  Future<void> logInWithEmailAndPassword(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
    } on firebase_auth.FirebaseAuthException catch (e) {
      throw LogInWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithEmailAndPasswordFailure();
    }
  }

  Future<void> logOut() async {
    try {
      await Future.wait([_firebaseAuth.signOut()]);
    } catch (_) {
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  UserModel get toUser {
    return UserModel(uid: uid, email: email, displayName: displayName);
  }
}
