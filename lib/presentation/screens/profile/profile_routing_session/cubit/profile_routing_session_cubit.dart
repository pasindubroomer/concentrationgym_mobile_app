import 'package:bloc/bloc.dart';
import 'package:concentrationgym_mobile_app/data/models/user_routing_session_history_model.dart';
import 'package:equatable/equatable.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../data/repositories/common_repository.dart';

part 'profile_routing_session_state.dart';

class UserRoutingSessionHistoryCubit
    extends Cubit<UserRoutingSessionHistoryState> {
  final CommonRepository _commonRepository;

  UserRoutingSessionHistoryCubit(this._commonRepository)
      : super(const UserRoutingSessionHistoryState());

  Future<void> getUserRoutingSessionHistory() async {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    try {
      final userRoutinSessionHistoryData = await _commonRepository
          .getUserRoutingSessionHistory("aipHwEhw9U1xqqQGU8oE");
      emit(state.copyWith(
          userRoutingSessionHistoryModel: userRoutinSessionHistoryData,
          processingState: ProcessingStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(processingState: ProcessingStatus.exception));
    }
  }
}
