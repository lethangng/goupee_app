// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../../../services/response/api_status.dart';
import '../../../../../../utils/color_app.dart';
import '../../../../../../view_models/main_view_models/main_tabs/home_tabs/channel_list_tab/channel_tabs/channel_mascot_tab.dart';
import '../../../../../widgets/mascot_item_container.dart';
import '../../../../../widgets/loadmore.dart';
import '../../../../../widgets/show_dialog_error.dart';

class ChannelLinhVatTab extends StatelessWidget {
  ChannelLinhVatTab({super.key});
  final ChannelMascotTabViewModel _linhVatTabViewModel =
      Get.put(ChannelMascotTabViewModel());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (_linhVatTabViewModel.mascotRes.value.status == Status.error) {
              showDialogError(
                error: _linhVatTabViewModel.mascotRes.value.message!,
                event: _linhVatTabViewModel.handleLoad,
              );
            }

            if (_linhVatTabViewModel.mascotRes.value.status ==
                Status.completed) {
              return Loadmore(
                refreshController: _linhVatTabViewModel.refreshController,
                onLoading: _linhVatTabViewModel.onLoading,
                onRefresh: _linhVatTabViewModel.onRefresh,
                widget: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _linhVatTabViewModel.listData.length + 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index == 0) {
                      return const Padding(
                        padding: EdgeInsets.symmetric(vertical: 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Linh vật thuộc sở hữu',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MascotItemContainer(
                          linhVatItem: _linhVatTabViewModel.listData[index - 1],
                        ),
                      );
                    }
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
