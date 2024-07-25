import 'package:flutter/material.dart';
import 'package:flutter_tex/flutter_tex.dart';

class TestScreen extends StatelessWidget {
  const TestScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF201E1F),
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(0, 0, 0, 0),
        title: const Text('TikTok Login Kit'),
      ),
      body: TeXView(
        child: TeXViewColumn(children: [
          TeXViewDocument(
            r"""Bên trong một căn nhà bỏ hoang hình lập phương thể tích $1000 m^3$ có 3 chú nhện con rất hay cãi vã nên phải sống riêng. Mùa đông đến, vì đói rét nên chúng đành quyết định hợp tác với nhau giăng lưới để bắt mồi. Ba chú nhện tính toán sẽ giăng một mảnh lưới hình tam giác theo cách sau: Mỗi chú nhện sẽ đứng ở mép tường bất kì (có thể mép giữa 2 bức tường, giữa tường với trần, hoặc giữa tường với nền) rồi phóng những sợi tơ làm khung đến vị trí cũng 2 con nhện còn lại rồi sau đó mới phóng tơ dính đan phần lưới bên trong. Nhưng vì vốn đã có hiềm khích từ lâu, nên trước khi bắt đầu, chúng quy định để tránh xô xát, không có bất kì 2 con nhện nào cùng nằm trên một mặt tường, nền hoặc trần nhà. Tính chu vi nhỏ nhất của mảnh lưới được giăng (biết các sợi tơ khung căng và không chùng)""",
            style: TeXViewStyle(
              contentColor: Colors.white,
              padding: const TeXViewPadding.all(20),
              fontStyle: TeXViewFontStyle(
                fontSize: 16,
                fontWeight: TeXViewFontWeight.w400,
              ),
            ),
          ),
          TeXViewDocument(
            r"""Một chất điểm chuyển động  theo  quy luật \(s=-t^3+6t^2+17t\), với $t$ (giây) là khoảng thời gian tính từ lúc vật bắt đầu chuyển động và $s$ (mét) là quãng đường vật đi được trong khoảng thời gian đó. Khi đó vận tốc  $v (m/s)$ của chuyển động đạt giá trị lớn nhất trong khoảng $8$ giây đầu tiên bằng: """,
            style: TeXViewStyle(
              contentColor: Colors.white,
              fontStyle: TeXViewFontStyle(
                fontSize: 16,
              ),
            ),
          ),
          // TeXViewInkWell(
          //   id: "id_0",
          //   child: TeXViewColumn(children: [
          //     // TeXViewDocument(r"""<h2>Flutter \( \rm\\TeX \)</h2>""",
          //     //     style: TeXViewStyle(textAlign: TeXViewTextAlign.center)),
          //     // TeXViewContainer(
          //     //   child: TeXViewImage.network(
          //     //       'https://raw.githubusercontent.com/shah-xad/flutter_tex/master/example/assets/flutter_tex_banner.png'),
          //     //   style: TeXViewStyle(
          //     //     margin: TeXViewMargin.all(10),
          //     //     borderRadius: TeXViewBorderRadius.all(20),
          //     //   ),
          //     // ),
          //   ]),
          // )
        ]),
        // style: TeXViewStyle(
        //   elevation: 10,
        //   borderRadius: TeXViewBorderRadius.all(25),
        //   border: TeXViewBorder.all(TeXViewBorderDecoration(
        //       borderColor: Colors.blue,
        //       borderStyle: TeXViewBorderStyle.solid,
        //       borderWidth: 5)),
        //   backgroundColor: Colors.white,
        // ),
      ),
    );
  }
}
