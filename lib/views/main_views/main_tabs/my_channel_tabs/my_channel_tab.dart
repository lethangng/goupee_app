// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../app/routes.dart';
import '../../../../utils/color_app.dart';
import '../../../../utils/convert.dart';
import '../../../../utils/text_themes.dart';
import '../../../../view_models/main_view_models/main_tabs/my_channel_tabs/my_channel_tab_view_model.dart';
import '../../../widgets/avatar_container.dart';
import '../../../widgets/button_primary.dart';
import 'tabs/my_channel_exam_tab.dart';
import 'tabs/my_channel_info_tab.dart';
import 'tabs/my_channel_linh_vat_tab.dart';

class MyChannelTab extends StatelessWidget {
  MyChannelTab({super.key});
  final MyChannelTabViewModel _myChannelTabViewModel =
      Get.put(MyChannelTabViewModel());

  @override
  Widget build(BuildContext context) {
    return screen();
  }

  Widget screen() {
    return Scaffold(
      backgroundColor: const Color(0xFF201E1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: const Text(
          'Kênh của tôi',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFF353542),
            height: 1,
          ),
        ),
      ),
      body: DefaultTabController(
        length: _myChannelTabViewModel.listTab.length,
        child: NestedScrollView(
          headerSliverBuilder: (context, _) {
            return [
              SliverList(
                delegate: SliverChildListDelegate([
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 13),
                      AvatarContainer(
                        radius: 80,
                        image: _myChannelTabViewModel.channelInfo.user_image,
                        replaceImage: 'assets/images/avatar-2.png',
                      ),
                      const SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _myChannelTabViewModel.channelInfo.title,
                            style: TextThemes.text14_500,
                          ),
                          SvgPicture.asset('assets/icons/tick-circle-icon.svg')
                        ],
                      ),
                      const SizedBox(height: 16),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            columnInfo(
                              title: 'Lượt thi',
                              value: Convert.formatNumber(_myChannelTabViewModel
                                  .channelInfo.total_attempts),
                            ),
                            columnInfo(
                              title: 'Followers',
                              value: Convert.formatNumber(_myChannelTabViewModel
                                  .channelInfo.total_followers),
                            ),
                            columnInfo(
                              title: 'Thích',
                              value: Convert.formatNumber(_myChannelTabViewModel
                                  .channelInfo.total_favourites),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ButtonPrimary(
                            title: 'Sửa hồ sơ',
                            background: const Color(0xFF312E2E),
                            size: null,
                            horizontal: 24,
                            event: () => Get.toNamed(Routes.taiKhoanCaNhan),
                          ),
                          // const SizedBox(width: 8),
                          // ButtonPrimary(
                          //   title: 'Thêm Linh vật AI',
                          //   background: const Color(0xFF312E2E),
                          //   size: null,
                          //   horizontal: 24,
                          //   event: () {},
                          // ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  )
                ]),
              ),
            ];
          },
          body: Column(
            children: <Widget>[
              TabBar(
                controller: _myChannelTabViewModel.tabController,
                // isScrollable: false,
                tabs: _myChannelTabViewModel.listTab,
                // physics: const NeverScrollableScrollPhysics(),
                // tabAlignment: TabAlignment.start,
                labelColor: ColorApp.colorOrange,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                labelPadding: EdgeInsets.zero,
                indicatorColor: ColorApp.colorOrange,
                unselectedLabelColor: Colors.white,
                labelStyle: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Divider(
                height: 1,
                color: Color(0xFF353542),
              ),
              Expanded(
                child: TabBarView(
                  controller: _myChannelTabViewModel.tabController,
                  children: [
                    MyLinhVatTab(),
                    MyChannelExamTab(),
                    MyChannelInfoTab(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget columnInfo({required String title, required String value}) {
    return Column(
      children: [
        Text(
          title,
          style: TextThemes.text14_600,
        ),
        Text(
          value,
          style: const TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: Colors.white,
          ),
        ),
      ],
    );
  }
}
