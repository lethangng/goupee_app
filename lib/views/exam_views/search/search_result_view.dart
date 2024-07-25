import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/exam_view_models/search/search_result_view_model.dart';
// import '../../../view_models/exam_view_models/search/search_view_view_model.dart';
import '../../widgets/show_dialog_error.dart';
import '../../widgets/exam/exam3_container_item.dart';

class SearchResultView extends StatelessWidget {
  SearchResultView({super.key});
  final SearchResultViewModel _searchResultViewModel =
      Get.put(SearchResultViewModel());
  // final SearchViewViewModel _searchViewViewModel =
  //     Get.put(SearchViewViewModel());

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (_searchResultViewModel.examRes.value.status == Status.error) {
        showDialogError(error: _searchResultViewModel.examRes.value.message!);
      }

      if (_searchResultViewModel.examRes.value.status == Status.error) {
        showDialogError(error: _searchResultViewModel.examRes.value.message!);
      }

      if (_searchResultViewModel.examRes.value.status == Status.completed &&
          _searchResultViewModel.examRes.value.status == Status.completed) {
        return screen();
      }
      return const Center(
        child: CircularProgressIndicator(
          color: ColorApp.colorOrange,
        ),
      );
    });
  }

  Widget screen() {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Row(
          children: [
            Text(
              _searchResultViewModel.searchValue,
              style: TextThemes.text15_400,
            ),
            const Spacer(),
            IconButton(
              onPressed: () {
                Get.toNamed(Routes.searchView, arguments: {
                  'searchValue': null,
                });
                // if (_searchResultViewModel.isHashtag) {
                // } else {
                //   _searchViewViewModel.handleDelete();
                // }
              },
              style: IconButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.all(5),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Container(
                width: 24,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/close-circle.svg',
                ),
              ),
            ),
            IconButton(
              // onPressed: () => _searchViewViewModel.onSearch(),
              onPressed: () => Get.toNamed(Routes.searchView, arguments: {
                'searchValue': _searchResultViewModel.searchValue,
              }),
              style: IconButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  horizontal: 5,
                  vertical: 5,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: Container(
                width: 24,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/search-icon.svg',
                ),
              ),
            ),
            const SizedBox(width: 16),
          ],
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
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Divider(
              color: Color(0xFF353542),
              height: 1,
            ),
          ),
        ),
      ),
      body: searchResult(),
    );
  }

  Widget searchResult() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          Text(
            '${_searchResultViewModel.totalResult.value} kết quả',
            style: TextThemes.text15_400,
          ),
          const SizedBox(height: 12),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResultViewModel.listData.length,
              itemBuilder: (BuildContext context, int index) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 20),
                  child: Exam3ContainerItem(
                    exam: _searchResultViewModel.listData[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
