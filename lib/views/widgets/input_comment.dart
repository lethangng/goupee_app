// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../utils/text_themes.dart';

class InputComment extends StatelessWidget {
  const InputComment({
    super.key,
    required this.isPhanHoi,
    this.indexQuestion,
    this.event,
  });

  final String isPhanHoi;
  final int? indexQuestion;
  final void Function()? event;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(
          height: 1,
          color: Color(0xFF353542),
        ),
        const SizedBox(height: 16),
        Visibility(
          visible: isPhanHoi.isNotEmpty,
          maintainSize: false,
          maintainAnimation: true,
          maintainState: true,
          child: Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Đang phản hồi ',
                  style: TextThemes.text12_400.copyWith(
                    color: const Color(0xFFE0E0E6),
                  ),
                  children: [
                    TextSpan(
                      text: isPhanHoi,
                      style: TextThemes.text12_600,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Container(
                width: 3,
                height: 3,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Color(0xFFD9D9D9),
                ),
              ),
              const SizedBox(width: 8),
              TextButton(
                onPressed: event,
                style: TextButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: Text(
                  'Hủy',
                  style: TextThemes.text12_600.copyWith(
                    color: const Color(0xFFA2A2B5),
                  ),
                ),
              )
            ],
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            ClipOval(
              child: SizedBox(
                width: 44,
                height: 44,
                child: Image.asset(
                  'assets/images/avatar-1.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(25),
                  color: const Color(0xFF3F3F40),
                ),
                child: Row(
                  children: [
                    Visibility(
                      visible: indexQuestion != -1 && indexQuestion != null,
                      child: Text(
                        '#$indexQuestion',
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF83839C),
                        ),
                      ),
                    ),
                    Visibility(
                      visible: isPhanHoi.isNotEmpty,
                      // maintainSize: false,
                      // maintainAnimation: true,
                      // maintainState: true,
                      child: Text(
                        isPhanHoi,
                        style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Color(0xFF0584FE),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        constraints: BoxConstraints(
                          maxHeight: size.height * 0.2,
                        ),
                        child: SingleChildScrollView(
                          child: TextField(
                            onTapOutside: (event) =>
                                FocusManager.instance.primaryFocus?.unfocus(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.w400,
                            ),
                            maxLines: null,
                            keyboardType: TextInputType.multiline,
                            // textAlignVertical: TextAlignVertical.center,
                            // textAlign: TextAlign.left,
                            decoration: InputDecoration(
                              isDense: true, // Cho chu can giua theo chieu doc
                              hintText: isPhanHoi.isEmpty
                                  ? 'Viết bình luận...'
                                  : null,
                              hintStyle: const TextStyle(
                                color: Color(0xFFC7C9D9),
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                              ),
                              border: InputBorder.none,
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: size.width * 0.01,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {},
                      style: IconButton.styleFrom(
                        minimumSize: Size.zero,
                        padding: EdgeInsets.zero,
                        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      ),
                      icon: SvgPicture.asset('assets/icons/camera.svg'),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 8),
            IconButton(
              onPressed: () {},
              style: IconButton.styleFrom(
                minimumSize: Size.zero,
                padding: EdgeInsets.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: SvgPicture.asset('assets/icons/send-2.svg'),
            ),
          ],
        ),
      ],
    );
  }
}
