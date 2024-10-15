import 'package:core_dashboard/pages/dashboard/widgets/comment_item.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';

class Comments extends StatelessWidget {
  const Comments({super.key});

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final int itemCount = 12;
    return Container(
      decoration: const BoxDecoration(
        color: AppColors.bgSecondayLight,
        borderRadius: BorderRadius.all(
          Radius.circular(AppDefaults.borderRadius),
        ),
      ),
      padding: const EdgeInsets.all(AppDefaults.padding * 0.75),
      child: Column(
        children: [
          gapH8,
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDefaults.padding * 0.5,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const SectionTitle(
                  title: "Aniversariantes",
                  color: AppColors.secondaryPaleYellow,
                ),
                Text(
                  "$itemCount",
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey.shade600,
                  ),
                ),
              ],
            ),
          ),
          gapH16,
          SizedBox(
            height: screenHeight * 0.25,
            child: ListView.builder(
              itemCount: 12,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                return const CommentItem(
                  name: 'Ana Paula'
                );
              },
            ),
          ),
          gapH8,
        ],
      ),
    );
  }
}
