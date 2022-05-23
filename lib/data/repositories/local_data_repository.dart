import 'package:concentrationgym_mobile_app/data/models/user_profile_model.dart';
import 'package:hive/hive.dart';

import '../models/user_routing_session_history_model.dart';

class LocalDataRepository {
  Future<void> addUserProfileDetails(UserProfileModel userProfileModel) async {
    var box = await Hive.openBox('userProfileModelBox');
    box.put('userProfile', userProfileModel);
  }

  Future<UserProfileModel?> getUserProfileDetails() async {
    var box = await Hive.openBox('userProfileModelBox');
    return box.get('userProfile');
  }

  Future<void> addUserRoutingSessionHistory(
      List<UserRoutingSessionHistoryModel>
          userRoutingSessionHistoryModelList) async {
    var box = await Hive.openBox('userRoutingSessionHistoryModelBox');
    box.put('historyList', userRoutingSessionHistoryModelList);
  }

  Future<List<UserRoutingSessionHistoryModel>?>
      getUserRoutingSessionHistory() async {
    var box = await Hive.openBox('userRoutingSessionHistoryModelBox');
    var historyList = box.get('historyList');
    if (historyList != null) {
      return (historyList as List)
          .map((e) => e as UserRoutingSessionHistoryModel)
          .toList();
    }

    return null;
  }
}
