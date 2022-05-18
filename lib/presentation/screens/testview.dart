import 'package:flutter/material.dart';

import 'dashboard/views/dashboard_page.dart';

class TestView extends StatelessWidget {
  static Page page() => const MaterialPage<void>(child: TestView());

  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => const TestView());
  }

  const TestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const AppBarWidget(),
      body: Container(color: Colors.yellow),
    );
  }
}
