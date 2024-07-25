import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/Exam/question_model.dart';
import '../../../utils/color_app.dart';
import '../../../view_models/exam_view_models/thi_thu/result_screen_view_model.dart';

class ResultScreen extends StatelessWidget {
  ResultScreen({super.key});

  final ResultScreenViewModel _resultScreenViewModel =
      Get.find<ResultScreenViewModel>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Kết quả đề thi tín dụng Vietcombank',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
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
        ),
      ),
      body: Container(
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     Color.fromARGB(20, 255, 144, 85),
            //     Color.fromARGB(20, 51, 113, 219),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            ),
        child: Column(
          children: [
            Expanded(
              child: MasonryGridView.count(
                padding: const EdgeInsets.all(16),
                crossAxisCount: 6,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20,
                itemCount: _resultScreenViewModel.listDataQuestion.length,
                itemBuilder: (context, index) {
                  return indexContainer(
                    index: (index + 1),
                    isTrue: _resultScreenViewModel
                            .listDataQuestion[index].status.value ==
                        AnswerStatus.success,
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget indexContainer({required int index, required bool isTrue}) {
    return GestureDetector(
      onTap: () => Get.toNamed(
        Routes.resultDetail,
        arguments: {'quesion_id': index - 1},
      ),
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            width: 1,
            color: isTrue ? const Color(0xFF2EE56B) : const Color(0xFFFF3434),
          ),
        ),
        alignment: Alignment.center,
        child: Text(
          index.toString(),
          style: TextStyle(
            color: isTrue ? const Color(0xFF2EE56B) : const Color(0xFFFF3434),
            fontSize: 20,
          ),
        ),
      ),
    );
  }
}
