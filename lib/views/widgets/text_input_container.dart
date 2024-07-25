// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

import '../../utils/color_app.dart';

class TextInputContainer extends StatelessWidget {
  final String label;
  final String textHint;
  final bool requiredValue;
  final bool error;
  final String errorText;
  final String textButton;
  final Widget? icon;
  final void Function() event;
  final bool isPassword;
  final TextEditingController controller;
  final FocusNode? focusNode;
  final bool readOnly;

  const TextInputContainer({
    super.key,
    required this.label,
    required this.textHint,
    required this.requiredValue,
    required this.error,
    this.errorText = '',
    this.textButton = '',
    this.icon,
    required this.event,
    this.isPassword = false,
    required this.controller,
    this.focusNode,
    this.readOnly = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: ColorApp.colorGrey,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              requiredValue ? ' *' : '',
              style: TextStyle(
                color: requiredValue ? ColorApp.colorRed : ColorApp.colorGrey,
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 4,
        ),
        Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            border: Border.all(
              color: error ? ColorApp.colorRed : ColorApp.colorGrey,
              width: 1,
            ),
            color: ColorApp.colorBlack,
          ),
          height: size.height * 0.06,
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: controller,
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  obscureText: isPassword,
                  focusNode: focusNode,
                  readOnly: readOnly,
                  cursorColor: ColorApp.colorGrey2,
                  style: const TextStyle(color: Colors.white),
                  textAlignVertical: TextAlignVertical.center,
                  textAlign: TextAlign.left,
                  decoration: InputDecoration(
                    isDense: true, // Cho chu can giua theo chieu doc
                    hintText: textHint,
                    hintStyle: const TextStyle(
                      color: ColorApp.colorGrey2,
                      fontSize: 14,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    contentPadding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.03,
                    ),
                    suffixIcon: icon != null
                        ? IconButton(
                            onPressed: event,
                            icon: icon ?? const Icon(Icons.remove_red_eye),
                          )
                        : null,
                  ),
                ),
              ),
              Visibility(
                visible: textButton.isNotEmpty,
                child: Container(
                  decoration: const BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Color(0xFFFF6E47),
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(4),
                      bottomRight: Radius.circular(4),
                    ),
                  ),
                  child: TextButton(
                    onPressed: () {
                      //
                    },
                    style: TextButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 20)),
                    child: Text(
                      textButton,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 4,
        ),
        Visibility(
          visible: errorText.isNotEmpty,
          child: Text(
            errorText,
            style: TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w400,
              color: error ? ColorApp.colorRed : ColorApp.colorGrey3,
            ),
          ),
        ),
      ],
    );
  }
}
