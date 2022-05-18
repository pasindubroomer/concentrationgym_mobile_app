import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../data/models/user_daily_status_model.dart';
import '../../../../../data/repositories/common_repository.dart';

part 'bio_daily_status_state.dart';

class UserStatusCubit extends Cubit<UserStatusState> {
  final CommonRepository _commonRepository;

  UserStatusCubit(this._commonRepository) : super(const UserStatusState());

  Future<void> getUserDailyStatus() async {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    try {
      final userDailyStatusData =
          await _commonRepository.getUserDailyStatus("aipHwEhw9U1xqqQGU8oE");
      emit(state.copyWith(
          userDailyStatusModel: userDailyStatusData,
          processingState: ProcessingStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(
          processingState: ProcessingStatus.exception,
          errorMessage: e.toString()));
    }
  }

  void toggleButtonChanged(int index) {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    final List<bool> _list = [false, false];
    _list[index] = true;
    emit(state.copyWith(
        toggleButtonSelectionList: _list,
        toggleButtonSelectedIndex: index,
        processingState: ProcessingStatus.success));
  }
}
