import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../app_colors.dart';
import '../common_provider/internet_provider.dart';

class InterNetConnectivity extends StatelessWidget {
  final Widget? child;
  const InterNetConnectivity({super.key, this.child});

  @override
  Widget build(BuildContext context) {
    return Consumer<InternetProvider>(
      builder: (context, internetProvider, _) {
        return Stack(
          fit: StackFit.expand,
          children: <Widget>[
            child!,
            if(!internetProvider.isInterNetAvailable)...{
              Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: AppColor.borderColor,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.signal_wifi_connected_no_internet_4_outlined,size: 100,),
                      const SizedBox(height: 10,),
                      Material(child: Text("No Internet Connection found\ncheck your connection!",textAlign: TextAlign.center,))
                    ],
                  )
              )
            }
          ],
        );
      },
    );
  }
}
