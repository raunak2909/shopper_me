import 'package:animated_bottom_navigation_bar/animated_bottom_navigation_bar.dart';
import 'package:animated_notch_bottom_bar/animated_notch_bottom_bar/animated_notch_bottom_bar.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:shopper_me/screens/home/frags/dashboard_page.dart';
import 'package:shopper_me/utils/color_constant.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late NotchBottomBarController _controller;
  var _bottomNavIndex = 0;
  Widget mainContainer = DashBoardPage();

  @override
  void initState() {
    super.initState();
    _controller = NotchBottomBarController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: mainContainer,
      floatingActionButton: FloatingActionButton(
        shape: CircleBorder(),
        backgroundColor: ColorConstant.mainOrange,
        onPressed: (){},
        child: FaIcon(FontAwesomeIcons.house, color: Colors.white,),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: AnimatedBottomNavigationBar(
        icons: [
          FontAwesomeIcons.heart,
          FontAwesomeIcons.cartFlatbed,
        ],
        activeColor: ColorConstant.darkGrey,
        inactiveColor: ColorConstant.darkGrey,
        activeIndex: _bottomNavIndex,
        gapLocation: GapLocation.center,
        notchSmoothness: NotchSmoothness.softEdge,
        splashColor: ColorConstant.mainOrange.withOpacity(0.5),
        splashRadius: 50,
        onTap: (index) {
          setState(() => _bottomNavIndex = index);
          },
        //other params
      ),
      /*bottomNavigationBar: AnimatedNotchBottomBar(
      notchBottomBarController: _controller,
      notchColor: ColorConstant.mainOrange,
      showLabel: false,
      bottomBarWidth: double.infinity,
      bottomBarItems: [
        BottomBarItem(
          inActiveItem: Image.asset(
            'assets/icons/heart.png',
            color: ColorConstant.darkGrey,
          ),
          activeItem: Image.asset(
            'assets/icons/heart.png',
            color: Colors.white,
          ),
          itemLabel: 'Page 1',
        ),
        BottomBarItem(
          inActiveItem: Image.asset(
            'assets/icons/home.png',
            color: ColorConstant.darkGrey,
          ),
          activeItem: Image.asset(
            'assets/icons/home.png',
            color: Colors.white,
          ),
          itemLabel: 'Page 1',
        ),
        BottomBarItem(
          inActiveItem: Image.asset(
            'assets/icons/shopping-cart.png',
            color: ColorConstant.darkGrey,
          ),
          activeItem: Image.asset(
            'assets/icons/shopping-cart.png',
            color: Colors.white,
          ),
          itemLabel: 'Page 1',
        ),
      ],
      onTap: (int value) {},
    )*/
    );
  }
}
