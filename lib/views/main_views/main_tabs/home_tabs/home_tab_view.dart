import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../utils/color_app.dart';
import '../../../../view_models/controllers/user_controller.dart';
import '../../../../view_models/main_view_models/main_tabs/home_tabs/home_tab_view_model.dart';
import '../../../widgets/home_container.dart';
import '../../../widgets/login_empty.dart';
import 'exam_list_tab/exam_tab.dart';
import 'favorite_list_tab/favorite_tab.dart';
import 'hastag_list_tab/hashtag_tab.dart';
import 'history_list_tab/history_tab.dart';
import 'mascot_list_tab/mascot_tab.dart';
import 'channel_list_tab/channel_list_tab.dart';

class HomeTabView extends StatelessWidget {
  HomeTabView({super.key});
  final HomeTabViewModel _homeTabViewModel = Get.put(HomeTabViewModel());
  final UserController _userController = Get.find<UserController>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return HomeContainer(
      widget: Column(
        children: [
          SizedBox(
            height: size.height * 0.015,
          ),
          Container(
            color: const Color(0xFF27211F),
            child: TabBar(
              tabAlignment: TabAlignment.start,
              controller: _homeTabViewModel.tabController,
              isScrollable: true,
              tabs: _homeTabViewModel.listTap,
              physics: const BouncingScrollPhysics(),
              labelColor: ColorApp.colorOrange,
              dividerColor: Colors.transparent,
              indicatorSize: TabBarIndicatorSize.tab,
              indicatorColor: ColorApp.colorOrange,
              unselectedLabelColor: Colors.white,
              // labelPadding: const EdgeInsets.symmetric(
              //   horizontal: 20,
              //   vertical: 12,
              // ),
              labelStyle: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
              // labelPadding: EdgeInsets.zero,
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _homeTabViewModel.tabController,
              children: [
                ExamTab(),
                const MascotTab(),
                ChannelListTab(),
                HashtagTab(),
                _userController.userRes.value.data?.is_login != null
                    ? FavoriteTab()
                    : const LoginEmpty(),
                _userController.userRes.value.data?.is_login != null
                    ? HistoryTab()
                    : const LoginEmpty(),
                // HistoryTab(),
                // ExamTab(),
                // const HistoryTab(),
                // const HistoryTab(),
              ],
            ),
          ),
          const SizedBox(height: 55),
        ],
      ),
    );
  }
}
