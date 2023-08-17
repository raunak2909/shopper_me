import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:shopper_me/routes/app_routes.dart';
import 'package:shopper_me/utils/color_constant.dart';
import 'package:shopper_me/utils/image_constant.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              Expanded(
                  flex: 4,
                  child: StaggeredGrid.count(
                    crossAxisCount: 10,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    children: [
                      StaggeredGridTile.count(
                          crossAxisCellCount: 5,
                          mainAxisCellCount: 13,
                          child: imageTile(ImageConstant.splash_bg_1)),
                      StaggeredGridTile.count(
                          crossAxisCellCount: 5,
                          mainAxisCellCount: 6,
                          child: imageTile(ImageConstant.splash_bg_3)),
                      StaggeredGridTile.count(
                          crossAxisCellCount: 5,
                          mainAxisCellCount: 7,
                          child: imageTile(ImageConstant.splash_bg_2)),
                    ],
                  )),
              Expanded(
                flex: 2,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Let\'s Buy On Our Clothes for Convenience',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 31,
                            fontWeight: FontWeight.w900),
                      ),
                      Text(
                        'We Provide Various Types Of Clothes Tha Are Suitable ANd Comfortable For You',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontFamily: 'Mulish',
                            fontSize: 14,
                          color: Colors.grey
                        ),
                      ),
                      SizedBox(
                          width: double.infinity,
                          height: 51,
                          child: ElevatedButton(onPressed: (){
                            Navigator.popAndPushNamed(context, AppRoutes.homeScreen);
                          }, child: Text('Get Started', style: TextStyle(color: Colors.white, fontFamily: 'Mulish', fontSize: 19, fontWeight: FontWeight.w900),), style: ElevatedButton.styleFrom(backgroundColor: Colors.black, ),)),
                      RichText(text: TextSpan(
                        children: [
                          TextSpan(text: "Already have account? ", style: TextStyle(fontFamily: 'Mulish',color: Colors.black)),
                          TextSpan(text: "Login", style: TextStyle(fontFamily: 'Mulish', color: ColorConstant.mainOrange))
                        ]
                      ),)
                    ],
                  ),
                )
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget imageTile(img) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(21),
      child: Image.asset(img, fit: BoxFit.fill),
    );
  }
}
