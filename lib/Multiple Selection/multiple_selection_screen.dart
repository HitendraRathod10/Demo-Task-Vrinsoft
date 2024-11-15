import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vrinsoft_interview_task/Multiple%20Selection/multiple_selection_provider.dart';
import 'package:vrinsoft_interview_task/Upload%20Photos/upload_photos_screen.dart';

import '../Progress Bar/progress_bar_provider.dart';
import '../Upload Photos/upload_photos_provider.dart';
import '../utils/app_colors.dart';
import '../utils/reusable_widgets/custom_button_widget.dart';

class MultipleSelectionScreen extends StatefulWidget {
  const MultipleSelectionScreen({super.key});

  @override
  State<MultipleSelectionScreen> createState() =>
      _MultipleSelectionScreenState();
}

class _MultipleSelectionScreenState extends State<MultipleSelectionScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(milliseconds: 1), () {
      Provider.of<ProgressBarProvider>(context, listen: false)
          .updateProgress(0.66);
      Provider.of<MultipleSelectionProvider>(context, listen: false)
          .fetchInterested();
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
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Consumer<MultipleSelectionProvider>(
            builder: (context, multipleSection, _) {
          return multipleSection.multipleSelectionModel == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "I am interested in",
                      style:
                          TextStyle(fontSize: 20, color: AppColor.primaryColor),
                    ),
                    SizedBox(height: 16),
                    ...multipleSection
                        .multipleSelectionModel!.data!.interestList!
                        .map((option) {
                      int index = multipleSection
                          .multipleSelectionModel!.data!.interestList!
                          .indexOf(option);
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: option.isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    option.isChecked = value!;
                                    if (value) {
                                      multipleSection.pickedMainInterests
                                          .add(option.title!);
                                      print(
                                          "Main Interest if ${multipleSection.pickedMainInterests}");
                                    } else {
                                      option.subInterest!.forEach(
                                          (subInterest) =>
                                              subInterest.isChecked = false);
                                      multipleSection.pickedMainInterests
                                          .remove(option.title!);
                                      multipleSection.subInterestIdsToRemove
                                          .clear();
                                      print("Main Interest else ${option.id}");
                                      for (var a in option.subInterest!) {
                                        multipleSection.subInterestIdsToRemove
                                            .add(a.subInterestId.toString());
                                      }
                                      print("Main Interest else subInterestIdsToRemove ${multipleSection.subInterestIdsToRemove}");
                                      for (var item in multipleSection.subInterestIdsToRemove) {
                                        if (multipleSection.pickedSubInterestsId
                                            .contains(item)) {
                                          multipleSection.pickedSubInterestsId
                                              .remove(item);
                                        }
                                      }
                                      print("Main Interest else ${multipleSection.pickedMainInterests}");
                                      print("Main Interest pickedSubInterestsId else ${multipleSection.pickedSubInterestsId}");
                                    }
                                  });
                                },
                              ),
                              GestureDetector(
                                onTap: () {},
                                child: Text(option.title!),
                              ),
                            ],
                          ),
                          if (option.isChecked! ||
                              multipleSection.pickedMainInterests
                                  .contains(option.title!))
                            Wrap(
                              spacing: 6,
                              runSpacing: 6,
                              children: option.subInterest!
                                  .map((subInterest) => GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            subInterest.isChecked =
                                                !subInterest.isChecked!;
                                            if (subInterest.isChecked!) {
                                              multipleSection.pickedSubInterestsId
                                                  .add(subInterest
                                                      .subInterestId!
                                                      .toString());
                                              multipleSection.finalSubInterests.add(subInterest.subInterestTitle!);
                                              print(
                                                  "pickedSubInterest if ${multipleSection.pickedSubInterestsId} ");
                                            } else {
                                              multipleSection.pickedSubInterestsId
                                                  .remove(subInterest
                                                      .subInterestId!
                                                      .toString());
                                              multipleSection.finalSubInterests.remove(subInterest.subInterestTitle!);
                                              print(
                                                  "pickedSubInterest else ${multipleSection.pickedSubInterestsId}");
                                            }
                                            if (option.subInterest!.every(
                                                (sub) => !sub.isChecked!)) {
                                              option.isChecked = false;
                                              multipleSection
                                                  .pickedMainInterests
                                                  .remove(option.title!);
                                            }
                                          });
                                        },
                                        child: Container(
                                            padding: EdgeInsets.all(5),
                                            height: 31,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(5),
                                                color: multipleSection
                                                        .pickedSubInterestsId
                                                        .contains(subInterest
                                                            .subInterestId
                                                            .toString())
                                                    ? AppColor.primaryColor
                                                    : AppColor.borderColor),
                                            child: Text(
                                              "${subInterest.subInterestTitle!}",
                                              // "${subInterest.subInterestId} ${multipleSection.pickedSubInterestsId}",
                                              style: TextStyle(
                                                  color: multipleSection
                                                          .pickedSubInterestsId
                                                          .contains(subInterest
                                                              .subInterestId
                                                              .toString())
                                                      ? AppColor.whiteColor
                                                      : AppColor.textColor),
                                            )),
                                      ))
                                  .toList(),
                            ),
                        ],
                      );
                    }).toList(),
                    Spacer(),
                    Row(
                      children: [
                        Checkbox(
                          value: multipleSection.isSelectedMultipleSelection,
                          onChanged: (bool? newValue) {
                            multipleSection.visibleOnProfile(newValue);
                          },
                        ),
                        const Text('Visible on profile'),
                      ],
                    ),
                  ],
                );
        }),
      ),
      bottomNavigationBar: Container(
        height: 100,
        child:
            Consumer2<ProgressBarProvider, MultipleSelectionProvider>(builder: (context, progressBar, multiSectionProvider, _) {
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
                            .updateProgress(0.33);
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
                        if(multiSectionProvider.pickedMainInterests.length > 0 && multiSectionProvider.pickedSubInterestsId.length > 0){
                          print("I am going for next screen");
                          multiSectionProvider.setMainInterest(multiSectionProvider.pickedMainInterests.toList());
                          multiSectionProvider.setSubInterest(multiSectionProvider.finalSubInterests.toList());
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => UploadPhotosScreen()));
                        }else{
                          if(multiSectionProvider.pickedMainInterests.length <= 0){
                            Fluttertoast.showToast(msg: "Please select main interest");
                          }else{
                            Fluttertoast.showToast(msg: "Please select sub interest");
                          }
                        }
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
