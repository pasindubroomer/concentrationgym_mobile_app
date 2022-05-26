import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:concentrationgym_mobile_app/data/models/user_bio_model.dart';
import 'package:concentrationgym_mobile_app/data/repositories/local_data_repository.dart';
import '../../core/exceptions/failure.dart';
import '../models/user_daily_status_model.dart';
import '../models/user_profile_model.dart';
import '../models/user_routing_session_history_model.dart';

class CommonRepository {
  final FirebaseFirestore _firestore;
  final LocalDataRepository _localDataRepository;

  final String userDetailsCollection = "user_details";
  final String userStatusCollection = "user_daily_exercises";
  final String userRoutingSessionHistoryCollection =
      "user_routing_session_history";
  final String userBioCollection = "userBioCollection";

  CommonRepository({FirebaseFirestore? firebaseFirestore})
      : _firestore = firebaseFirestore ?? FirebaseFirestore.instance,
        _localDataRepository = LocalDataRepository();

  Future<UserProfileModel> getUserProfileDetails(String uid) async {
    try {
      var userModel = await _localDataRepository.getUserProfileDetails();
      if (userModel != null) {
        return userModel;
      }
      final ref = _firestore.collection(userDetailsCollection).doc(uid);

      final docSnap = await ref.get();

      if (docSnap.data() != null) {
        _localDataRepository
            .addUserProfileDetails(UserProfileModel.fromJson(docSnap.data()!));
      }

      return UserProfileModel.fromJson(docSnap.data()!);
    } catch (e) {
      rethrow;
    }
  }

  Future<UserStatusModel> getUserDailyStatus(String uid) async {
    try {
      final ref =
          _firestore.collection(userStatusCollection).doc(uid).withConverter(
                fromFirestore: UserStatusModel.fromFirestore,
                toFirestore: (UserStatusModel user, _) => user.toFirestore(),
              );
      final docSnap = await ref.get();
      return docSnap.data() ?? UserStatusModel.empty;
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<UserBioModel> getUserBioDetails(String uid) async {
    try {
      final ref = _firestore.collection(userBioCollection).doc(uid);
      final docSnap = await ref.get();

      if (docSnap.exists) {
        return UserBioModel.fromJson(docSnap.data()!);
      } else {
        return UserBioModel.empty;
      }
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<void> updateUserBioDetails(
      String uid, UserBioModel userBioModel) async {
    try {
      final ref = _firestore.collection(userBioCollection).doc(uid);
      await ref.update(userBioModel.toJson()).catchError((onError) {
        throw Failure(onError.toString());
      });
    } catch (e) {
      throw Failure(e.toString());
    }
  }

  Future<List<UserRoutingSessionHistoryModel>?> getUserRoutingSessionHistory(
      String uid) async {
    try {
      var userRoutingSessionHistory =
          await _localDataRepository.getUserRoutingSessionHistory();
      if (userRoutingSessionHistory != null) {
        return userRoutingSessionHistory;
      }

      final ref = _firestore
          .collection(userRoutingSessionHistoryCollection)
          .doc(uid)
          .collection("sessions");
      final docSnap = await ref.get();

      List<UserRoutingSessionHistoryModel> _userSessions = docSnap.docs
          .map((d) => UserRoutingSessionHistoryModel.fromJson(d.data()))
          .toList();
      if (_userSessions.isNotEmpty) {
        _localDataRepository.addUserRoutingSessionHistory(_userSessions);
      }
      return _userSessions;
    } catch (e) {
      throw Failure(e.toString());
    }
  }
}
