import 'package:flutter/material.dart';
import 'package:vrinsoft_interview_task/utils/app_colors.dart';

class DataCard extends StatelessWidget {
  final String imageUrl;
  final String name;

  const DataCard({
    super.key,
    required this.imageUrl,
    required this.name,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 05),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Image.asset(
            imageUrl,
            scale: 3,
          ),
          const SizedBox(width: 16),
          Text(
            name,
            style: const TextStyle(
              fontSize: 18,
              color: AppColor.textColor
            ),
          ),
        ],
      ),
    );
  }
}
