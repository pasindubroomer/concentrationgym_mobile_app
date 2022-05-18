part of 'user_profile_cubit.dart';

class UserProfileState extends Equatable {
  final UserProfileModel? userProfileModel;
  final UserStatusModel? userDailyStatusModel;
  final ProcessingStatus loadingState;
  final List<bool> toggleButtonSelectionList;
  final int toggleButtonSelectedIndex;
  final String? errorMessage;

  const UserProfileState(
      {this.userProfileModel = const UserProfileModel(email: " "),this.userDailyStatusModel=const UserStatusModel(dailyEveningRouting: 0),this.errorMessage,
      this.loadingState = ProcessingStatus.loading,this.toggleButtonSelectionList = const [true,false], this.toggleButtonSelectedIndex=0});

  @override
  List<Object?> get props => [userProfileModel,userProfileModel, loadingState,toggleButtonSelectionList];

  UserProfileState copyWith({
    UserProfileModel? userProfileModel,
    UserStatusModel? userDailyStatusModel,
    ProcessingStatus? loadingState,
    List<bool>? toggleButtonSelectionList,
    int? toggleButtonSelectedIndex,
    String? errorMessage
  }) {
    return UserProfileState(
      userProfileModel: userProfileModel ?? this.userProfileModel,
      userDailyStatusModel: userDailyStatusModel ?? this.userDailyStatusModel,
      loadingState: loadingState ?? this.loadingState,
      errorMessage: errorMessage ?? this.errorMessage,
      toggleButtonSelectionList:
          toggleButtonSelectionList ?? this.toggleButtonSelectionList,
      toggleButtonSelectedIndex:
          toggleButtonSelectedIndex ?? this.toggleButtonSelectedIndex,
    );
  }
}
