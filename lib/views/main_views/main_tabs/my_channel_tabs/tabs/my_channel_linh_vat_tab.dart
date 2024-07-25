// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../view_models/main_view_models/main_tabs/my_channel_tabs/tabs/my_linh_vat_tab.dart';
import '../../../../widgets/mascot_item_container.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class MyLinhVatTab extends StatelessWidget {
  MyLinhVatTab({super.key});

  final MyLinhVatTabViewModel _myLinhVatTab = Get.put(MyLinhVatTabViewModel());

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Obx(() {
            if (_myLinhVatTab.linhVatRes.value.status == Status.error) {
              showDialogError(
                error: _myLinhVatTab.linhVatRes.value.message!,
                event: _myLinhVatTab.handleLoad,
              );
            }

            if (_myLinhVatTab.linhVatRes.value.status == Status.completed) {
              return Loadmore(
                refreshController: _myLinhVatTab.refreshController,
                onLoading: _myLinhVatTab.onLoading,
                onRefresh: _myLinhVatTab.onRefresh,
                widget: ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  itemCount: _myLinhVatTab.listData.length + 1,
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
                            // Container(
                            //   decoration: BoxDecoration(
                            //     color: const Color(0xFF201E1F),
                            //     gradient: LinearGradient(
                            //       colors: [
                            //         const Color(0xFFFF9055).withOpacity(0.15),
                            //         const Color(0xFF000000).withOpacity(0),
                            //         const Color(0xFF3371DB).withOpacity(0.15),
                            //       ],
                            //       begin: Alignment.topLeft,
                            //       end: Alignment.bottomRight,
                            //     ),
                            //     borderRadius: BorderRadius.circular(18),
                            //   ),
                            //   child: Visibility(
                            //     visible: true,
                            //     child: TextButton(
                            //       onPressed: () {
                            //         //
                            //       },
                            //       style: TextButton.styleFrom(
                            //         padding: const EdgeInsets.symmetric(
                            //           horizontal: 12,
                            //           vertical: 8,
                            //         ),
                            //         minimumSize: Size.zero,
                            //         tapTargetSize:
                            //             MaterialTapTargetSize.shrinkWrap,
                            //       ),
                            //       child: Row(
                            //         children: [
                            //           const Text(
                            //             'Thêm mới',
                            //             style: TextStyle(
                            //                 fontWeight: FontWeight.w400,
                            //                 color: Colors.white),
                            //           ),
                            //           const SizedBox(width: 8),
                            //           SvgPicture.asset('assets/icons/add.svg'),
                            //         ],
                            //       ),
                            //     ),
                            //   ),
                            // ),
                          ],
                        ),
                      );
                    } else {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 20),
                        child: MascotItemContainer(
                          linhVatItem: _myLinhVatTab.listData[index - 1],
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
