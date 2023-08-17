import 'package:flutter/material.dart';

import '../utils/color_constant.dart';

class CategoryWidget extends StatelessWidget {
  String imgUrl;
  String name;
  CategoryWidget({required this.imgUrl, required this.name});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Column(
        children: [
          Container(
            width: 55,
            height: 55,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(imgUrl)
              ),
                color: ColorConstant.lightGrey, shape: BoxShape.circle),
          ),
          SizedBox(
            height: 4,
          ),
          Text(name, style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: ColorConstant.darkGrey,
              fontFamily: 'Mulish'),)
        ],
      ),
    );
  }
}
