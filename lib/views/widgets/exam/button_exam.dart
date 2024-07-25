// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../../../models/Exam/answer_model.dart';
import '../../../models/Exam/question_model.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/tab_view_models/channel_tabs/on_thi_view_model.dart';

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

class ButtonExam extends StatelessWidget {
  ButtonExam({
    super.key,
    required this.answer,
    required this.answerStatus,
  });

  final AnswerModel answer;
  final AnswerStatus answerStatus;
  final OnThiViewModel _onThiViewModel = Get.find<OnThiViewModel>();

  void handleSelect(int id) {
    _onThiViewModel.handleSelectAnswer(answer.id);
    Get.dialog(
      barrierDismissible: false,
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Container(
              decoration: const BoxDecoration(
                color: Color(0xFF202025),
                borderRadius: BorderRadius.all(
                  Radius.circular(20),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Material(
                  color: Colors.transparent,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
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
                      const SizedBox(height: 16),
                      Text(
                        'Bạn chọn đáp án ${answer.title}.',
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Ấn “Đồng ý” để xem kiểm tra đáp án.',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 20),
                      Row(
                        children: [
                          button(
                            title: 'Chọn lại',
                            background: const Color(0xFF312E2E),
                            event: () => Get.back(),
                          ),
                          const SizedBox(width: 16),
                          button(
                              title: 'Đồng ý',
                              background: const Color(0xFFFF6E47),
                              event: () {
                                _onThiViewModel
                                    .hanleSubmitAnswer(answer.isTrue);
                                Get.back();
                              }),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget button({
    required String title,
    required Color background,
    void Function()? event,
  }) {
    return Expanded(
      child: FilledButton(
        onPressed: event,
        style: FilledButton.styleFrom(
          backgroundColor: background,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(6),
          ),
          minimumSize: Size.zero,
          padding: const EdgeInsets.symmetric(
            vertical: 10,
          ),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        child: Text(
          title,
          style: TextThemes.text14_600,
        ),
      ),
    );
  }

  Color handleBackgroundColor({
    required AnswerStatus status,
    required bool isSelect,
    required bool isTrue,
  }) {
    if (status == AnswerStatus.isNull) {
      return isSelect ? const Color(0xFF007AFF) : Colors.transparent;
    } else {
      if (isSelect && isTrue) {
        return const Color(0xFF3EC65C);
      } else if (isTrue) {
        return const Color(0xFF3EC65C);
      } else if (isTrue == false && isSelect) {
        return const Color(0xFFFF3434);
      } else {
        return Colors.transparent;
      }
    }
  }

  Color handleColorTitle({
    required AnswerStatus status,
    required bool isSelect,
    required bool isTrue,
  }) {
    if (status == AnswerStatus.isNull) {
      return isSelect ? Colors.white : const Color(0xFF6e6770);
    } else {
      if (isTrue || isSelect) {
        return Colors.white;
      } else {
        return const Color(0xFF6e6770);
      }
    }
  }

  Color handleColorBorder({
    required AnswerStatus status,
    required bool isSelect,
    required bool isTrue,
  }) {
    if (status == AnswerStatus.isNull) {
      return isSelect ? Colors.transparent : Colors.white;
    } else {
      if (isTrue || isSelect) {
        return Colors.transparent;
      } else {
        return Colors.white;
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    String quest = r"""value""";
    quest = quest.replaceAll("value", answer.value);
    return GestureDetector(
      onTap: answerStatus == AnswerStatus.isNull
          ? () => handleSelect(answer.id)
          : null,
      child: Stack(
        children: [
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: handleColorBorder(
                  status: answerStatus,
                  isSelect: answer.isSelect,
                  isTrue: answer.isTrue,
                ),
              ),
              color: handleBackgroundColor(
                status: answerStatus,
                isSelect: answer.isSelect,
                isTrue: answer.isTrue,
              ),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  '${getAnswerNumber(int.parse(answer.title))}. ',
                  style: TextStyle(
                    color: handleColorTitle(
                      status: answerStatus,
                      isSelect: answer.isSelect,
                      isTrue: answer.isTrue,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 4),
                    child: TeXView(
                      child: TeXViewDocument(
                        quest,
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
          ),
          Positioned.fill(
            child: Container(
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }
}

// Row(
//                 children: [
//                   ...question.quest.entries.map(
//                     (item) {
//                       String quest = r"""value""";
//                       quest = quest.replaceAll("value", item.value);
//                       return button3(
//                         title: getAnswerNumber(int.parse(item.key)),
//                         color: const Color(0xFFF0EBF5),
//                         backgroundColor: item.key == question.right_answer
//                             ? const Color(0xFF3EC65C)
//                             : null,
//                       );
//                     },
//                   ),
//                 ],
//               ),
