import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/top.dart';
import '../../../../../view_models/main_view_models/main_tabs/my_channel_tabs/tabs/my_exam_tab.dart';
import '../../../../widgets/exam/exam2_container_item.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class MyChannelExamTab extends StatelessWidget {
  MyChannelExamTab({super.key});
  final MyExamTab _myExamTab = Get.put(MyExamTab());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_myExamTab.examRes.value.status == Status.error) {
        showDialogError(error: _myExamTab.examRes.value.message!);
      }

      if (_myExamTab.examRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _myExamTab.refreshController,
          onLoading: _myExamTab.onLoading,
          onRefresh: _myExamTab.onRefresh,
          widget: MasonryGridView.count(
            padding: const EdgeInsets.all(5),
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            itemCount: _myExamTab.listData.length,
            itemBuilder: (context, index) {
              return Exam2ContainerItem(
                exam: _myExamTab.listData[index],
                topExam: Top.checkTopExam(_myExamTab.listData[index].id),
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
