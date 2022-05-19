part of 'profile_routing_session_cubit.dart';

class UserRoutingSessionHistoryState extends Equatable {
  final List<UserRoutingSessionHistoryModel>? userRoutingSessionHistoryModel;
  final ProcessingStatus? processingState;

  const UserRoutingSessionHistoryState(
      {this.userRoutingSessionHistoryModel, this.processingState});

  UserRoutingSessionHistoryState copyWith({
    List<UserRoutingSessionHistoryModel>? userRoutingSessionHistoryModel,
    ProcessingStatus? processingState,
  }) {
    return UserRoutingSessionHistoryState(
      userRoutingSessionHistoryModel:
          userRoutingSessionHistoryModel ?? this.userRoutingSessionHistoryModel,
      processingState: processingState ?? this.processingState,
    );
  }

  @override
  List<Object?> get props => [userRoutingSessionHistoryModel, processingState];
}
