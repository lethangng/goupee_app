import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../models/Exam/question_model.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/exam_view_models/thi_thu/result_screen_view_model.dart';
// import '../../widgets/comment_tree.dart';
// import '../../widgets/input_comment.dart';
import '../../widgets/exam/result_exam_container.dart';
import '../../widgets/show_dialog_error.dart';

class ResultDetailScreen extends StatelessWidget {
  ResultDetailScreen({super.key});
  final ResultScreenViewModel _resultScreenViewModel =
      Get.find<ResultScreenViewModel>();

  Color handleAnswerColor(AnswerStatus status) {
    if (status == AnswerStatus.success) {
      return const Color(0xFF2EE56B);
    } else if (status == AnswerStatus.fail) {
      return const Color(0xFFFF3434);
    } else {
      return const Color(0xFFF0EBF5);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.background,
      appBar: AppBar(
          elevation: 0,
          centerTitle: true,
          scrolledUnderElevation: 0,
          backgroundColor: Colors.transparent,
          title: Text(
            'Ôn thi',
            style: TextThemes.text18_500,
          ),
          leading: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              onPressed: () => Get.back(),
              icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
            ),
          ),
          bottom: const PreferredSize(
            preferredSize: Size.fromHeight(1),
            child: Divider(
              color: Color(0xFF353542),
              height: 1,
            ),
          )),
      body: Obx(() {
        if (_resultScreenViewModel.examHistoryAddRes.value.status ==
            Status.error) {
          showDialogError(
              error: _resultScreenViewModel.examHistoryAddRes.value.message!);
        }

        if (_resultScreenViewModel.examHistoryAddRes.value.status ==
            Status.completed) {
          return screen();
        }
        return const Center(
          child: CircularProgressIndicator(
            color: ColorApp.colorOrange,
          ),
        );
      }),
    );
  }

  Widget screen() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 12),
          Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8),
                        child: Row(
                          children: _resultScreenViewModel.listDataQuestion
                              .mapIndexed(
                                (index, item) => Obx(
                                  () => GestureDetector(
                                    onTap: () => _resultScreenViewModel
                                        .hanleOnSelect(index),
                                    child: Container(
                                      width: 40,
                                      margin: const EdgeInsets.only(right: 16),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        border: Border.all(
                                          width: 2,
                                          color: handleAnswerColor(
                                              item.status.value),
                                        ),
                                      ),
                                      child: Text(
                                        '${index + 1}',
                                        style: TextStyle(
                                          color: handleAnswerColor(
                                              item.status.value),
                                          fontSize: 24,
                                          fontWeight: FontWeight.w400,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: SvgPicture.asset('assets/icons/arrow-down-2.svg'),
                  )
                ],
              ),
              const SizedBox(height: 12),
              Container(
                color: const Color(0xFF353542),
                height: 1,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 15,
                  vertical: 12,
                ),
                child: Column(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Obx(
                        () => RichText(
                          text: TextSpan(
                            text: 'Câu: ',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                            ),
                            children: [
                              TextSpan(
                                text:
                                    '${_resultScreenViewModel.isSelect.value + 1}',
                                style: const TextStyle(
                                  color: Color(0xFFFF6E47),
                                ),
                                children: [
                                  const TextSpan(text: '/'),
                                  TextSpan(
                                    text:
                                        '${_resultScreenViewModel.listDataQuestion.length}',
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      TextButton(
                        onPressed: () {},
                        // onPressed: () => onShowComment(),
                        style: TextButton.styleFrom(
                          minimumSize: Size.zero,
                          padding: EdgeInsets.zero,
                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        ),
                        child: Row(
                          children: [
                            SvgPicture.asset('assets/icons/comment.svg'),
                            const SizedBox(width: 4),
                            // Obx(
                            //   () => Text(
                            //     '(${onThiViewModel.listDataQuestion[onThiViewModel.isSelect.value].listComment.length})',
                            //     style: TextThemes.text16_500,
                            //   ),
                            // )
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  ..._resultScreenViewModel.listDataQuestion.mapIndexed(
                    (index, item) => Obx(
                      () => Visibility(
                        visible: index == _resultScreenViewModel.isSelect.value,
                        child: ResultExamContainer(question: item),
                      ),
                    ),
                  ),
                ]),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // void onShowComment() {
  //   Get.bottomSheet(
  //     isScrollControlled: true,
  //     backgroundColor: const Color(0xFF202025),
  //     // isDismissible: true,
  //     Container(
  //       height: Get.height * 0.8,
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(16),
  //       ),
  //       child: Column(
  //         children: [
  //           SizedBox(width: Get.width),
  //           const SizedBox(height: 20),
  //           Text(
  //             '${10} bình luận',
  //             style: TextThemes.text15_500,
  //           ),
  //           const SizedBox(height: 16),
  //           Expanded(
  //             child: SingleChildScrollView(
  //               child: Obx(
  //                 () => Column(
  //                   children: _resultScreenViewModel
  //                       .listDataQuestion[_resultScreenViewModel.isSelect.value]
  //                       .listComment
  //                       .map(
  //                         (item) => Padding(
  //                           padding: const EdgeInsets.only(
  //                             bottom: 16,
  //                             left: 20.5,
  //                             right: 20.5,
  //                           ),
  //                           child: CommentTree(
  //                             id: item.id,
  //                             commentContainerData: item,
  //                             isShowAll: item.isShowAll,
  //                             eventShowAll:
  //                                 _resultScreenViewModel.handleShowAllComment,
  //                             eventPhanHoi:
  //                                 _resultScreenViewModel.handlePhanHoi,
  //                           ),
  //                         ),
  //                       )
  //                       .toList(),
  //                 ),
  //               ),
  //             ),
  //           ),
  //           Obx(
  //             () => InputComment(
  //               isPhanHoi: _resultScreenViewModel.isPhanHoi.value,
  //               event: _resultScreenViewModel.hanleHuyPhanHoi,
  //             ),
  //           ),
  //         ],
  //       ),
  //     ),
  //   );
  // }
}
