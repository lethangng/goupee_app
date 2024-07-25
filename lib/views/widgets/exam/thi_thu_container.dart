// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question_model.dart';
import '../image_container.dart';
import 'button_thi_thu.dart';
// import 'dialog_dung_dap_an_mau.dart';

class ThiThuContainer extends StatelessWidget {
  const ThiThuContainer({
    super.key,
    required this.question,
  });

  final QuestionModel question;

  @override
  Widget build(BuildContext context) {
    String content = r"""quest""";
    content = content.replaceAll("quest", question.question);
    return Obx(
      () => Column(
        children: [
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
          ...question.images.map(
            (image) => ImageContainer(
              image: image,
              height: Get.height * 0.2,
              replaceImage: '',
            ),
          ),
          const SizedBox(height: 12),
          ...question.listAnswer.map(
            (item) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: ButtonThiThu(
                answer: item,
                answerStatus: question.status.value,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
