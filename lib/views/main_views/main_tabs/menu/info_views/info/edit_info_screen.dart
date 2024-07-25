// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goup_app/utils/text_themes.dart';

import '../../../../../../utils/color_app.dart';
import '../../../../../../view_models/main_view_models/main_tabs/menu/info_views/info/edit_info_view_model.dart';
import '../../../../../widgets/button_primary.dart';

class EditInfoScreen extends StatelessWidget {
  EditInfoScreen({super.key});

  final EditInfoViewModel _editInfoViewModel = Get.put(EditInfoViewModel());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18191A),
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Chỉnh sửa ${_editInfoViewModel.title}',
          style: const TextStyle(
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
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(1),
          child: Divider(
            color: Color(0xFF353542),
            height: 1,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 21),
            Text(
              _editInfoViewModel.title,
              style: TextThemes.text14_500.copyWith(
                color: const Color(0xFFC1C1CD),
              ),
            ),
            TextField(
              cursorColor: const Color(0xFFFFA699),
              controller: _editInfoViewModel.textEditControllerValue,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                hintText: 'Nhập ${_editInfoViewModel.title}',
                hintStyle: const TextStyle(
                  color: ColorApp.colorGrey2,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
                enabledBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E4E61)),
                ),
                focusedBorder: const UnderlineInputBorder(
                  borderSide: BorderSide(color: Color(0xFF4E4E61)),
                ),
              ),
            ),
            const Spacer(),
            ButtonPrimary(
              title: 'Lưu',
              event: () => _editInfoViewModel.hanleSubmit(),
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}
