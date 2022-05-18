import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class ErrorScreen extends StatelessWidget {
  const ErrorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100.w,
      height: 100.h,
      child: Image.asset(
        "assets/images/error.png",
        fit: BoxFit.cover,
      ),
    );
  }
}
