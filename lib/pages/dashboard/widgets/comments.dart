import 'package:core_dashboard/pages/dashboard/widgets/comment_item.dart';
import 'package:core_dashboard/shared/constants/defaults.dart';
import 'package:core_dashboard/shared/constants/ghaps.dart';
import 'package:core_dashboard/shared/widgets/section_title.dart';
import 'package:core_dashboard/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:convert';
import '../../../controllers/app_controller.dart';

class Comments extends StatefulWidget {
  const Comments({super.key});

  @override
  State<Comments> createState() => _CommentsState();
}

class _CommentsState extends State<Comments> {
  final AppController appController = Get.find<AppController>();
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final dynamic decodedJson = jsonDecode(appController.aniversariantes);
    final List<dynamic> dataList = decodedJson['data'];
    final int itemCount = dataList.length;

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
                  color: Colors.pink,
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
          if (itemCount == 0)
            Center(
              child: Text(
                "Nenhum aniversariante encontrado hoje.",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey.shade600,
                  fontWeight: FontWeight.w500,
                ),
              ),
            )
          else
          SizedBox(
            height: itemCount > 3 ? screenHeight * 0.35 : itemCount * 80,
            child: ListView.builder(
              itemCount: itemCount,
              padding: EdgeInsets.zero,
              itemBuilder: (_, index) {
                return CommentItem(
                  name: dataList[index]['nome'],
                  telefone: dataList[index]['telefone'],
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
