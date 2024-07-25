// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

import '../../../models/Exam/answer_model.dart';
import '../../../models/Exam/question_model.dart';
import '../../../utils/text_themes.dart';

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

class ButtonResult extends StatelessWidget {
  const ButtonResult({
    super.key,
    required this.answer,
    required this.answerStatus,
  });

  final AnswerModel answer;
  final AnswerStatus answerStatus;

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
      onTap: () {},
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
