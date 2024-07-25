// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_tex/flutter_tex.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/exam_view_models/create_exam_2_view_model.dart';

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

class MessageResContainer extends StatelessWidget {
  MessageResContainer({
    super.key,
    required this.questionContainer,
  });

  final QuestionContainer questionContainer;
  final CreateExam2ViewModel _createExam2ViewModel =
      Get.find<CreateExam2ViewModel>();
  // final RxList<Question> listQuestion = <Question>[].obs;

  final RxBool isEdit = false.obs;
  final RxString isSave = 'Lưu tạm'.obs;
  final TextEditingController onEditController = TextEditingController();

  void handleEdit() {
    isEdit.value = true;
  }

  void handleSave() {
    isSave.value = 'Đã lưu tạm thành công';
  }

  // void handleDeleteQuestion(int id) {
  //   listQuestion.removeWhere((q) => q.id == id);
  //   listQuestion.refresh();
  // }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    // listQuestion.addAll(questionContainer.listQuestion!);
    // listQuestion.refresh();
    // var isShowKeyboard = MediaQuery.of(context).viewInsets.bottom;
    // void handleShowKeyboard() {
    //   if (isShowKeyboard == 0) {
    //     setState(() {
    //       isEdit = false;
    //     });
    //   }
    // }
    // onEditController.text = questionContainer.sentenceSearch!.title;
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: const Color(0xFF312E2E),
            border: Border.all(
              width: 1,
              color: const Color(0xFF636363),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                questionContainer.sentenceSearch!.title,
                style: TextThemes.text15_500,
              ),
              const SizedBox(height: 8),
              Text(
                questionContainer.sentenceSearch!.description,
                style: TextThemes.text14_400.copyWith(
                  color: const Color(0xFFC1C1CD),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SvgPicture.asset('assets/icons/message-avatar.svg'),
            const SizedBox(width: 8),
            Expanded(
                child: Text(
              questionContainer.sentenceSearch!.sample_exam_title.toUpperCase(),
              style: TextThemes.text14_500,
            )
                // Obx(
                //   () => TextField(
                //     readOnly: isEdit.value,
                //     controller: onEditController,
                //     cursorColor: ColorApp.colorGrey2,
                //     style: const TextStyle(color: Colors.white),
                //     textAlignVertical: TextAlignVertical.top,
                //     textAlign: TextAlign.left,
                //     decoration: const InputDecoration(
                //       hintText: '',
                //       isDense: true,
                //       hintStyle: TextStyle(
                //         color: ColorApp.colorGrey2,
                //         // fontSize: 14,
                //         fontWeight: FontWeight.w400,
                //       ),
                //       border: InputBorder.none,
                //       contentPadding: EdgeInsets.zero,
                //     ),
                //   ),
                // ),
                ),
            // IconButton(
            //   onPressed: () => handleEdit(),
            //   style: IconButton.styleFrom(
            //     padding: EdgeInsets.zero,
            //     tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            //     minimumSize: Size.zero,
            //   ),
            //   icon: SvgPicture.asset('assets/icons/edit.svg'),
            // ),
          ],
        ),

        const SizedBox(height: 10),
        Obx(
          () => ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: _createExam2ViewModel.listQuestion.length,
            padding: EdgeInsets.zero,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.topLeft,
                      width: size.width * 0.1,
                      child: IconButton(
                        onPressed: () {
                          int id = _createExam2ViewModel.listQuestion[index].id;
                          // handleDeleteQuestion(id);
                          _createExam2ViewModel.handleDeleteQuestionId(id);
                        },
                        style: IconButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        icon: SvgPicture.asset('assets/icons/error-exam.svg'),
                      ),
                    ),
                    Expanded(
                      child: cauHoi(
                        index: index + 1,
                        question: _createExam2ViewModel.listQuestion[index],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),

        // Row(
        //   children: [
        //     SizedBox(width: size.width * 0.1),
        //     TextButton(
        //       onPressed: () => handleSave(),
        //       style: TextButton.styleFrom(
        //         padding: const EdgeInsets.all(12),
        //         backgroundColor: Colors.grey,
        //         foregroundColor: const Color(0xFFE0E0E6),
        //       ),
        //       child: Obx(
        //         () => Row(
        //           children: [
        //             SvgPicture.asset(
        //               'assets/icons/${isSave.value == 'Lưu tạm' ? 'luu-tam' : 'is-save'}.svg',
        //             ),
        //             const SizedBox(width: 8),
        //             Text(
        //               isSave.value,
        //               style: const TextStyle(
        //                 fontSize: 15,
        //               ),
        //             ),
        //           ],
        //         ),
        //       ),
        //     ),
        //   ],
        // )
      ],
    );
  }

  Widget cauHoi({
    required int index,
    required Question question,
  }) {
    String content = r"""Câu index. quest""";
    content = content.replaceAll("index", index.toString());
    content = content.replaceAll("quest", question.content);

    return TeXView(
      child: TeXViewColumn(children: [
        TeXViewDocument(
          content,
          style: TeXViewStyle(
            contentColor: Colors.white,
            fontStyle: TeXViewFontStyle(
              fontSize: 14,
              fontWeight: TeXViewFontWeight.w400,
            ),
          ),
        ),
        ...question.quest.entries.map(
          (item) {
            String quest = r"""key. value""";
            quest =
                quest.replaceAll("key", getAnswerNumber(int.parse(item.key)));
            quest = quest.replaceAll("value", item.value);
            return TeXViewDocument(
              quest,
              style: TeXViewStyle(
                contentColor: Colors.white,
                fontStyle: TeXViewFontStyle(
                  fontSize: 14,
                  fontWeight: TeXViewFontWeight.w400,
                ),
              ),
            );
          },
        ),
      ]),
    );
  }
}
