import 'package:flutter/material.dart';

import '../utils/dimensions.dart';

class ResponsiveLayoutScreen extends StatelessWidget {
  final Widget webScreenlayout;
  final Widget mobileScreenlayout;
  const ResponsiveLayoutScreen(
      {Key? key,
      required this.webScreenlayout,
      required this.mobileScreenlayout})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return webScreenlayout;
      }
      return mobileScreenlayout;
    });
  }
}
