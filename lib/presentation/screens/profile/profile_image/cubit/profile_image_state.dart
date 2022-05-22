part of 'profile_image_cubit.dart';

class ProfileImageState {
  final String? imageUrl;
  final ProcessingStatus processingState;

  ProfileImageState(
      {this.imageUrl = "", this.processingState = ProcessingStatus.loading});

  ProfileImageState copyWith(
      {String? imageUrl, ProcessingStatus? processingState}) {
    return ProfileImageState(
      imageUrl: imageUrl ?? this.imageUrl,
      processingState: processingState ?? this.processingState,
    );
  }
}
