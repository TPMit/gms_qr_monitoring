import 'package:flutter/material.dart';

class CustomBackground extends StatelessWidget {
  const CustomBackground({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      children: [
        Container(
          width: size.width,
          height: size.height,
          color: Color(0xFF406C6B),
        ),
        Positioned(
            top: -80,
            left: -20,
            child: Container(
              width: 150,
              height: 150,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF507677)),
            )),
        Positioned(
            top: 20,
            right: -10,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF507677)),
            )),
        Positioned(
            top: 400,
            left: -100,
            child: Container(
              width: 400,
              height: 400,
              decoration: BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xFF507677)),
            )),
      ],
    );
  }
}
