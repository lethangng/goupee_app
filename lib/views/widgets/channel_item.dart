// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';

import '../../app/routes.dart';
import '../../models/home_models/channel_item_model.dart';
import '../../utils/color_app.dart';
import '../../utils/top.dart';
import 'avatar_container.dart';
import 'exam_container_item.dart';

class ChannelItem extends StatelessWidget {
  ChannelItem({
    super.key,
    required this.channelItem,
  });

  final RxBool isShow = false.obs;
  final ChannelItemModel channelItem;

  void setIsShow() {
    isShow.value = !isShow.value;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(
      () => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFF312E2E),
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Stack(
                      children: [
                        AvatarContainer(
                          image: channelItem.channel_info.user_image,
                          replaceImage: 'assets/images/avatar-1.png',
                          radius: 48,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: SvgPicture.asset(
                              'assets/icons/tick-circle-icon.svg'),
                        )
                      ],
                    ),
                    const SizedBox(width: 12),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          channelItem.channel_info.user_fullname,
                          style: TextThemes.text14_500,
                        ),
                        Row(
                          children: [
                            textRow(
                              title: '${channelItem.total_mascots} Linh vật',
                              isFirst: true,
                            ),
                            textRow(
                              title: '${channelItem.total_exams} đề thi',
                              isLast: true,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  width: 20,
                  height: 20,
                  child: IconButton(
                    iconSize: 5,
                    splashRadius: 10,
                    padding: EdgeInsets.zero,
                    onPressed: () => setIsShow(),
                    icon: SvgPicture.asset(
                        'assets/icons/${isShow.value ? 'arrow-right' : 'arrow-right-icon'}.svg'),
                  ),
                ),
              ],
            ),
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: SizedBox(
                height: isShow.value ? null : 0,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    // const Text(
                    //   'Huy hiệu đạt được:',
                    //   style: TextStyle(
                    //     fontSize: 12,
                    //     color: Color(0xFFC1C1CD),
                    //     fontStyle: FontStyle.italic,
                    //   ),
                    // ),
                    // const SizedBox(height: 8),
                    // Row(
                    //   children: [
                    //     Image.asset('assets/images/huy-hieu-1.png'),
                    //     const SizedBox(width: 20),
                    //     Image.asset('assets/images/huy-hieu-2.png'),
                    //     const SizedBox(width: 20),
                    //     Image.asset('assets/images/huy-hieu-3.png'),
                    //   ],
                    // ),
                    // const SizedBox(height: 10),
                    const Text(
                      'Đánh giá:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFC1C1CD),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: Image.asset(
                            'assets/images/set-image.png',
                            width: 26,
                            height: 24,
                          ),
                        ),
                        // const SizedBox(width: 8),
                        Text(
                          channelItem.report_suggest,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        SizedBox(
                          width: 30,
                          child: SvgPicture.asset(
                            'assets/icons/heart-icon-2.svg',
                            width: 26,
                            height: 24,
                          ),
                        ),
                        Text(
                          channelItem.report_favourite,
                          style: const TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Đề thi nổi bật:',
                      style: TextStyle(
                        fontSize: 12,
                        color: Color(0xFFC1C1CD),
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: channelItem.highlight_exams
                            .map(
                              (item) => Container(
                                margin: const EdgeInsets.only(right: 12),
                                width: size.width * 0.45,
                                child: ExamContainerItem(
                                  exam: item.toExamItemModel(),
                                  topExam: Top.checkTopExam(item.id),
                                ),
                              ),
                            )
                            .toList(),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(
                          width: size.width * 0.4,
                          child: OutlinedButton(
                            onPressed: () => Get.toNamed(
                              Routes.channelScreen,
                              arguments: {
                                'channelInfo': channelItem.channel_info.toJson()
                              },
                            ),
                            style: OutlinedButton.styleFrom(
                              foregroundColor: ColorApp.colorOrange,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(6),
                              ),
                              side: const BorderSide(
                                width: 1,
                                color: ColorApp.colorOrange,
                              ),
                            ),
                            child: Text(
                              'Xem Kênh',
                              style: TextThemes.text14_600
                                  .copyWith(color: ColorApp.colorOrange),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget textRow({required String title, bool? isLast, bool? isFirst}) {
    return Row(
      children: [
        Text(
          (isFirst != null && isFirst) ? '$title ' : ' $title ',
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFC1C1CD),
          ),
        ),
        (isLast != null && isLast)
            ? const SizedBox()
            : SvgPicture.asset('assets/icons/dot-icon.svg'),
      ],
    );
  }
}
