import 'package:cached_network_image/cached_network_image.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/enums.dart';
import '../../../widgets/loading_page.dart';
import 'cubit/profile_image_cubit.dart';

class ProfileImage extends StatelessWidget {
  const ProfileImage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileImageCubit, ProfileImageState>(
      builder: (context, state) {
        return _buildProfileImageContent(context, state);
      },
    );
  }

  Widget _buildProfileImageContent(
      BuildContext context, ProfileImageState state) {
    if (state.processingState == ProcessingStatus.success) {
      return Column(
        children: [
          SizedBox(
            height: 1.h,
          ),
          _buildProfileImage(context, state),
        ],
      );
    } else if (state.processingState == ProcessingStatus.loading) {
      return const LoadingFull();
    } else if (state.processingState == ProcessingStatus.error) {
      return const Center(
        child: Text('Cannot load data'),
      );
    } else {
      return const Center(
        child: Text('Unknown state'),
      );
    }
  }

  CircularPercentIndicator _buildProfileImage(
      BuildContext context, ProfileImageState state) {
    if (state.imageUrl!.isNotEmpty) {
      return CircularPercentIndicator(
          radius: 16.w,
          lineWidth: 2.w,
          animation: false,
          percent: 0.7,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: kDefaultBlueColor,
          center: Stack(
            children: [
              Container(
                width: 22.w,
                height: 22.h,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        state.imageUrl!,
                      ),
                      fit: BoxFit.contain),
                ),
              ),
              Positioned(
                  bottom: 3.h,
                  right: 1.w,
                  child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kDefaultWhiteColor,
                            width: 3,
                          ),
                          color: kDefaultBlueColor),
                      child: GestureDetector(
                        onTap: () async {
                          final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg']);

                          if (results == null) {
                          } else {
                            final path = results.files.single.path!;
                            context
                                .read<ProfileImageCubit>()
                                .uploadProfileImage(path)
                                .then((value) {
                              context
                                  .read<ProfileImageCubit>()
                                  .getProfileImageDownloadUrl();
                            });
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          size: 4.w,
                          color: kDefaultWhiteColor,
                        ),
                      )))
            ],
          ));
    } else {
      return CircularPercentIndicator(
          radius: 16.w,
          lineWidth: 2.w,
          animation: false,
          percent: 0.7,
          circularStrokeCap: CircularStrokeCap.round,
          progressColor: kDefaultBlueColor,
          center: Stack(
            children: [
              Icon(
                Icons.account_circle_rounded,
                size: 25.w,
                color: kDefaultBlueColor,
              ),
              Positioned(
                  bottom: 3.h,
                  right: 1.w,
                  child: Container(
                      padding: const EdgeInsets.all(3),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            color: kDefaultWhiteColor,
                            width: 3,
                          ),
                          color: kDefaultBlueColor),
                      child: GestureDetector(
                        onTap: () async {
                          final results = await FilePicker.platform.pickFiles(
                              allowMultiple: false,
                              type: FileType.custom,
                              allowedExtensions: ['png', 'jpg']);

                          if (results == null) {
                          } else {
                            final path = results.files.single.path!;
                            context
                                .read<ProfileImageCubit>()
                                .uploadProfileImage(path)
                                .then((value) {
                              context
                                  .read<ProfileImageCubit>()
                                  .getProfileImageDownloadUrl();
                            });
                          }
                        },
                        child: Icon(
                          Icons.edit,
                          size: 4.w,
                          color: kDefaultWhiteColor,
                        ),
                      )))
            ],
          ));
    }
  }
}
