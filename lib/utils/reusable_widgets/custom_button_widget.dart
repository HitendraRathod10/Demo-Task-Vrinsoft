import 'package:flutter/material.dart';
import 'package:vrinsoft_interview_task/utils/app_colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final Color backgroundColor;
  final Color textColor;
  final VoidCallback onPressed;

  const CustomButton({
    Key? key,
    required this.text,
    this.backgroundColor = AppColor.primaryColor,
    this.textColor = AppColor.textColor,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10.0), // Adjust radius as needed
          border: Border.all(
            color: AppColor.primaryColor, // Adjust border color and width as needed
            width: 1.0,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
