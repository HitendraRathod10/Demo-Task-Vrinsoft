import 'dart:convert';
import 'dart:io';

import 'package:carousel_slider/carousel_options.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vrinsoft_interview_task/Home/home_provider.dart';
import 'package:vrinsoft_interview_task/Multiple%20Selection/multiple_selection_provider.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_provider.dart';
import 'package:vrinsoft_interview_task/Upload%20Photos/upload_photos_provider.dart';
import 'package:vrinsoft_interview_task/utils/app_colors.dart';
import 'package:vrinsoft_interview_task/utils/app_images.dart';

import '../utils/reusable_widgets/home_data_widget.dart';
import '../utils/reusable_widgets/home_horizontal_line.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    onInit();
  }

  onInit() async {
    Provider.of<HomeProvider>(context, listen: false).loadTextFromPrefs();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Image.asset(
            AppImage.homeAppBarLocation,
            scale: 3,
          ),
        ),
        leadingWidth: 40,
        title: const Text(
          "Camden town",
          style: TextStyle(fontSize: 16, color: AppColor.textColor),
        ),
        titleSpacing: 0,
        actions: <Widget>[
          Image.asset(
            AppImage.homeAppBarFilter,
            scale: 3,
          ),
          const SizedBox(
            width: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(right: 15),
            child: Image.asset(
              AppImage.homeAppBarNotification,
              scale: 3,
            ),
          ),
          Padding(
              padding: const EdgeInsets.only(right: 15),
              child: GestureDetector(
                  onTap: () {
                    Provider.of<HomeProvider>(context,listen: false).logout(context);
                  },
                  child: Icon(Icons.power_settings_new_outlined))),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Consumer<HomeProvider>(
            builder: (context, home, _) {
              return Column(
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        radius: 24,
                        backgroundImage: Image.file(
                          // File(
                          //   Provider.of<UploadPhotosProvider>(context, listen: false)
                          //       .imageFileList?.first.path ?? "",
                          // ),
                          File(home.loadedImages![0].path ?? "",
                          ),
                        ).image,
                      ),
                      SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Amelia Collins',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: AppColor.textColor),
                          ),
                          Text(
                            'Finance professional',
                            style:
                                TextStyle(fontSize: 16, color: AppColor.textColor),
                          ),
                        ],
                      ),
                      Spacer(),
                      Image.asset(
                        AppImage.homeVector,
                        scale: 3,
                      )
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  CarouselSlider(
                    items: home.loadedImages!.map((image) {
                      return Builder(
                        builder: (BuildContext context) {
                          return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 10.0),
                            decoration: BoxDecoration(
                              color: Colors.grey,
                            ),
                            child: Image.file(
                              File(image.path),
                              fit: BoxFit.cover,
                            ),
                          );
                        },
                      );
                    }).toList(),
                    options: CarouselOptions(
                        height: 400.0,
                        autoPlay: true,
                        autoPlayInterval: Duration(seconds: 3),
                        autoPlayAnimationDuration: Duration(milliseconds: 800),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        enlargeCenterPage: true,
                        scrollDirection: Axis.horizontal,
                        enableInfiniteScroll: false),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Consumer2<HomeProvider, MultipleSelectionProvider>(
                      builder: (context, home, multipleSelection, _) {
                    return Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                          border: Border.all(
                            color: AppColor.borderColor,
                            width: 1,
                          ),
                          borderRadius: BorderRadius.circular(10)),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 10,
                          ),
                          home.singleSelectionVisible == true
                              ? Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Gender : ${home.mainGender} & SubGender : ${home.subGender} "),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10,
                          ),
                          home.multipleSelectionVisible == true
                              ? Container(
                                  padding: EdgeInsets.only(left: 10),
                                  child: Text(
                                      "Interest : ${home.mainInterestList.join(',')} & SubInterest : ${home.subInterestList.join(',')} "),
                                )
                              : SizedBox.shrink(),
                          SizedBox(
                            height: 10,
                          ),
                          DataCard(
                            imageUrl: '${AppImage.homeAge}',
                            name: '27',
                          ),
                          HorizontalLine(),
                          DataCard(
                            imageUrl: '${AppImage.homeHeight}',
                            name: '5\'8"',
                          ),
                          HorizontalLine(),
                          DataCard(
                            imageUrl: '${AppImage.homeGender}',
                            name: 'Male',
                          ),
                          HorizontalLine(),
                          DataCard(
                            imageUrl: '${AppImage.homeDirection}',
                            name: 'Straight',
                          ),
                          HorizontalLine(),
                          DataCard(
                            imageUrl: '${AppImage.homeGender}',
                            name: 'Middle eastern',
                          ),
                          HorizontalLine(),
                          DataCard(
                            imageUrl: '${AppImage.homeHome}',
                            name: 'London',
                          ),
                          SizedBox(
                            height: 10,
                          ),
                        ],
                      ),
                    );
                  })
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}
