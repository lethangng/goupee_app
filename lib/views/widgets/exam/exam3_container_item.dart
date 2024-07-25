// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/home_models/exam_item_model.dart';
import '../../../utils/text_themes.dart';
import '../../../utils/validate.dart';

class Exam3ContainerItem extends StatelessWidget {
  const Exam3ContainerItem({
    super.key,
    required this.exam,
  });

  final ExamItemModel exam;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.examDetail,
        arguments: {'examId': exam.id},
      ),
      child: Container(
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: const Color(0xFF312E2E),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              Validate.checkNullEmpty(exam.image)
                  ? exam.image!
                  : 'assets/images/cart-search-result.png',
              height: size.height * 0.2,
              fit: BoxFit.cover,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    exam.title,
                    style: TextThemes.text16_600,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      SvgPicture.asset('assets/icons/clock-icon.svg'),
                      const SizedBox(width: 8),
                      Text(
                        exam.created,
                        style: TextThemes.text14_400.copyWith(
                          color: const Color(0xFFC1C1CD),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(height: 8),
                  Row(
                    // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      infoContainer(
                        icon: 'assets/icons/heart-icon.svg',
                        title: '${exam.total_favourites}',
                      ),
                      infoContainer(
                        icon: 'assets/icons/eye-icon-2.svg',
                        title: '${exam.total_views}',
                      ),
                      // infoContainer(
                      //   icon: 'assets/icons/coin-icon.svg',
                      //   title: '${exam.total_gpoints}',
                      //   isLast: true,
                      // ),
                      Image.asset(
                        'assets/icons/coin-icon.png',
                        width: 20,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        '${exam.total_gpoints}',
                        style: TextThemes.text12_400,
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget infoContainer({
    required String title,
    required String icon,
    bool? isLast,
  }) {
    return Row(
      children: [
        SvgPicture.asset(
          icon,
          width: 20,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: TextThemes.text12_400,
        ),
        SizedBox(width: (isLast != null && isLast) ? 0 : 12),
      ],
    );
  }
}
