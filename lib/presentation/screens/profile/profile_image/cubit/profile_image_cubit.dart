import 'package:bloc/bloc.dart';

import '../../../../../core/constants/enums.dart';
import '../../../../../data/repositories/firebase_storage_repository.dart';

part 'profile_image_state.dart';

class ProfileImageCubit extends Cubit<ProfileImageState> {
  final FirebaseStorageRepository _firebaseStorageRepository;
  ProfileImageCubit(this._firebaseStorageRepository)
      : super(ProfileImageState());

  Future<void> getProfileImageDownloadUrl() async {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    try {
      final imageUrl =
          await _firebaseStorageRepository.downloadUrl("aipHwEhw9U1xqqQGU8oE");
      emit(state.copyWith(
          imageUrl: imageUrl, processingState: ProcessingStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(processingState: ProcessingStatus.exception));
    }
  }

  Future<void> uploadProfileImage(String filePath) async {
    emit(state.copyWith(processingState: ProcessingStatus.loading));
    try {
      await _firebaseStorageRepository.uploadFile(
          filePath, "aipHwEhw9U1xqqQGU8oE");
      emit(state.copyWith(processingState: ProcessingStatus.success));
    } on Exception catch (_) {
      emit(state.copyWith(processingState: ProcessingStatus.exception));
    }
  }
}
