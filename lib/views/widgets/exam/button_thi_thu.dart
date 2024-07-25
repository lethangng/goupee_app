// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../../../models/Exam/answer_model.dart';
import '../../../models/Exam/question_model.dart';
import '../../../view_models/tab_view_models/channel_tabs/thi_thu_view_model.dart';

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

class ButtonThiThu extends StatelessWidget {
  ButtonThiThu({
    super.key,
    required this.answer,
    required this.answerStatus,
  });

  final AnswerModel answer;
  final AnswerStatus answerStatus;
  final ThiThuViewModel _lamDeViewModel = Get.find<ThiThuViewModel>();

  Color handleBackgroundColor({
    required AnswerStatus status,
    required bool isSelect,
  }) {
    if (status == AnswerStatus.isNull) {
      return isSelect ? const Color(0xFF007AFF) : Colors.transparent;
    } else {
      if (isSelect) {
        return const Color(0xFF007AFF);
      } else {
        return Colors.transparent;
      }
    }
  }

  Color handleColorTitle({
    required AnswerStatus status,
    required bool isSelect,
  }) {
    if (status == AnswerStatus.isNull) {
      return isSelect ? Colors.white : const Color(0xFF6e6770);
    } else {
      if (isSelect) {
        return Colors.white;
      } else {
        return const Color(0xFF6e6770);
      }
    }
  }

  Color handleColorBorder({
    required AnswerStatus status,
    required bool isSelect,
  }) {
    if (status == AnswerStatus.isNull) {
      return isSelect ? Colors.transparent : Colors.white;
    } else {
      if (isSelect) {
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
      onTap:
          // answerStatus == AnswerStatus.isNull
          //     ? () {
          //         _lamDeViewModel.handleSelectAnswer(answer.id);
          //         // _lamDeViewModel.hanleSubmitAnswer(answer.isTrue);
          //       }
          //     : null
          () => _lamDeViewModel.handleSelectAnswer(answer.id),
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
                ),
              ),
              color: handleBackgroundColor(
                status: answerStatus,
                isSelect: answer.isSelect,
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
