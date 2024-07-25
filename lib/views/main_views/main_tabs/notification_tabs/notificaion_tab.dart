import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../utils/color_app.dart';

class NotificationTab extends StatelessWidget {
  const NotificationTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF18191A),
      appBar: AppBar(
        title: const Text(
          'Thông báo',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Container(
        decoration: const BoxDecoration(
          border: Border(
            top: BorderSide(
              color: Color(0xFF555770),
              width: 0.6,
            ),
          ),
        ),
        child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Center(
              child: Text(
                'Chưa có thông báo nào',
                style: TextStyle(color: ColorApp.colorOrange),
              ),
            )
            // ListView.builder(
            //   itemCount: 10,
            //   itemBuilder: (BuildContext context, int index) {
            //     return rowNotificaion(
            //       image: 'assets/images/ava.png',
            //       title:
            //           'Bạn vừa được tặng 1 G cho bộ đề Ôn Thi Môn Toán THPT Quốc Gia',
            //       time: '56 phút trước 21:59',
            //     );
            //   },
            // ),
            ),
      ),
    );
  }

  Widget rowNotificaion({
    required String image,
    required String title,
    required String time,
  }) {
    return Container(
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 0.5,
            color: Color(0xFF555770),
          ),
        ),
      ),
      child: Row(
        children: [
          Image.asset(image),
          const SizedBox(width: 8),
          Expanded(
              child: Column(
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  SvgPicture.asset('assets/icons/time.svg'),
                  const SizedBox(width: 8),
                  Text(
                    time,
                    style: const TextStyle(
                      color: Color(0xFFC1C1CD),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              )
            ],
          ))
        ],
      ),
    );
  }
}
