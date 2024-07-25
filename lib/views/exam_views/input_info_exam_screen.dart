import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:multi_dropdown/multiselect_dropdown.dart';

import '../../services/response/api_status.dart';
import '../../utils/color_app.dart';
import '../../utils/text_themes.dart';
import '../../view_models/exam_view_models/input_info_exam_view_model.dart';
import '../widgets/button_primary.dart';
import '../widgets/custom_dropdown.dart';
import '../widgets/image_container.dart';
import '../widgets/show_dialog_error.dart';
import '../widgets/text_input_container.dart';

class InputInfoExamScreen extends StatelessWidget {
  InputInfoExamScreen({super.key});
  final InputInfoExamViewModel _inputInfoExamViewModel =
      Get.put(InputInfoExamViewModel());

  // final TextEditingController _nameExamCotroller = TextEditingController();
  final TextEditingController _desCotroller = TextEditingController();
  final MultiSelectController _controller = MultiSelectController();

  Future<void> _pickImageFromGallery() async {
    final returnedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (returnedImage == null) return;
    printInfo(info: returnedImage.path);
    _inputInfoExamViewModel.setSelectImage(File(returnedImage.path));
  }

  @override
  Widget build(BuildContext context) {
    // _nameExamCotroller.text = _inputInfoExamViewModel.sampleExamTitle;

    return Scaffold(
      backgroundColor: const Color(0xFF201E1F),
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        title: Text(
          'Nhập thông tin đề thi',
          style: TextThemes.text18_500,
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
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: Obx(() {
            if (_inputInfoExamViewModel.linhVatRes.value.status ==
                Status.error) {
              showDialogError(
                  error: _inputInfoExamViewModel.linhVatRes.value.message!);
            }
            if (_inputInfoExamViewModel.linhVatRes.value.status ==
                Status.completed) {
              return screen();
            }
            return const Center(
              child: CircularProgressIndicator(
                color: ColorApp.colorOrange,
              ),
            );
          }),
        ),
      ),
    );
  }

  Widget screen() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Obx(
          () => TextInputContainer(
            controller: _inputInfoExamViewModel.nameExamCotroller,
            label: 'Tên bộ đề *',
            textHint: 'Nhập tên bộ đề',
            requiredValue: false,
            error: _inputInfoExamViewModel.formError.value.name.isNotEmpty,
            errorText: _inputInfoExamViewModel.formError.value.name,
            event: () {},
          ),
        ),
        // Text(
        //   'Tên bộ đề*',
        //   style: TextThemes.text12_500,
        // ),
        // const SizedBox(height: 4),
        // Container(
        //   alignment: Alignment.center,
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     border: Border.all(
        //       color: const Color(0xFF636363),
        //       width: 1,
        //     ),
        //     color: Colors.transparent,
        //   ),
        //   height: Get.height * 0.06,
        //   child: TextField(
        //     controller: _nameExamCotroller,
        //     cursorColor: ColorApp.colorGrey2,
        //     style: const TextStyle(color: Colors.white),
        //     textAlignVertical: TextAlignVertical.center,
        //     textAlign: TextAlign.left,
        //     decoration: InputDecoration(
        //       isDense: true, // Cho chu can giua theo chieu doc
        //       hintText: 'Nhập tên bộ đề',
        //       hintStyle: const TextStyle(
        //         color: ColorApp.colorGrey2,
        //         fontSize: 14,
        //         fontWeight: FontWeight.w400,
        //       ),
        //       border: InputBorder.none,
        //       contentPadding: EdgeInsets.symmetric(
        //         horizontal: Get.width * 0.03,
        //       ),
        //     ),
        //   ),
        // ),
        const SizedBox(height: 12),
        Text(
          'Banner',
          style: TextThemes.text12_500,
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: SizedBox(
            width: double.infinity,
            child: _inputInfoExamViewModel.selectedImage.value == null
                ? ImageContainer(
                    image: _inputInfoExamViewModel.imageVal,
                    height: Get.height * 0.5,
                    replaceImage: 'assets/images/banner.png',
                  )
                : Image.file(
                    _inputInfoExamViewModel.selectedImage.value!,
                    width: double.infinity,
                    height: Get.height * 0.5,
                    fit: BoxFit.cover,
                  ),
          ),
        ),
        const SizedBox(height: 12),
        TextButton(
          onPressed: () => _pickImageFromGallery(),
          style: TextButton.styleFrom(
            backgroundColor: const Color(0xFF312E2E),
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset('assets/icons/dung-mau.svg'),
              const SizedBox(width: 8),
              const Text(
                'Đổi mẫu banner',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Mô tả',
          style: TextThemes.text12_500,
        ),
        const SizedBox(height: 4),
        Container(
          height: Get.height * 0.15,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: const Color(0xFF636363),
            ),
          ),
          child: SingleChildScrollView(
            child: TextField(
              controller: _desCotroller,
              onTapOutside: (event) =>
                  FocusManager.instance.primaryFocus?.unfocus(),
              maxLines: null,
              keyboardType: TextInputType.multiline,
              textInputAction: TextInputAction.newline,
              cursorColor: ColorApp.colorGrey2,
              style: const TextStyle(color: Colors.white),
              // textAlignVertical: TextAlignVertical.center,
              // textAlign: TextAlign.left,
              decoration: InputDecoration(
                isDense: true, // Cho chu can giua theo chieu doc
                hintText: 'Nhập mô tả',
                hintStyle: TextThemes.text14_400.copyWith(
                  color: const Color(0xFFC1C1CD),
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
              ),
            ),
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Hashtag',
          style: TextThemes.text12_500,
        ),
        const SizedBox(height: 4),
        MultiSelectDropDown(
          controller: _controller,
          clearIcon: null,
          hint: 'Hashtag...',
          selectedOptionBackgroundColor: const Color(0xFFFF6E47),
          optionsBackgroundColor: const Color(0xFF3F3F40),
          onOptionSelected: (options) {
            // debugPrint(options.toString());
            List<int> value = options
                .map((item) => int.parse(item.value.toString()))
                .toList();
            _inputInfoExamViewModel.onChangeSelectHashtag(value);
          },
          options: <ValueItem>[
            ..._inputInfoExamViewModel.listHashtag.map((item) => ValueItem(
                  label: item.title,
                  value: item.id,
                )),
          ],
          selectedOptions: const [
            // ValueItem(
            //   label: _inputInfoExamViewModel.listHashtag.first.title,
            //   value: _inputInfoExamViewModel.listHashtag.first.id,
            // )
          ],
          maxItems: null,
          dropdownBackgroundColor: const Color(0xFF201E1F),
          selectionType: SelectionType.multi,
          chipConfig: const ChipConfig(
            wrapType: WrapType.wrap,
            backgroundColor: Color(0xFFE4D3FF),
            radius: 4,
            runSpacing: 0,
            spacing: 4,
            padding: EdgeInsets.only(
              left: 8,
              top: 4,
              bottom: 4,
            ),
            labelStyle: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w400,
              color: Color(0xFF5E00F5),
            ),
            deleteIcon: Icon(
              Icons.close,
              size: 14,
            ),
            deleteIconColor: Color(0xFF28293D),
          ),
          dropdownHeight: 200,
          optionTextStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
          selectedOptionIcon: const Icon(
            Icons.check,
            color: Colors.transparent,
          ),
          inputDecoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: const Color(0xFF636363),
            ),
          ),
          suffixIcon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: Color(0xFFC1C1CD),
            size: 40,
          ),
          padding: const EdgeInsets.only(left: 12),
        ),
        // Container(
        //   width: double.infinity,
        //   padding: const EdgeInsets.all(12),
        //   decoration: BoxDecoration(
        //     borderRadius: BorderRadius.circular(12),
        //     border: Border.all(
        //       width: 1,
        //       color: const Color(0xFF636363),
        //     ),
        //   ),
        //   child: Row(
        //     children: [
        //       Expanded(
        //         child: Wrap(
        //           spacing: 4,
        //           children: [
        //             chip(
        //               title: 'Nạp kiến thức',
        //               background: const Color(0xFFE4D3FF),
        //               textColor: const Color(0xFF5E00F5),
        //               event: () {},
        //             ),
        //             chip(
        //               title: 'Ôn tập hóa',
        //               background: const Color(0xFFFFD2CC),
        //               textColor: const Color(0xFFFF4C1C),
        //               event: () {},
        //             ),
        //           ],
        //         ),
        //       ),
        //       IconButton(
        //         onPressed: () {},
        //         style: IconButton.styleFrom(
        //           minimumSize: Size.zero,
        //           padding: EdgeInsets.zero,
        //           tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        //         ),
        //         icon: SvgPicture.asset('assets/icons/arrow-down.svg'),
        //       ),
        //     ],
        //   ),
        // ),
        const SizedBox(height: 12),
        Text(
          'Thuộc linh vật:',
          style: TextThemes.text12_500,
        ),
        const SizedBox(height: 4),
        Obx(
          () => CustomDropdown(
            textSelect: _inputInfoExamViewModel.dropdownMascotVal.value,
            // textSelect: _inputInfoExamViewModel.listMascot.first.title,
            listData: _inputInfoExamViewModel.listMascot
                .map((item) => DropDownItem(
                      text: item.title,
                      value: item.id,
                    ))
                .toList(),
            widthDropMenu: Get.width * 0.8,
            onChange: (value) => _inputInfoExamViewModel.onChangeSelectMascot(
                value.text, value.value),
            action: [
              const SizedBox(width: 12),
              SvgPicture.asset('assets/icons/arrow-down.svg'),
              const SizedBox(width: 12),
              IconButton(
                onPressed: () {},
                style: IconButton.styleFrom(
                  minimumSize: Size.zero,
                  padding: EdgeInsets.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                icon: SvgPicture.asset('assets/icons/add-2.svg'),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        Text(
          'Cấu hình đề thi:',
          style: TextThemes.text12_500,
        ),
        const SizedBox(height: 4),
        Obx(
          () => CustomDropdown(
            textSelect: _inputInfoExamViewModel.dropdownIsPublicVal.value,
            listData: _inputInfoExamViewModel.listIsPublic
                .map((item) => DropDownItem(
                      text: item['title'],
                      value: item['value'],
                    ))
                .toList(),
            widthDropMenu: Get.width * 0.8,
            onChange: (value) => _inputInfoExamViewModel.onChangeSelectIsPublic(
                value.text, value.value),
            action: [
              const SizedBox(width: 12),
              SvgPicture.asset('assets/icons/arrow-down.svg'),
            ],
          ),
        ),
        const SizedBox(height: 60),
        Obx(() {
          if (_inputInfoExamViewModel.addExamRes.value.status == Status.error) {
            showDialogError(
              error: _inputInfoExamViewModel.addExamRes.value.message!,
            );
          }

          if (_inputInfoExamViewModel.addExamRes.value.status ==
              Status.loading) {
            return const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                CircularProgressIndicator(
                  color: ColorApp.colorOrange,
                ),
              ],
            );
          }

          return ButtonPrimary(
            title: 'Tiếp theo',
            event: () => _inputInfoExamViewModel.handleSubmit(
              _inputInfoExamViewModel.nameExamCotroller.text,
              _desCotroller.text,
              // imageVal: imageValue,
            ),
          );
        }),

        const SizedBox(height: 20),
      ],
    );
  }

  Widget wrapContainer({required String title, required Widget widget}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 12),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            color: Color(0xFFC1C1CD),
          ),
        ),
        const SizedBox(height: 4),
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              width: 1,
              color: const Color(0xFF636363),
            ),
          ),
          child: widget,
        ),
      ],
    );
  }

  Widget chip({
    required String title,
    required Color background,
    required Color textColor,
    required event,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 8,
        vertical: 4,
      ),
      decoration: BoxDecoration(
        color: background,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.w400,
              color: textColor,
            ),
          ),
          const SizedBox(width: 8),
          IconButton(
            onPressed: () {},
            icon: SvgPicture.asset('assets/icons/delete.svg'),
            style: IconButton.styleFrom(
              minimumSize: Size.zero,
              padding: EdgeInsets.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
          ),
        ],
      ),
    );
  }
}
