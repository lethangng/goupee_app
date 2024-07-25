import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../../../app/routes.dart';
import '../../../models/Exam/sentence_search.dart';
import '../../../models/home_models/command.dart';
import '../../../services/response/api_status.dart';
import '../../../utils/color_app.dart';
import '../../../utils/text_themes.dart';
import '../../../view_models/controllers/app_data_controller.dart';
import '../../../view_models/exam_view_models/create_exam_view_model.dart';
import '../../widgets/show_dialog_error.dart';

class CreateExamScreen extends StatelessWidget {
  CreateExamScreen({super.key});

  final CreateExamViewModel _createExamViewModel =
      Get.put(CreateExamViewModel());
  final AppDataController _appDataController = Get.find<AppDataController>();
  final TextEditingController createEditController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorApp.colorBlack4,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        flexibleSpace: Container(),
        toolbarHeight: 100,
        scrolledUnderElevation: 0,
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        title: Stack(
          children: [
            const SizedBox(
              width: double.infinity,
            ),
            Align(
              alignment: Alignment.center,
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/logo-icon-2.svg'),
                  const Text(
                    'GoupeeAI',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () => Get.back(),
                  icon: SvgPicture.asset('assets/icons/arrow-back.svg'),
                  style: IconButton.styleFrom(
                    minimumSize: Size.zero,
                    padding: const EdgeInsets.only(top: 8),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    elevation: 0,
                  ),
                ),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.topRight,
                child: Opacity(
                  opacity: 0.5,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF6E47),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      minimumSize: Size.zero,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 6,
                      ),
                    ),
                    child: Text(
                      'Tiếp theo',
                      style: TextThemes.text12_600,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Obx(() {
                if (_createExamViewModel.sentenceSearchRes.value.status ==
                    Status.error) {
                  showDialogError(
                      error: _createExamViewModel
                          .sentenceSearchRes.value.message!);
                }

                if (_createExamViewModel.sentenceSearchRes.value.status ==
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
          inputBottom(),
        ],
      ),
    );
  }

  Widget screen() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 45),
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            child: SizedBox(
              width: Get.width * 0.8,
              child: Text(
                'Hãy cho chúng tôi biết mong muốn của bạn hoặc chọn một đề xuất',
                style: TextThemes.text15_400,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 25),
          Wrap(
            spacing: 15,
            runSpacing: 5,
            children: [
              ..._createExamViewModel.listData
                  .map((item) => chip(sentenceSearch: item)),
            ],
          ),
        ],
      ),
    );
  }

  Widget inputBottom() {
    final RxBool showCreateButton = false.obs;
    final RxInt countText = 0.obs;
    final RxBool showCommand = false.obs;

    Command? commandVal;

    void handleShowCreateButton() {
      showCreateButton.value = !showCreateButton.value;
    }

    void handleCountText(String value) {
      countText.value = value.length;
      if (value == '/') {
        showCommand.value = true;
      } else {
        showCommand.value = false;
      }
    }

    Widget rowText({
      required Command command,
      required bool isLast,
    }) {
      return GestureDetector(
        onTap: () {
          showCommand.value = false;
          createEditController.text = command.description;
          commandVal = command;
          handleCountText(command.description);
          // FocusManager.instance.primaryFocus?.unfocus();
        },
        child: Container(
          padding: const EdgeInsets.only(
            bottom: 12,
            top: 12,
          ),
          decoration: BoxDecoration(
            border: BorderDirectional(
              bottom: BorderSide(
                color: !isLast ? const Color(0xFF353542) : Colors.transparent,
                width: !isLast ? 1 : 0,
              ),
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                width: 100,
                child: Text(
                  command.title,
                  style: TextThemes.text15_400,
                ),
              ),
              Flexible(
                child: Text(
                  command.description,
                  style: TextThemes.text15_400,
                ),
              )
            ],
          ),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Obx(
          () {
            List<Command> listData =
                _appDataController.appDataRes.value.data!.command;
            return Visibility(
              visible: showCommand.value,
              child: Container(
                margin: const EdgeInsets.only(bottom: 10),
                constraints: BoxConstraints(
                  maxHeight: Get.height * 0.2,
                ),
                padding: const EdgeInsets.symmetric(horizontal: 12),
                color: const Color(0xFF312E2E),
                child: ListView.builder(
                  itemCount: listData.length,
                  itemBuilder: (BuildContext context, int index) {
                    return rowText(
                      command: listData[index],
                      isLast: index == listData.length - 1,
                    );
                  },
                ),
              ),
            );
          },
        ),
        Obx(
          () => Visibility(
            visible: showCreateButton.value,
            child: Container(
              margin: const EdgeInsets.only(left: 23),
              child: TextButton(
                onPressed: () => Get.toNamed(Routes.createExamYourselt),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF312E2E),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.all(8),
                  foregroundColor: const Color(0xFFE4E4E4),
                ),
                child: Text(
                  'Tự thêm đề thi',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    shadows: [
                      BoxShadow(
                        color: const Color(0xFF000000).withOpacity(0.15),
                        spreadRadius: 0,
                        blurRadius: 0,
                        offset: const Offset(0, 0),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.only(bottom: 15, top: 10),
          decoration: const BoxDecoration(
              // gradient: LinearGradient(
              //   colors: [
              //     const Color(0xFF000000).withOpacity(0),
              //     const Color(0xFF181818).withOpacity(1)
              //   ],
              //   begin: Alignment.topCenter,
              //   end: Alignment.bottomCenter,
              //   stops: const [0.1, 0.9],
              // ),
              ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextButton(
                onPressed: () => handleShowCreateButton(),
                style: TextButton.styleFrom(
                  backgroundColor: const Color(0xFF312E2E),
                  shape: const CircleBorder(),
                  padding: EdgeInsets.zero,
                ),
                child: SvgPicture.asset('assets/icons/dot.svg'),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(12),
                  height: Get.height * 0.15,
                  decoration: BoxDecoration(
                    color: const Color(0xFF312E2E),
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: const Color(0xFF636363),
                      width: 1,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: TextField(
                                controller: createEditController,
                                onTapOutside: (event) => FocusManager
                                    .instance.primaryFocus
                                    ?.unfocus(),
                                onChanged: (value) => handleCountText(value),
                                style: const TextStyle(color: Colors.white),
                                maxLines: null,
                                expands: true,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  hintText: 'Nhập câu lệnh tại đây',
                                  hintStyle: TextStyle(
                                    color: ColorApp.colorGrey2,
                                    fontSize: 15,
                                    fontWeight: FontWeight.w400,
                                  ),
                                  border: InputBorder.none,
                                  contentPadding: EdgeInsets.zero,
                                ),
                              ),
                            ),
                            TextButton(
                              onPressed: () {},
                              style: IconButton.styleFrom(
                                padding: const EdgeInsets.all(5),
                                minimumSize: Size.zero,
                                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                              ),
                              child: SvgPicture.asset('assets/icons/mic.svg'),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Obx(
                            () => Text(
                              '${countText.value}/200',
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w400,
                                color: Color(0xFFA2A2B5),
                              ),
                            ),
                          ),
                          const SizedBox(width: 3),
                          IconButton(
                            onPressed: () {
                              if (createEditController.text.isNotEmpty) {
                                createEditController.text = '';
                                handleCountText('');
                                // FocusManager.instance.primaryFocus?.unfocus();

                                Get.toNamed(
                                  Routes.createExam2,
                                  arguments: {
                                    'sentenceSearch': SentenceSearch.commandTo(
                                      commandVal,
                                      createEditController.text,
                                    ),
                                    'isCommand': true,
                                  },
                                );
                              }
                            },
                            style: IconButton.styleFrom(
                              padding: const EdgeInsets.all(5),
                              minimumSize: Size.zero,
                              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                            ),
                            icon: SvgPicture.asset('assets/icons/send.svg'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 11),
            ],
          ),
        ),
      ],
    );
  }

  Widget chip({required SentenceSearch sentenceSearch}) {
    return TextButton(
      onPressed: () => Get.toNamed(
        Routes.createExam2,
        arguments: {
          'sentenceSearch': sentenceSearch,
          'isCommand': false,
        },
      ),
      style: TextButton.styleFrom(
        backgroundColor: const Color(0xFF312E2E),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(8),
      ),
      child: Text(
        sentenceSearch.title,
        style: TextThemes.text14_400.copyWith(
          color: const Color(0xFFE4E4E4),
        ),
      ),
    );
  }
}
