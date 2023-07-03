import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/user_provider.dart';
import '../utils/global_variables.dart';

class ResponsiveLayoutScreen extends StatefulWidget {
  final Widget webScreenlayout;
  final Widget mobileScreenlayout;
  const ResponsiveLayoutScreen(
      {Key? key,
      required this.webScreenlayout,
      required this.mobileScreenlayout})
      : super(key: key);

  @override
  State<ResponsiveLayoutScreen> createState() => _ResponsiveLayoutScreenState();
}

class _ResponsiveLayoutScreenState extends State<ResponsiveLayoutScreen> {
  bool isLoading = false;
  @override
  void initState() {
    super.initState();
    addData();
  }

  addData() async {
    isLoading = true;
    UserProvider _userProvider = Provider.of(context, listen: false);
    await _userProvider.refreshUser();
    isLoading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      if (constraints.maxWidth > webScreenSize) {
        return isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : widget.webScreenlayout;
      }
      return isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : widget.mobileScreenlayout;
    });
  }
}
