import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../view_models/main_view_models/main_tabs/home_tabs/channel_list_tab/channel_list_tab_view_model.dart';
import '../../../../widgets/channel_item.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class ChannelListTab extends StatelessWidget {
  ChannelListTab({super.key});

  final ChannelListTabViewModel channelTabController =
      Get.put(ChannelListTabViewModel());

  @override
  Widget build(BuildContext context) {
    // final size = MediaQuery.of(context).size;
    return Obx(() {
      if (channelTabController.examRes.value.status == Status.error) {
        showDialogError(error: channelTabController.examRes.value.message!);
      }

      if (channelTabController.examRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: channelTabController.refreshController,
          onLoading: channelTabController.onLoading,
          onRefresh: channelTabController.onRefresh,
          widget: ListView.builder(
            padding: const EdgeInsets.only(
              top: 16,
              left: 16,
              right: 16,
            ),
            itemCount: channelTabController.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return ChannelItem(
                channelItem: channelTabController.listData[index],
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
