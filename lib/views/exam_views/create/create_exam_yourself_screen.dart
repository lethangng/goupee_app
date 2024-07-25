import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../utils/color_app.dart';

class CreateExamYourselrScreen extends StatelessWidget {
  const CreateExamYourselrScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text(
          'Tự thêm đề thi',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFF353542),
            height: 1,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 60),
          Image.asset('assets/images/linh-vat-4.png'),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: RichText(
              textAlign: TextAlign.center,
              text: const TextSpan(
                text: 'Để thêm đề của bạn hãy gửi chúng đến email\n',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.w400,
                ),
                children: [
                  TextSpan(
                    text: 'goupee123@gmail.com',
                    style: TextStyle(
                      color: Color(0xFF5FBCFF),
                    ),
                  ),
                  TextSpan(
                      text:
                          '. Vì cần kiểm duyệt nên sẽ mất chút thời gian. Ngay khi đề thi được duyệt và tải lên tài khoản của bạn chúng tôi sẽ thông báo tới bạn.'),
                  TextSpan(text: '\nXin cảm ơn!'),
                ],
              ),
            ),
          ),
          const SizedBox(height: 60),
          button(
            title: 'Tải Template',
            icon: 'assets/icons/download.svg',
            backgroundColor: const Color(0xFF3F3F40),
            foregroundColor: Colors.white,
            event: () {},
          ),
          const SizedBox(height: 4),
          button(
            title: 'Xem Video Hướng Dẫn',
            icon: 'assets/icons/video-2.svg',
            backgroundColor: Colors.transparent,
            foregroundColor: const Color(0xFFFF6E47),
            event: () {},
          ),
        ],
      ),
    );
  }

  Widget button({
    required String title,
    required String icon,
    required Color backgroundColor,
    required Color foregroundColor,
    required event,
  }) {
    return TextButton(
      onPressed: event,
      style: TextButton.styleFrom(
        backgroundColor: backgroundColor,
        foregroundColor: foregroundColor,
        minimumSize: Size.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset(icon),
          const SizedBox(width: 8),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          )
        ],
      ),
    );
  }
}
