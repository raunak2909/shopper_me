import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopper_me/utils/image_constant.dart';

import '../utils/color_constant.dart';

class ProductWidget extends StatelessWidget {
  String? imgUrl;
  String? name;
  String? price;
  List<dynamic>? colorHex;
  ProductWidget({this.imgUrl,this.name, this.price, this.colorHex});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: BoxDecoration(
          color: ColorConstant.lightGrey,
          borderRadius: BorderRadius.circular(21),
        ),
        child: Stack(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 11),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Image.network(imgUrl!, width: 100, height: 100,),
                  SizedBox(
                    width: double.infinity,
                    child: Text(name!, style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Mulish'),),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$ $price', style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Mulish'),),
                      SizedBox(
                        height: 30,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          shrinkWrap: true,
                          itemCount: colorHex!.length> 3 ? 4 : colorHex!.length,
                            itemBuilder: (_,index){
                            if(index==3){
                              return Container(
                                margin: EdgeInsets.symmetric(horizontal: 2),
                                width: 20,
                                height: 20,
                                decoration:
                                BoxDecoration(
                                    border: Border.all(
                                        color: ColorConstant.darkGrey
                                    ), shape: BoxShape.circle),
                                child: Center(
                                  child: Text(
                                      '+${colorHex!.length-3}', style: TextStyle(
                                      fontSize: 11,
                                      fontFamily: 'Mulish'),
                                  ),
                                ),
                              );
                            }
                            return Container(
                              margin: EdgeInsets.symmetric(horizontal: 2),
                              width: 20,
                              height: 20,
                              decoration:
                              BoxDecoration(
                                border: Border.all(
                                  color: ColorConstant.fromHex(colorHex![index])
                                ), shape: BoxShape.circle),
                              child: Container(
                                margin: EdgeInsets.all(1),
                                  decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.fromHex(colorHex![index]))
                              ),
                            );
                        }),
                      )
                    ],
                  )
                ],
              ),
            ),
            Positioned(
              right: 0,
                child: Container(
              padding: EdgeInsets.all(11),
              width: 40,
              height: 40,
              decoration:
              BoxDecoration(
                color: ColorConstant.mainOrange,
                borderRadius: BorderRadius.only(topRight: Radius.circular(21), bottomLeft: Radius.circular(11)),
              ),
              child: Center(
                child: FaIcon(FontAwesomeIcons.heart, color: Colors.white, size: 19,),
              )
            ))
          ],
        ),
      ),
    );
  }
}
