// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';

import '../../models/home_models/channel_item_model.dart';
import '../../utils/color_app.dart';
import '../../utils/convert.dart';
import '../widgets/button_primary.dart';
import 'avatar_container.dart';

class ChannelTabViewContainer extends StatelessWidget {
  const ChannelTabViewContainer({
    super.key,
    required this.title,
    required this.channelInfo,
    required this.listTab,
    required this.tabController,
    required this.tabBarView,
    this.isChild = false,
    this.isFollow = false,
    this.eventFollow,
  });

  final String title;
  final ChannelInfo channelInfo;
  final List<Tab> listTab;
  final TabController tabController;
  final List<Widget> tabBarView;
  final bool isChild;
  final bool isFollow;
  final void Function()? eventFollow;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: const Color(0xFF201E1F),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        centerTitle: true,
        scrolledUnderElevation: 0,
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        leading: isChild == true
            ? Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
                ),
              )
            : null,
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
          length: listTab.length,
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
                          image: channelInfo.user_image,
                          replaceImage: 'assets/images/avatar-2.png',
                        ),
                        const SizedBox(height: 16),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              channelInfo.title,
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
                                value: Convert.formatNumber(
                                    channelInfo.total_attempts),
                              ),
                              columnInfo(
                                title: 'Followers',
                                value: Convert.formatNumber(
                                    channelInfo.total_followers),
                              ),
                              columnInfo(
                                title: 'Thích',
                                value: Convert.formatNumber(
                                    channelInfo.total_favourites),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        isChild == true
                            ? Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonPrimary(
                                    title: isFollow ? 'Đã follow' : 'Follow',
                                    icon: isFollow
                                        ? 'assets/icons/tick.svg'
                                        : null,
                                    background: isFollow
                                        ? const Color(0xFF312E2E)
                                        : const Color(0xFFFF6E47),
                                    size: size.width * 0.5,
                                    horizontal: 24,
                                    event: eventFollow,
                                  ),
                                ],
                              )
                            : Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ButtonPrimary(
                                    title: 'Sửa hồ sơ',
                                    background: const Color(0xFF312E2E),
                                    size: null,
                                    horizontal: 24,
                                    event: () {},
                                  ),
                                  const SizedBox(width: 8),
                                  ButtonPrimary(
                                    title: 'Thêm Linh vật AI',
                                    background: const Color(0xFF312E2E),
                                    size: null,
                                    horizontal: 24,
                                    event: () {},
                                  ),
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
                    controller: tabController,
                    isScrollable: false,
                    tabs: listTab,
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
                    controller: tabController,
                    children: tabBarView,
                  ),
                ),
              ],
            ),
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
