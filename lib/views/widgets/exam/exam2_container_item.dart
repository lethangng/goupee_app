// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/home_models/exam_item_model.dart';
import '../../../utils/text_themes.dart';
import '../image_container.dart';

class Exam2ContainerItem extends StatelessWidget {
  const Exam2ContainerItem({
    super.key,
    required this.exam,
    this.topExam,
  });
  final ExamItemModel exam;
  final int? topExam;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () =>
          Get.toNamed(Routes.examDetail, arguments: {'examId': exam.id}),
      child: ClipRRect(
          borderRadius: BorderRadius.circular(4),
          child: Stack(
            children: [
              ImageContainer(
                image: exam.image,
                replaceImage: 'assets/images/exam-1.png',
                height: Get.height * 0.2,
              ),
              Visibility(
                visible: topExam != null,
                child: Positioned(
                  top: 2,
                  right: 2,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 4,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF0E0E12).withOpacity(0.5),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        SvgPicture.asset('assets/icons/ranking.svg'),
                        const SizedBox(width: 4),
                        Text(
                          '#$topExam',
                          style: TextThemes.text12_400,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      exam.title,
                      maxLines: 2,
                      style: TextThemes.text12_600
                          .copyWith(overflow: TextOverflow.ellipsis),
                    ),
                  ),
                ),
              ),
            ],
          )),
    );
  }
}
