// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/convert.dart';
import '../../../../../utils/text_themes.dart';
import '../../../../../view_models/main_view_models/main_tabs/home_tabs/channel_list_tab/channel_view_model.dart';
import '../../../../widgets/avatar_container.dart';
import '../../../../widgets/button_primary.dart';
import '../../../../widgets/show_dialog_error.dart';
import 'channel_tabs/channel_exam_tab.dart';
import 'channel_tabs/channel_info_tab.dart';
import 'channel_tabs/channel_linh_vat_tab.dart';

class ChannelScreen extends StatelessWidget {
  ChannelScreen({super.key});
  final ChannelViewModel _channelViewModel = Get.put(ChannelViewModel());

  final List<Tab> _listTab = <Tab>[
    Tab(
      child: Row(
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
  Widget build(BuildContext context) {
    // return Obx(() {
    //   if (channelViewModel.followRes.value.status == Status.error) {
    //     showDialogError(error: channelViewModel.followRes.value.message!);
    //   }

    //   if (channelViewModel.followRes.value.status == Status.completed) {
    //     return screen();
    //   }
    //   return const Center(
    //     child: CircularProgressIndicator(
    //       color: ColorApp.colorOrange,
    //     ),
    //   );
    // });
    return screen();
  }

  Widget screen() {
    return Scaffold(
      backgroundColor: const Color(0xFF201E1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          _channelViewModel.channelInfo.user_fullname,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
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
      body: Container(
        width: double.infinity,
        decoration: const BoxDecoration(
            // gradient: LinearGradient(
            //   colors: [
            //     const Color(0xFFFF9055).withOpacity(0.15),
            //     const Color(0xFF000000).withOpacity(0),
            //     const Color(0xFF3371DB).withOpacity(0.15),
            //   ],
            //   begin: Alignment.topLeft,
            //   end: Alignment.bottomRight,
            // ),
            ),
        child: DefaultTabController(
          length: _listTab.length,
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
                          image: _channelViewModel.channelInfo.user_image,
                          replaceImage: 'assets/images/avatar-2.png',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _channelViewModel.channelInfo.title,
                              style: const TextStyle(color: Colors.white),
                            ),
                            SvgPicture.asset(
                                'assets/icons/tick-circle-icon.svg')
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
                                value: Convert.formatNumber(_channelViewModel
                                    .channelInfo.total_attempts),
                              ),
                              columnInfo(
                                title: 'Followers',
                                value: Convert.formatNumber(_channelViewModel
                                    .channelInfo.total_followers),
                              ),
                              columnInfo(
                                title: 'Thích',
                                value: Convert.formatNumber(_channelViewModel
                                    .channelInfo.total_favourites),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Obx(() {
                              if (_channelViewModel.followRes.value.status ==
                                  Status.error) {
                                showDialogError(
                                  error: _channelViewModel
                                      .followRes.value.message!,
                                );
                              }

                              if (_channelViewModel.followRes.value.status ==
                                  Status.loading) {
                                return const CircularProgressIndicator(
                                  color: ColorApp.colorOrange,
                                );
                              }

                              return ButtonPrimary(
                                title: _channelViewModel.isFollow.value
                                    ? 'Đã follow'
                                    : 'Follow',
                                icon: _channelViewModel.isFollow.value
                                    ? 'assets/icons/tick.svg'
                                    : null,
                                background: _channelViewModel.isFollow.value
                                    ? const Color(0xFF312E2E)
                                    : const Color(0xFFFF6E47),
                                size: Get.width * 0.5,
                                horizontal: 24,
                                event: () => _channelViewModel.handleFollow(),
                              );
                            }),
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
                Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        width: 1,
                        color: Color(0xFF353542),
                      ),
                    ),
                  ),
                  child: TabBar(
                    controller: _channelViewModel.tabController,
                    isScrollable: false,
                    tabs: _listTab,
                    physics: const NeverScrollableScrollPhysics(),
                    labelColor: ColorApp.colorOrange,
                    dividerColor: Colors.transparent,
                    indicatorSize: TabBarIndicatorSize.tab,
                    indicatorColor: ColorApp.colorOrange,
                    unselectedLabelColor: Colors.white,
                    labelStyle: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Expanded(
                  child: TabBarView(
                    controller: _channelViewModel.tabController,
                    children: [
                      ChannelLinhVatTab(),
                      ChannelExamTab(),
                      ChannelInfoTab(),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget columnInfo({
    required String title,
    required String value,
  }) {
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
