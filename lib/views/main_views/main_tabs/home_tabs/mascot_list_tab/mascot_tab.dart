// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../view_models/tab_view_models/home_tabs/mascot_tab_view_model.dart';
import '../../../../widgets/mascot_item_container.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class MascotTab extends StatelessWidget {
  const MascotTab({
    super.key,
    this.userId,
    this.channelId,
  });
  final int? userId;
  final int? channelId;

  @override
  Widget build(BuildContext context) {
    final MascotTabViewModel linhVatTabViewModel = Get.put(MascotTabViewModel(
      userId: userId,
      channelId: channelId,
    ));

    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (linhVatTabViewModel.mascotRes.value.status == Status.error) {
              showDialogError(
                error: linhVatTabViewModel.mascotRes.value.message!,
                event: linhVatTabViewModel.handleLoad,
              );
            }

            if (linhVatTabViewModel.mascotRes.value.status ==
                Status.completed) {
              return Loadmore(
                refreshController: linhVatTabViewModel.refreshController,
                onLoading: linhVatTabViewModel.onLoading,
                onRefresh: linhVatTabViewModel.onRefresh,
                widget: ListView.builder(
                  padding: const EdgeInsets.only(
                    left: 16,
                    right: 16,
                    top: 16,
                  ),
                  itemCount: linhVatTabViewModel.listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: MascotItemContainer(
                        linhVatItem: linhVatTabViewModel.listData[index],
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
        ),
      ],
    );
  }
}
