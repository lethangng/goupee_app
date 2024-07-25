// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question.dart';
import '../button_primary.dart';

String getAnswerNumber(int index) {
  index = index + 64;
  if (index < 65) index = 65;
  if (index > 90) {
    int prefix = ((index - 65) / 26).floor();
    int suffix = index - 64 - prefix * 26;
    return getAnswerNumber(prefix) + getAnswerNumber(suffix);
  } else {
    return String.fromCharCode(index);
  }
}

class ContentExam extends StatelessWidget {
  const ContentExam({
    super.key,
    required this.question,
    this.isEdit = false,
    this.eventDelete,
    this.eventDeleteEmpty,
    this.isListEmpty,
  });
  final Question question;
  final bool isEdit;
  final void Function()? eventDelete;
  final void Function()? eventDeleteEmpty;
  final bool? isListEmpty;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    String content = r"""quest""";
    content = content.replaceAll("quest", question.content);

    return Column(
      children: [
        // const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xFF636363),
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              Row(
                // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 6,
                      vertical: 2,
                    ),
                    decoration: BoxDecoration(
                      color: const Color(0xFF4E4E61),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Text(
                      'Đề bài',
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Visibility(
                    visible: isEdit,
                    child: Row(
                      children: [
                        IconButton(
                          onPressed: () async {
                            if (isListEmpty != null && isListEmpty!) {
                              await handleShowListEmpty();
                            } else {
                              await handleShow();
                            }
                          },
                          style: IconButton.styleFrom(
                            minimumSize: Size.zero,
                            padding: EdgeInsets.zero,
                            tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                          ),
                          icon:
                              SvgPicture.asset('assets/icons/delete-icon.svg'),
                        ),
                        const SizedBox(width: 16),
                        SvgPicture.asset('assets/icons/edit.svg'),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              TeXView(
                child: TeXViewDocument(
                  content,
                  style: TeXViewStyle(
                    contentColor: Colors.white,
                    fontStyle: TeXViewFontStyle(
                      fontSize: 16,
                      fontWeight: TeXViewFontWeight.w400,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              ...question.quest.entries.map(
                (item) {
                  String quest = r"""value""";
                  quest = quest.replaceAll("value", item.value);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: button2(
                      title: '${getAnswerNumber(int.parse(item.key))}. ',
                      value: quest,
                      color: const Color(0xFFF0EBF5),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(12),
          width: size.width * 0.9,
          decoration: BoxDecoration(
            border: Border.all(
              width: 1,
              color: const Color(0xFF636363),
            ),
            borderRadius: BorderRadius.circular(12),
            // color: const Color(0xFF3d3635),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFFFFFFF),
                      Color(0xFFFFCAAD),
                      Color(0xFFFF7955),
                    ],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: const Text(
                  'Đáp án mẫu',
                  style: TextStyle(
                    color: Color(0xFF0E0E12),
                    fontSize: 13,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  ...question.quest.entries.map(
                    (item) {
                      String quest = r"""value""";
                      quest = quest.replaceAll("value", item.value);
                      return button3(
                        title: getAnswerNumber(int.parse(item.key)),
                        color: const Color(0xFFF0EBF5),
                        backgroundColor: item.key == question.right_answer
                            ? const Color(0xFF3EC65C)
                            : null,
                      );
                    },
                  ),
                ],
              ),
            ],
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  Future<void> handleShow() async {
    return await Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/close.svg',
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/icons/linh-vat-slacking.svg'),
                      const SizedBox(height: 12),
                      const Text(
                        'Bạn chắc chắn muốn xóa câu hỏi này chứ?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0E0E6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Hủy',
                              background: const Color(0xFF312E2E),
                              event: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Xóa',
                              event: eventDelete,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Future<void> handleShowListEmpty() async {
    return await Get.dialog(
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(Radius.circular(20)),
              ),
              child: Material(
                color: Colors.transparent,
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            onPressed: () => Get.back(),
                            style: IconButton.styleFrom(
                              minimumSize: Size.zero,
                              padding: EdgeInsets.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset(
                              'assets/icons/close.svg',
                            ),
                          ),
                        ],
                      ),
                      SvgPicture.asset('assets/icons/linh-vat-slacking.svg'),
                      const SizedBox(height: 12),
                      const Text(
                        'Xóa hết câu hỏi sẽ kèm theo xóa luôn đề thi này. Bạn có muốn xóa không?',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                          color: Color(0xFFE0E0E6),
                        ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Hủy',
                              background: const Color(0xFF312E2E),
                              event: () => Get.back(),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: ButtonPrimary(
                              title: 'Xóa',
                              event: eventDeleteEmpty,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      barrierDismissible: false,
    );
  }

  Widget button3({
    required String title,
    required Color color,
    Color? backgroundColor,
  }) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: OutlinedButton(
        onPressed: () {},
        style: OutlinedButton.styleFrom(
          foregroundColor: color,
          backgroundColor: backgroundColor,
          shape: const CircleBorder(),
          side: BorderSide(
            color: backgroundColor ?? color,
            width: 1.5,
          ),
          padding: const EdgeInsets.all(16),
          minimumSize: Size.zero,
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }

  Widget button2({
    required String title,
    required String value,
    required Color color,
  }) {
    return OutlinedButton(
      onPressed: () {},
      style: OutlinedButton.styleFrom(
        foregroundColor: color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        side: BorderSide(
          color: color,
          width: 1.5,
        ),
        padding: const EdgeInsets.only(left: 16),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            title,
            style: TextStyle(
              color: const Color(0xFFF1E5FF).withOpacity(0.4),
              fontSize: 20,
              fontWeight: FontWeight.w400,
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(top: 4),
              child: TeXView(
                child: TeXViewDocument(
                  value,
                  style: TeXViewStyle(
                    contentColor: Colors.white,
                    fontStyle: TeXViewFontStyle(
                      fontSize: 20,
                      fontWeight: TeXViewFontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget button({
    required String title,
    required Color color,
    required String icon,
    required event,
    bool? typeImageSvg,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              backgroundColor: color,
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(6),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                (typeImageSvg == null || typeImageSvg)
                    ? SvgPicture.asset(icon)
                    : Image.asset(icon),
                const SizedBox(width: 8),
                Text(
                  title,
                  style: const TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
