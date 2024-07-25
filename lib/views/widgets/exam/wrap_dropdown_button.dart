// import 'package:dropdown_button2/dropdown_button2.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';

// class WrapDropdownButton extends StatelessWidget {
//   WrapDropdownButton({
//     super.key,
//     required this.dropdownValue,
//     required this.listData,
//   });

//   String dropdownValue;
//   List<String> listData;

//   @override
//   Widget build(BuildContext context) {
//     return Theme(
//       data: Theme.of(context).copyWith(
//         splashColor: Colors.transparent,
//         highlightColor: Colors.transparent,
//         hoverColor: Colors.transparent,
//       ),
//       child: DropdownButtonHideUnderline(
//         child: Obx(
//           () => DropdownButton2<String>(
//             items: listData
//                 .map((item) => DropdownMenuItem<String>(
//                       value: item,
//                       child: Text(
//                         item,
//                         style: const TextStyle(
//                           color: Colors.white,
//                           fontSize: 14,
//                         ),
//                       ),
//                     ))
//                 .toList(),
//             value: dropdownValue,
//             onChanged: (String? newValue) =>
//             inputInfoExamViewModel.onChangSelect(newValue),
//             customButton: Container(
//               width: double.infinity,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(12),
//                 border: Border.all(
//                   width: 1,
//                   color: const Color(0xFF636363),
//                 ),
//               ),
//               child: Row(
//                 children: [
//                   Expanded(
//                     child: Text(
//                       dropdownValue,
//                       style: const TextStyle(
//                         color: Colors.white,
//                         fontWeight: FontWeight.w400,
//                         fontSize: 14,
//                       ),
//                     ),
//                   ),
//                   const SizedBox(width: 12),
//                   SvgPicture.asset('assets/icons/arrow-down.svg'),
//                   const SizedBox(width: 12),
//                   IconButton(
//                     onPressed: () {},
//                     style: IconButton.styleFrom(
//                       minimumSize: Size.zero,
//                       padding: EdgeInsets.zero,
//                       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
//                     ),
//                     icon: SvgPicture.asset('assets/icons/add-2.svg'),
//                   ),
//                 ],
//               ),
//             ),
//             dropdownStyleData: DropdownStyleData(
//               // maxHeight: 200,
//               width: size.width * 0.8,
//               padding: EdgeInsets.zero,
//               elevation: 0,
//               decoration: BoxDecoration(
//                 color: const Color(0xFF3F3F40),
//                 borderRadius: BorderRadius.circular(6),
//               ),
//               offset: const Offset(20, -10),
//               scrollbarTheme: ScrollbarThemeData(
//                 radius: const Radius.circular(40),
//                 thickness: WidgetStateProperty.all(6),
//                 thumbVisibility: WidgetStateProperty.all(true),
//               ),
//             ),
//             menuItemStyleData: const MenuItemStyleData(
//               padding: EdgeInsets.symmetric(
//                 horizontal: 12,
//                 // vertical: 8,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
