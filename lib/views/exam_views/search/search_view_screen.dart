import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/Exam/search_history.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/exam_view_models/search/search_view_view_model.dart';

class SearchViewScreen extends StatelessWidget {
  SearchViewScreen({super.key});

  final SearchViewViewModel _searchViewViewModel =
      Get.put(SearchViewViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        elevation: 0,
        titleSpacing: 0,
        backgroundColor: Colors.transparent,
        title: Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: const Color(0xFF312E2E),
            borderRadius: BorderRadius.circular(57),
          ),
          child: TextField(
            controller: _searchViewViewModel.textSearchController,
            onTapOutside: (event) =>
                FocusManager.instance.primaryFocus?.unfocus(),
            focusNode: _searchViewViewModel.focus,
            cursorColor: const Color(0xFFFFA699),
            style: const TextStyle(color: Colors.white),
            textAlignVertical: TextAlignVertical.center,
            textAlign: TextAlign.left,
            decoration: InputDecoration(
              isDense: true, // Cho chu can giua theo chieu doc
              hintText: 'Tìm kiếm',
              hintStyle:
                  TextThemes.text15_400.copyWith(color: ColorApp.colorGrey2),
              border: InputBorder.none,
              prefixIcon: Container(
                width: 24,
                alignment: Alignment.center,
                child: SvgPicture.asset(
                  'assets/icons/search-icon.svg',
                ),
              ),
            ),
            onSubmitted: (_) async {
              if (_searchViewViewModel.textSearchController.text.isNotEmpty) {
                await _searchViewViewModel.insert();
                Get.toNamed(Routes.resultSearch, arguments: {
                  'searchValue': _searchViewViewModel.textSearchController.text,
                });
              }
            },
          ),
        ),
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () {
              Get.back();
            },
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
      body: SingleChildScrollView(
        physics: const ScrollPhysics(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              const Text(
                'Gần đây',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 12),
              Obx(
                () => Wrap(
                  crossAxisAlignment: WrapCrossAlignment.start,
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    ..._searchViewViewModel.listSearchHistory
                        .map((item) => chip(item)),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(bottom: 12),
                child: Text(
                  'Các tìm kiếm phổ biến',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              ListView.builder(
                itemCount: _searchViewViewModel.listData.length,
                physics: const NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return TextButton(
                    onPressed: () => _searchViewViewModel.handleOnPressSearch(
                        _searchViewViewModel.listData[index]),
                    style: TextButton.styleFrom(
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                      alignment: Alignment.centerLeft,
                    ),
                    child: Text(
                      _searchViewViewModel.listData[index],
                      style: TextThemes.text15_400,
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget chip(SearchHistory searchHistory) {
    return GestureDetector(
      onTap: () => Get.toNamed(Routes.resultSearch, arguments: {
        'searchValue': searchHistory.content,
      }),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(33),
          color: const Color(0xFFC4C4C4).withOpacity(0.1),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              searchHistory.content,
              style: TextThemes.text15_400,
            ),
            const SizedBox(width: 5),
            IconButton(
              onPressed: () => _searchViewViewModel.delete(searchHistory.id!),
              style: IconButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              icon: SvgPicture.asset('assets/icons/close-2.svg'),
            ),
          ],
        ),
      ),
    );
  }
}
