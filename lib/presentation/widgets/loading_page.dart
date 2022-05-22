import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';

class LoadingFull extends StatelessWidget {
  const LoadingFull({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: 100.w,
          height: 100.h,
          child: Center(
            child: SizedBox(
                width: 4.w,
                height: 4.w,
                child: const CircularProgressIndicator()),
          ),
        ),
      ],
    );
  }
}

class LoadingMini extends StatelessWidget {
  const LoadingMini({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Center(
          child: SizedBox(
              width: 4.w,
              height: 4.w,
              child: const CircularProgressIndicator()),
        ),
      ],
    );
  }
}
