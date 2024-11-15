import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:vrinsoft_interview_task/Multiple%20Selection/multiple_selection_screen.dart';
import 'package:vrinsoft_interview_task/Progress%20Bar/progress_bar_provider.dart';
import 'package:vrinsoft_interview_task/Single%20Selection/single_selection_provider.dart';

import '../utils/app_colors.dart';
import '../utils/common_provider/internet_provider.dart';
import '../utils/reusable_widgets/custom_button_widget.dart';

class SingleSelectionScreen extends StatefulWidget {
  const SingleSelectionScreen({super.key});

  @override
  State<SingleSelectionScreen> createState() => _SingleSelectionScreenState();
}

class _SingleSelectionScreenState extends State<SingleSelectionScreen> {


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration(seconds: 1), () {
      Provider.of<InternetProvider>(context, listen: false).initializeInternet();
      Provider.of<ProgressBarProvider>(context, listen: false)
          .updateProgress(0.33);
      Provider.of<SingleSelectionProvider>(context, listen: false)
          .fetchGenders(context);
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
        child: Consumer<SingleSelectionProvider>(
            builder: (context, singleSelection, _) {
          return singleSelection.singleSelectionModel == null
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "What’s your gender?",
                      style:
                          TextStyle(fontSize: 20, color: AppColor.primaryColor),
                    ),
                    SizedBox(height: 16),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: singleSelection
                            .singleSelectionModel!.data!.genderList!
                            .map((gender) => Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    RadioListTile<int>(
                                      title: Text(gender.title!),
                                      value: gender.id!,
                                      groupValue: singleSelection.selectedGenderId,
                                      contentPadding: EdgeInsets.zero,
                                      activeColor: AppColor.primaryColor,
                                      onChanged: (value) {
                                        singleSelection.mainGenderChange(value,gender.title!);
                                      },
                                    ),
                                    if (singleSelection.selectedGenderId == gender.id)
                                      Wrap(
                                        spacing: 6,
                                        runSpacing: 6,
                                        children: singleSelection
                                            .singleSelectionModel!
                                            .data!
                                            .genderList!
                                            .firstWhere(
                                                (g) => g.id == singleSelection.selectedGenderId)
                                            .subGender!
                                            .map(
                                              (subGender) => GestureDetector(
                                                onTap: () {
                                                  singleSelection.subGenderChange(subGender.subGenderTitle!);
                                                },
                                                child: Container(
                                                    padding: EdgeInsets.all(5),
                                                    height: 31,
                                                    decoration: BoxDecoration(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(5),
                                                        color: singleSelection.pickedSubGender == subGender.subGenderTitle
                                                            ? AppColor
                                                                .primaryColor
                                                            : AppColor
                                                                .borderColor),
                                                    child: Text(subGender
                                                        .subGenderTitle!,style: TextStyle(color: singleSelection.pickedSubGender == subGender.subGenderTitle ? AppColor.whiteColor : AppColor.textColor),)),
                                              ),
                                            )
                                            .toList(),
                                      ),
                                  ],
                                ))
                            .toList(),
                      ),
                    ),
                    Spacer(),
                    Row(
                      children: [
                        Checkbox(
                          value: singleSelection.isSelectedSingleSelection,
                          onChanged: (bool? newValue) {
                            singleSelection.visibleOnProfile(newValue);
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
            Consumer2<ProgressBarProvider, SingleSelectionProvider>(builder: (context, progressBar, singleSelection, _) {
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
                    width: MediaQuery.of(context).size.width / 1.1,
                    child: CustomButton(
                      onPressed: () {
                        if(singleSelection.pickedSubGender != "" && singleSelection.selectedMainGender != ""){
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => MultipleSelectionScreen()));
                          print("${singleSelection.selectedMainGender} ${singleSelection.pickedSubGender}");
                          singleSelection.setMainGender(singleSelection.selectedMainGender);
                          singleSelection.setSubGender(singleSelection.pickedSubGender!);
                          // Fluttertoast.showToast(msg: "I will go for multiple select");
                        }else{
                          if(singleSelection.selectedMainGender == ""){
                            Fluttertoast.showToast(msg: "Please select gender");
                          }else{
                            Fluttertoast.showToast(msg: "Please select sub gender");
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
