import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../../../app/routes.dart';
import '../../../../../models/home_models/hashtag.dart';
import '../../../../../services/response/api_status.dart';
import '../../../../../utils/color_app.dart';
import '../../../../../utils/text_themes.dart';
// import '../../../../../view_models/exam_view_models/search/search_view_view_model.dart';
import '../../../../../view_models/main_view_models/main_tabs/home_tabs/hashtag_list_tab/hashtag_tab_view_model.dart';
import '../../../../widgets/loadmore.dart';
import '../../../../widgets/show_dialog_error.dart';

class HashtagTab extends StatelessWidget {
  HashtagTab({super.key});
  final HashtagTabViewModel _hashtagTabViewModel =
      Get.put(HashtagTabViewModel());
  // final SearchViewViewModel _searchViewViewModel =
  //     Get.put(SearchViewViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_hashtagTabViewModel.hashtagRes.value.status == Status.error) {
        showDialogError(error: _hashtagTabViewModel.hashtagRes.value.message!);
      }

      if (_hashtagTabViewModel.hashtagRes.value.status == Status.completed) {
        return Loadmore(
          refreshController: _hashtagTabViewModel.refreshController,
          onLoading: _hashtagTabViewModel.onLoading,
          onRefresh: _hashtagTabViewModel.onRefresh,
          widget: ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: _hashtagTabViewModel.listData.length,
            itemBuilder: (BuildContext context, int index) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: rowContainer(
                  index: index + 1,
                  hashtagModel: _hashtagTabViewModel.listData[index],
                  isFirst: index == 0,
                ),
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

  Widget rowContainer({
    required int index,
    required bool isFirst,
    required Hashtag hashtagModel,
  }) {
    return GestureDetector(
      // onTap: () => _searchViewViewModel.handleOnPressSearch(hashtagModel.title),
      onTap: () => Get.toNamed(Routes.resultSearch, arguments: {
        'searchValue': hashtagModel.title,
        'isHashtag': true,
      }),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              SizedBox(
                width: Get.width * 0.1,
                child: Text(
                  index.toString(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                  ),
                ),
              ),
              Text(
                hashtagModel.title,
                style: TextThemes.text15_400,
              ),
              const SizedBox(
                width: 4,
              ),
              SvgPicture.asset(
                  'assets/icons/${isFirst ? 'lighting.svg' : 'fire.svg'}'),
            ],
          ),
          Text(
            '${hashtagModel.total_linked_exams}',
            style: const TextStyle(
                color: Color(0xFFC1C1CD),
                fontSize: 13,
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
