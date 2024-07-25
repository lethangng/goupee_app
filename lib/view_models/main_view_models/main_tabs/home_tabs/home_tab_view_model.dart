import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class HomeTabViewModel extends GetxController
    with GetSingleTickerProviderStateMixin {
  final RxBool showMenuBar = false.obs;
  late TabController tabController;

  final List<Tab> listTap = <Tab>[
    const Tab(text: 'Đề thi'),
    Tab(
      child: Row(
        children: [
          SvgPicture.asset('assets/icons/logo-icon.svg'),
          const SizedBox(width: 5),
          const Text('Linh vật AI'),
        ],
      ),
    ),
    const Tab(text: 'Kênh'),
    const Tab(text: 'Hashtag'),
    const Tab(text: 'Đề yêu thích'),
    const Tab(text: 'Lịch sử làm bài'),
    // const Tab(text: 'Đề thi đã xem'),
    // const Tab(text: 'Linh vật của tôi'),
  ];

  void handleShowMenuBar() {
    showMenuBar.value = !showMenuBar.value;
  }

  @override
  void onInit() {
    tabController = TabController(
      initialIndex: 0,
      length: listTap.length,
      vsync: this,
    );

    tabController.animateTo(0);
    super.onInit();
  }

  // @override
  // void onClose() {
  //   tabController.dispose();
  //   super.onClose();
  // }
}
