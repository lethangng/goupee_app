// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../app/routes.dart';
import '../../models/home_models/exam_item_model.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import '../../utils/validate.dart';
import 'avatar_container.dart';
import 'image_container.dart';

class ExamContainerItem extends StatelessWidget {
  const ExamContainerItem({
    super.key,
    required this.exam,
    this.topExam,
  });

  final ExamItemModel exam;
  final int? topExam;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.examDetail,
        arguments: {'examId': exam.id},
      ),
      child: Column(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: ImageContainer(
                  image: exam.image,
                  replaceImage: 'assets/images/exam-image-1.png',
                  height: size.height * 0.27,
                ),
              ),
              Visibility(
                visible: topExam != null,
                child: Positioned(
                  top: 8,
                  right: 8,
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
            ],
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${exam.title}\n',
                  style: TextThemes.text14_600
                      .copyWith(overflow: TextOverflow.ellipsis),
                  maxLines: 2,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    SvgPicture.asset(
                      'assets/icons/clock-icon.svg',
                      width: 16,
                    ),
                    const SizedBox(width: 8),
                    Flexible(
                      child: Text(
                        exam.created,
                        style: TextThemes.text14_400.copyWith(
                          color: ColorApp.colorGrey,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Visibility(
                  visible: Validate.checkNullEmpty(exam.user_fullname),
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      children: [
                        AvatarContainer(
                          radius: 24,
                          image: exam.user_image,
                          replaceImage: 'assets/images/avatar.png',
                        ),
                        const SizedBox(width: 8),
                        Flexible(
                          child: Text(
                            exam.user_fullname!,
                            style: TextThemes.text14_400.copyWith(
                              color: ColorApp.colorGrey,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Row(
                  children: [
                    infoContainer(
                      icon: 'assets/icons/heart-icon.svg',
                      title: '${exam.total_favourites}',
                    ),
                    infoContainer(
                      icon: 'assets/icons/eye-icon-2.svg',
                      title: '${exam.total_views}',
                    ),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Image.asset(
                          'assets/icons/coin-icon-2.png',
                          width: 16,
                          height: 16,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${exam.total_gpoints}',
                          style: const TextStyle(
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    )
                    // infoContainer(
                    //   icon: 'assets/icons/coin-icon.svg',
                    //   title: '${exam.total_gpoints}',
                    // ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget infoContainer({
    required String title,
    required String icon,
    // bool? isLast,
  }) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          icon,
          width: 16,
          height: 16,
        ),
        const SizedBox(width: 4),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 12),
        // SizedBox(width: (isLast != null && isLast) ? 0 : 12),
      ],
    );
  }
}
