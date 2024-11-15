import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vrinsoft_interview_task/Upload%20Photos/upload_photos_provider.dart';
import 'package:vrinsoft_interview_task/utils/app_colors.dart';

import '../Progress Bar/progress_bar_provider.dart';
import '../utils/reusable_widgets/custom_button_widget.dart';

class UploadPhotosScreen extends StatefulWidget {
  const UploadPhotosScreen({super.key});

  @override
  State<UploadPhotosScreen> createState() => _UploadPhotosScreenState();
}

class _UploadPhotosScreenState extends State<UploadPhotosScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      Provider.of<ProgressBarProvider>(context, listen: false)
          .updateProgress(0.99);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(
          Icons.arrow_back_ios,
          size: 17,
        ),
        titleSpacing: 0,
        title: Text(
          "Setup profile",
          style: TextStyle(color: AppColor.textColor, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(15, 00, 15, 00),
          child: Consumer<UploadPhotosProvider>(
              builder: (context, uploadPhotosProvider, _) {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Upload your photos",
                  style: TextStyle(fontSize: 20, color: AppColor.textColor),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  "You can upload upto 3 photos in JPG/PNG \nformat max 2mb",
                  style: TextStyle(fontSize: 16, color: AppColor.textColor),
                ),
                SizedBox(
                  height: 15,
                ),
                uploadPhotosProvider.imageFileList == null ||
                        uploadPhotosProvider.imageFileList!.length == 0
                    ? ElevatedButton(
                        onPressed: () {
                          uploadPhotosProvider.pickImage(context);
                        },
                        child: Container(
                          height: 100,
                          width: double.infinity,
                          child: Center(
                              child: Text(
                            "Please select image",
                            style: TextStyle(color: AppColor.primaryColor),
                          )),
                        ),
                      )
                    : SizedBox.shrink(),
                const SizedBox(height: 20),
                uploadPhotosProvider.imageFileList != null
                    ? Row(
                        children:
                            uploadPhotosProvider.imageFileList!.map((image) {
                          return Flexible(
                            child: Container(
                              margin: EdgeInsets.only(right: 10),
                              child: Stack(
                                children: [
                                  Image.file(
                                    File(image.path),
                                    fit: BoxFit.cover,
                                    width: 100,
                                    height: 100,
                                  ),
                                  Positioned(
                                    top: 3,
                                    right: 3,
                                    child: GestureDetector(
                                      onTap: () {
                                        uploadPhotosProvider.removeImage(
                                            uploadPhotosProvider.imageFileList!
                                                .indexOf(image));
                                      },
                                      child: Container(
                                        decoration: BoxDecoration(
                                          color: AppColor.redColor,
                                          borderRadius:
                                              BorderRadius.circular(5.0),
                                        ),
                                        child: Icon(Icons.close,
                                            color: AppColor.whiteColor),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      )
                    : SizedBox.shrink(),
                SizedBox(
                  height: 15,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.star,
                      color: AppColor.starColor,
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "The starred image will be the primary image.",
                            style: TextStyle(
                                fontSize: 16, color: AppColor.textColor),
                          ),
                          Text(
                            "You can drag and drop image to set as primary image.",
                            style: TextStyle(
                                fontSize: 16, color: AppColor.textColor),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child:
            Consumer<ProgressBarProvider>(builder: (context, progressBar, _) {
          return Column(
            children: [
              SizedBox(
                  width: MediaQuery.of(context).size.width / 2,
                  child: LinearProgressIndicator(
                    value: progressBar.progress,
                    color: AppColor.primaryColor,
                  )),
              SizedBox(
                height: 25,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: CustomButton(
                      onPressed: () {
                        Provider.of<ProgressBarProvider>(context, listen: false)
                            .updateProgress(0.66);
                        Navigator.pop(context);
                      },
                      text: "Prev",
                      backgroundColor: AppColor.whiteColor,
                      textColor: AppColor.primaryColor,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 2.2,
                    child: CustomButton(
                      onPressed: () {
                        Provider.of<UploadPhotosProvider>(context,
                                listen: false)
                            .checkValidation(context);
                      },
                      text: "Next",
                      backgroundColor: AppColor.primaryColor,
                      textColor: AppColor.whiteColor,
                    ),
                  ),
                ],
              ),
              SizedBox(
                width: 15,
              ),
            ],
          );
        }),
      ),
    );
  }
}
