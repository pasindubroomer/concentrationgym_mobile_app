import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

import '../../../core/constants/colors.dart';
import '../../../core/constants/enums.dart';
import '../../router/router.dart';
import '../../widgets/loading_page.dart';
import 'cubit/profile_cubit.dart';

class Bio extends StatelessWidget {
  const Bio({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        return _buildBioContent(context, state);
      },
    );
  }
}

Widget _buildBioContent(BuildContext context, ProfileState state) {
  if (state.mainProcessingState == ProcessingStatus.success) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(
          height: 1.h,
        ),
        _buildBioButton(context),
        SizedBox(
          height: 1.h,
        ),
        _buildEmail(state, context),
        SizedBox(
          height: 1.h,
        ),
        _buildCommunity(context, state),
        SizedBox(
          height: 2.h,
        ),
        _buildFollowers(context, state),
        SizedBox(
          height: 1.h,
        ),
        SizedBox(
          height: 1.h,
        ),
      ],
    );
  } else if (state.mainProcessingState == ProcessingStatus.loading) {
    return const LoadingFull();
  } else if (state.mainProcessingState == ProcessingStatus.error) {
    return const Center(
      child: Text('Cannot load data'),
    );
  } else {
    return const Center(
      child: Text('Unknown state'),
    );
  }
}

Widget _buildBioButton(BuildContext context) {
  return GestureDetector(
    onTap: () => Navigator.of(context).pushNamed(AppRouter.BIO),
    child: Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(2), color: kDefaultBlueColor),
      padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
      child: Text(
        "BIO",
        style: Theme.of(context).textTheme.headline6!.copyWith(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: kDefaultWhiteColor),
      ),
    ),
  );
}

FittedBox _buildEmail(ProfileState state, BuildContext context) {
  return FittedBox(
    child: Text(
      state.userProfileModel!.email.toString(),
      style: Theme.of(context)
          .textTheme
          .headline6!
          .copyWith(fontWeight: FontWeight.w500),
    ),
  );
}

Row _buildFollowers(BuildContext context, ProfileState state) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      Column(
        children: [
          Text(
            "FOLLOWING",
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w500),
          ),
          Text(
            state.userProfileModel!.following.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w500),
          )
        ],
      ),
      SizedBox(
        width: 5.w,
      ),
      Column(
        children: [
          Text(
            "FOLLOWERS",
            style: Theme.of(context).textTheme.subtitle2!.copyWith(
                  fontWeight: FontWeight.w500,
                ),
          ),
          Text(
            state.userProfileModel!.followers.toString(),
            style: Theme.of(context)
                .textTheme
                .subtitle2!
                .copyWith(fontWeight: FontWeight.w500),
          )
        ],
      )
    ],
  );
}

Widget _buildCommunity(BuildContext context, ProfileState state) {
  if (state.userProfileModel!.community.toString().isEmpty) {
    return Container();
  }
  return Column(
    children: [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipOval(
            child: Image.asset(
              'assets/images/level.png',
              width: 8.w,
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            width: 1.w,
          ),
          Text(
            "SUPPORTER OF ",
            style: Theme.of(context).textTheme.headline6!.copyWith(
                fontWeight: FontWeight.w500, color: kDefaultBlueColor),
          )
        ],
      ),
      Text(
        state.userProfileModel!.community.toString(),
        style: Theme.of(context)
            .textTheme
            .headline6!
            .copyWith(fontWeight: FontWeight.w600, color: kDefaultBlackColor),
      )
    ],
  );
}
