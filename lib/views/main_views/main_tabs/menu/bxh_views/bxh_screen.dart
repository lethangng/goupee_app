import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../utils/color_app.dart';
import '../../../../../view_models/tab_view_models/channel_tabs/bxh_view_model.dart';
import 'top_channel_tab.dart';
import 'top_exam_tab.dart';

class BXHScreen extends StatelessWidget {
  BXHScreen({super.key});
  final BXHViewModel bxhViewModel = Get.put(BXHViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18191A),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: const Text(
          'Bảng xếp hạng',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Get.back(),
            icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
          ),
        ),
        // bottom: const PreferredSize(
        //   preferredSize: Size.fromHeight(1),
        //   child: Divider(
        //     color: Color(0xFF353542),
        //     height: 1,
        //   ),
        // ),
      ),
      body: Column(
        children: <Widget>[
          // const SizedBox(height: 16),
          Container(
            decoration: const BoxDecoration(
              border: Border(
                bottom: BorderSide(
                  width: 1,
                  color: Color(0xFF353542),
                ),
                top: BorderSide(
                  width: 1,
                  color: Color(0xFF353542),
                ),
              ),
            ),
            child: TabBar(
              controller: bxhViewModel.tabController,
              isScrollable: false,
              tabs: bxhViewModel.listTap,
              physics: const BouncingScrollPhysics(),
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
              controller: bxhViewModel.tabController,
              children: [
                TopChannelTab(),
                TopExamTab(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
