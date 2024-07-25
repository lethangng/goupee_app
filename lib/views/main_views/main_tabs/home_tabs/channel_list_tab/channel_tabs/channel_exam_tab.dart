import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../services/response/api_status.dart';
import '../../../../../../utils/color_app.dart';
import '../../../../../../view_models/main_view_models/main_tabs/home_tabs/channel_list_tab/channel_tabs/channel_exam_tab.dart';
import '../../../../../widgets/exam/exam2_container_item.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../../../widgets/loadmore.dart';
import '../../../../../widgets/show_dialog_error.dart';

class ChannelExamTab extends StatelessWidget {
  ChannelExamTab({super.key});

  final ChannelExamTabViewModel _channelExamTabViewModel =
      Get.put(ChannelExamTabViewModel());

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Obx(() {
      if (_channelExamTabViewModel.examRes.value.status == Status.error) {
        showDialogError(error: _channelExamTabViewModel.examRes.value.message!);
      }

      if (_channelExamTabViewModel.examRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _channelExamTabViewModel.refreshController,
          onLoading: _channelExamTabViewModel.onLoading,
          onRefresh: _channelExamTabViewModel.onRefresh,
          widget: MasonryGridView.count(
            padding: EdgeInsets.only(
              top: 5,
              bottom: size.height * 0.1,
              left: 5,
              right: 5,
            ),
            crossAxisCount: 3,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
            itemCount: _channelExamTabViewModel.listData.length,
            itemBuilder: (context, index) {
              return Exam2ContainerItem(
                exam: _channelExamTabViewModel.listData[index],
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
