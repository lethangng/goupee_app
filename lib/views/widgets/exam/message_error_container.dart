// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

// import '../../../models/Exam/question.dart';
// import '../../../utils/text_themes.dart';
// import '../avatar_container.dart';

class MessageErrorContainer extends StatelessWidget {
  const MessageErrorContainer({
    super.key,
    // required this.questionContainer,
  });

  // final String image;
  // final String title;
  // final QuestionContainer questionContainer;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: 60),
        Image.asset(
          'assets/images/sad.png',
          height: size.height * 0.25,
          fit: BoxFit.cover,
        ),
        const SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              text:
                  'Không tìm thấy kết quả phù hợp với từ khóa, Vui lòng nhập lại tìm kiếm mới.  Nếu bạn có tài liệu hay về chủ đề của bạn, hãy đóng góp cho chúng tôi qua email '
                  '',
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
                // TextSpan(
                //     text:
                //         '. Vì cần kiểm duyệt nên sẽ mất chút thời gian. Ngay khi đề thi được duyệt và tải lên tài khoản của bạn chúng tôi sẽ thông báo tới bạn.'),
                // TextSpan(text: '\nXin cảm ơn!'),
              ],
            ),
          ),
        ),
        const SizedBox(height: 32),
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
