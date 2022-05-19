import 'package:auto_size_text/auto_size_text.dart';
import 'package:concentrationgym_mobile_app/presentation/screens/testview.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';

import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../../core/constants/colors.dart';
import '../../../../core/constants/default_size.dart';
import '../../../../data/models/challenge.dart';
import '../../../widgets/custom_snackbar.dart';
import '../cubit/dashboard_cubit.dart';

class DashboardForm extends StatelessWidget {
  const DashboardForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocListener<DashboardCubit, DashboardState>(
        child: SingleChildScrollView(
          child: Padding(
            padding: kPaddingDefault,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(height: 1.h),
                const _ChallengeWidget(),
                SizedBox(height: 5.h),
                const _GridView()
              ],
            ),
          ),
        ),
        listener: (context, state) {
          if (state.status.isSubmissionFailure) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                showSnackbar(state.errorMessage ?? "Authentication Failure"),
              );
          } else if (state.status.isSubmissionInProgress) {
            context.loaderOverlay.show();
          } else if (state.status.isSubmissionSuccess) {
            context.loaderOverlay.hide();
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                showSnackbar("Account created successfully"),
              );
          } else {
            context.loaderOverlay.hide();
          }
        });
  }
}

class _ChallengeWidget extends StatelessWidget {
  const _ChallengeWidget({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 5.w),
      decoration: BoxDecoration(
          color: kDefaultBlackColor, borderRadius: BorderRadius.circular(10)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "PETES",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kTextWhiteColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              Text(
                "CHALLENGES",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: kTextWhiteColor,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 2),
              ),
              SizedBox(height: 2.h),
              Text(
                "1 DAYS LEFT",
                style: Theme.of(context)
                    .textTheme
                    .subtitle2!
                    .copyWith(color: kTextWhiteColor, letterSpacing: 2),
              )
            ],
          ),
          FittedBox(
            child: Icon(
              Icons.hexagon,
              size: 50,
              color: kDefaultWhiteColor,
            ),
          )
        ],
      ),
    );
  }
}

class _GridView extends StatelessWidget {
  const _GridView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Challenge> challenges = Challenge.getChallengeList();

    return SizedBox(
      height: 60.h,
      child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: 1,
              crossAxisSpacing: 5,
              mainAxisSpacing: 5),
          itemCount: challenges.length,
          itemBuilder: (BuildContext ctx, index) {
            return ChallengeWidget(challenge: challenges[index]);
          }),
    );
  }
}

class ChallengeWidget extends StatelessWidget {
  const ChallengeWidget({
    Key? key,
    required this.challenge,
  }) : super(key: key);

  final Challenge challenge;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed('/second');
        //Navigator.of(context).push<void>(TestView.route());
      },
      child: Container(
          padding: EdgeInsets.fromLTRB(2.w, 0, 1.w, 2.h),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: const Color.fromARGB(110, 221, 221, 221),
          ),
          child: Stack(
            children: [
              Positioned(
                child: Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    'assets/images/level.png',
                    width: 25.w,
                  ),
                ),
              ),
              Positioned(
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        challenge.title,
                        style: GoogleFonts.oswald(
                          fontSize: 12.sp,
                          fontWeight: FontWeight.w800,
                          textStyle: const TextStyle(
                              color: Color(0xFFe40001), height: 1.1),
                        ),
                      ),
                      SizedBox(height: 1.h),
                      Text(
                        challenge.subtitle!,
                        style: GoogleFonts.oswald(
                          fontWeight: FontWeight.w600,
                          textStyle:
                              TextStyle(fontSize: 8.sp, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )),
    );
  }
}
