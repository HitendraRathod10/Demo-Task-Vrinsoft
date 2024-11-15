import 'package:flutter/material.dart';
import 'package:vrinsoft_interview_task/utils/app_colors.dart';

class HorizontalLine extends StatelessWidget {
  final Color color;
  final double height;
  final EdgeInsets margin;

  const HorizontalLine({
    Key? key,
    this.color = AppColor.borderColor,
    this.height = 1.0,
    this.margin = const EdgeInsets.symmetric(horizontal: 10.0, vertical: 7.0),
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      color: color,
      margin: margin,
    );
  }
}