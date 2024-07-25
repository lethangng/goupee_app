import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/top.dart';
import '../../../../../view_models/main_view_models/main_tabs/home_tabs/exam_list_tab/exam_tab_view_model.dart';
import '../../../../widgets/exam_container_item.dart';

import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class ExamTab extends StatelessWidget {
  ExamTab({super.key});
  final ExamTabViewModel _examTabViewModel = Get.put(ExamTabViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_examTabViewModel.examRes.value.status == Status.error) {
        showDialogError(error: _examTabViewModel.examRes.value.message!);
      }

      if (_examTabViewModel.examRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _examTabViewModel.refreshController,
          onLoading: _examTabViewModel.onLoading,
          onRefresh: _examTabViewModel.onRefresh,
          widget: MasonryGridView.count(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            itemCount: _examTabViewModel.listData.length,
            itemBuilder: (context, index) {
              return ExamContainerItem(
                exam: _examTabViewModel.listData[index],
                topExam: Top.checkTopExam(_examTabViewModel.listData[index].id),
              );
            },
          ),
        );
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.colorOrange,
        ),
      );
    });
  }
}
