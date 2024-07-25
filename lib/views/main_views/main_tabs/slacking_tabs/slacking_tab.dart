import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../app/routes.dart';
import '../../../../services/response/api_status.dart';
import '../../../../utils/color_app.dart';
import '../../../../view_models/main_view_models/main_tabs/slacking_tabs/slacking_tab_view_model.dart';
import '../../../widgets/history_item.dart';
import '../../../widgets/home_container.dart';
import '../../../widgets/loadmore.dart';
import '../../../widgets/show_dialog_error.dart';

class SlackingTab extends StatelessWidget {
  SlackingTab({super.key});

  final SlackingTabViewModel _slackingTabViewModel =
      Get.put(SlackingTabViewModel());

  @override
  Widget build(BuildContext context) {
    return HomeContainer(
      widget: Obx(() {
        if (_slackingTabViewModel.examHistoryRes.value.status == Status.error) {
          showDialogError(
            error: _slackingTabViewModel.examHistoryRes.value.message!,
          );
        }

        if (_slackingTabViewModel.examHistoryRes.value.status ==
            Status.completed) {
          return _slackingTabViewModel.listData.isEmpty
              ? const Center(
                  child: Text(
                    'Danh sách đề thi chưa xong rỗng',
                    style: TextStyle(
                      color: ColorApp.colorOrange,
                    ),
                  ),
                )
              : Loadmore(
                  refreshController: _slackingTabViewModel.refreshController,
                  onLoading: _slackingTabViewModel.onLoading,
                  onRefresh: _slackingTabViewModel.onRefresh,
                  widget: ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: _slackingTabViewModel.listData.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: HistoryItem(
                          type: HistoryItemType.slacking,
                          examHistory: _slackingTabViewModel.listData[index],
                          event: () => Get.toNamed(Routes.examResult,
                              arguments: {
                                'examHistotyEdit':
                                    _slackingTabViewModel.listData[index]
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
      }),
    );
  }
}
