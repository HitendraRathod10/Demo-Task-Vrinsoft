import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../Single Selection/single_selection_provider.dart';
import '../utils/common_provider/internet_provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 2),(){
      Provider.of<InternetProvider>(context, listen: false).initializeInternet().then((value) {
        Provider.of<SingleSelectionProvider>(context, listen: false)
          .checkNavigation(context);
      },);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text("Splash"),
      ),
    );
  }
}
