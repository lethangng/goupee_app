import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';

import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/top.dart';
import '../../../../../view_models/main_view_models/main_tabs/home_tabs/favorite_list_tab/favorite_tab_view_model.dart';
import '../../../../widgets/exam_container_item.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class FavoriteTab extends StatelessWidget {
  FavoriteTab({super.key});
  final FavoriteTabViewModel _favoriteTabViewModel =
      Get.put(FavoriteTabViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_favoriteTabViewModel.examRes.value.status == Status.error) {
        showDialogError(error: _favoriteTabViewModel.examRes.value.message!);
      }

      if (_favoriteTabViewModel.examRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _favoriteTabViewModel.refreshController,
          onLoading: _favoriteTabViewModel.onLoading,
          onRefresh: _favoriteTabViewModel.onRefresh,
          widget: MasonryGridView.count(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 16,
            ),
            crossAxisCount: 2,
            crossAxisSpacing: 12,
            mainAxisSpacing: 16,
            itemCount: _favoriteTabViewModel.listData.length,
            itemBuilder: (context, index) {
              return ExamContainerItem(
                exam: _favoriteTabViewModel.listData[index],
                topExam:
                    Top.checkTopExam(_favoriteTabViewModel.listData[index].id),
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
