
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../core/constants/colors.dart';
import '../../router/router.dart';

class SplashScreen extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

//    openLogin();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: kmainBackgroundColor,
        child: Center(
          child: SizedBox(
            width: 240,
            child: SvgPicture.asset(
              'assets/fitness.svg',
              color: kTextBlackColor,
            ),
          ),
        ),
      ),
    );
  }

  void openLogin() {
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushNamed(context, AppRouter.LOGIN);
    });
  }
}
