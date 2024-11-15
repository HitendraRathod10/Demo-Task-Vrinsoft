import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrinsoft_interview_task/Home/home_provider.dart';
import 'package:vrinsoft_interview_task/Multiple%20Selection/multiple_selection_provider.dart';
import 'package:vrinsoft_interview_task/Progress%20Bar/progress_bar_provider.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_provider.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_screen.dart';
import 'package:vrinsoft_interview_task/Upload%20Photos/upload_photos_provider.dart';
import 'package:vrinsoft_interview_task/splash/splash_screen.dart';
import 'package:vrinsoft_interview_task/utils/common_provider/internet_provider.dart';
import 'package:vrinsoft_interview_task/utils/reusable_widgets/no_internet.dart';

import 'Home/home_screen.dart';
import 'Upload Photos/upload_photos_screen.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => UploadPhotosProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => SingleSelectionProvider()),
        ChangeNotifierProvider(create: (_) => MultipleSelectionProvider()),
        ChangeNotifierProvider(create: (_) => ProgressBarProvider()),
        ChangeNotifierProvider(create: (_) => InternetProvider()),
      ],
      key: navigatorKey,
      child: MaterialApp(
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        builder: (context, child){
          return InterNetConnectivity(child: child);
        },
        home: SplashScreen(),
        // home: SingleSelectionScreen(),
        // home: UploadPhotosScreen(),
        // home: HomeScreen(),
      ),
    );
  }
}
