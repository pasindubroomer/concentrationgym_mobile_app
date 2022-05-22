import 'package:concentrationgym_mobile_app/data/models/user_profile_model.dart';
import 'package:hive/hive.dart';

import '../models/user_routing_session_history_model.dart';

class LocalDataRepository {
  Future<void> addUserProfileDetails(UserProfileModel userProfileModel) async {
    var box = await Hive.openBox('userProfileModel');
    box.put('userProfile', userProfileModel);
  }

  Future<UserProfileModel?> getUserProfileDetails() async {
    var box = await Hive.openBox('userProfileModel');
    return box.get('userProfile');
  }

  Future<void> addUserRoutingSessionHistory(
      List<UserRoutingSessionHistoryModel>
          userRoutingSessionHistoryModel) async {
    var box = await Hive.openBox<List<UserRoutingSessionHistoryModel>>(
        'userRoutingSessionHistoryModel');
    box.put('userRoutingSessionHistory', userRoutingSessionHistoryModel);
  }

  Future<List<UserRoutingSessionHistoryModel>?>
      getUserRoutingSessionHistory() async {
    var box = await Hive.openBox<List<UserRoutingSessionHistoryModel>>(
        'userRoutingSessionHistoryModel');
    return (box.get('userRoutingSessionHistory')
        as List<UserRoutingSessionHistoryModel>);
  }
}
