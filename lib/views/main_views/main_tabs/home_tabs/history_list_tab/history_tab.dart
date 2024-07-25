import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../app/routes.dart';
import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../view_models/main_view_models/main_tabs/home_tabs/history_list_tab/history_tab_view_model.dart';
import '../../../../widgets/history_item.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class HistoryTab extends StatelessWidget {
  HistoryTab({super.key});

  final HistoryTabViewModel _historyTabViewModel =
      Get.put(HistoryTabViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_historyTabViewModel.examHistoryRes.value.status == Status.error) {
        showDialogError(
          error: _historyTabViewModel.examHistoryRes.value.message!,
        );
      }

      if (_historyTabViewModel.examHistoryRes.value.status ==
          Status.completed) {
        return Loadmore(
          refreshController: _historyTabViewModel.refreshController,
          onLoading: _historyTabViewModel.onLoading,
          onRefresh: _historyTabViewModel.onRefresh,
          widget: ListView.builder(
            padding: const EdgeInsets.all(20),
            itemCount: _historyTabViewModel.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: HistoryItem(
                  type: HistoryItemType.history,
                  examHistory: _historyTabViewModel.listData[index],
                  event: () => Get.toNamed(Routes.examResult, arguments: {
                    'examHistotyEdit': _historyTabViewModel.listData[index]
                  }),
                ),
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
