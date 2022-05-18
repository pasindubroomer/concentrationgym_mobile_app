import 'package:bloc/bloc.dart';

import '../../../../core/constants/enums.dart';
import '../../../../data/models/user_daily_status_model.dart';
import '../../../../data/models/user_profile_model.dart';
import '../../../../data/repositories/common_repository.dart';

part 'bio_state.dart';

class BioCubit extends Cubit<BioState> {
  final CommonRepository _commonRepository;

  BioCubit(this._commonRepository) : super(const BioState());

  Future<void> getUserPersonalDetails() async {
    emit(state.copyWith(mainProcessingState: ProcessingStatus.loading));
    try {
      final userData =
      await _commonRepository.getUserProfileDetails("aipHwEhw9U1xqqQGU8oE");

      emit(state.copyWith(userProfileModel: userData, mainProcessingState: ProcessingStatus.success));
    } on Exception catch (e) {
      emit(state.copyWith(mainProcessingState: ProcessingStatus.exception,errorMessage: e.toString()));
    }
  }

}
