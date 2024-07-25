import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../models/home_models/channel_item_model.dart';
import '../../../../models/table/user.dart';
import '../../../controllers/user_controller.dart';

class MyChannelTabViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  late TabController tabController;
  late ChannelInfo channelInfo;

  final List<Tab> listTab = <Tab>[
    Tab(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset('assets/icons/logo-icon.svg'),
          const SizedBox(width: 5),
          const Text('Linh vật AI'),
        ],
      ),
    ),
    const Tab(text: 'Đề thi'),
    const Tab(text: 'Giới thiệu'),
  ];

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: listTab.length,
      vsync: this,
    );

    final User userInfo = Get.find<UserController>().userRes.value.data!;
    channelInfo = ChannelInfo(
      id: 0,
      user_id: userInfo.id,
      user_fullname: userInfo.fullname,
      title: userInfo.channel_title!,
      total_followers: userInfo.total_followers!,
      total_favourites: userInfo.total_favourites!,
      total_attempts: userInfo.total_attempts!,
    );
    super.onInit();
  }

  // @override
  // void onClose() {
  //   tabController.dispose();
  //   super.onClose();
  // }
}
