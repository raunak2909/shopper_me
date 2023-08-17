import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:shopper_me/app_widgets/category_widget.dart';
import 'package:shopper_me/app_widgets/dot_indicator.dart';
import 'package:shopper_me/app_widgets/product_widget.dart';
import 'package:shopper_me/app_widgets/round_icon_widget.dart';
import 'package:shopper_me/firebase/firebase_provider.dart';
import 'package:shopper_me/models/product_model.dart';
import 'package:shopper_me/routes/app_routes.dart';
import 'package:shopper_me/utils/color_constant.dart';
import 'package:shopper_me/utils/image_constant.dart';

import '../../../models/category_model.dart';

class DashBoardPage extends StatefulWidget {
  const DashBoardPage({super.key});

  @override
  State<DashBoardPage> createState() => _DashBoardPageState();
}

class _DashBoardPageState extends State<DashBoardPage> {
  late Stream<QuerySnapshot<Object?>> bannersStream;
  late Stream<QuerySnapshot<Object?>> categoryStream;
  late Stream<QuerySnapshot<Object?>> productStream;
  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    bannersStream = FirebaseProvider().getBanners();
    categoryStream = FirebaseProvider().getCategories();
    productStream = FirebaseProvider().getAllProducts();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              PreferredSize(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      RoundIconWidget(img: ImageConstant.app_drawer),
                      RoundIconWidget(img: ImageConstant.bell)
                    ],
                  ),
                  preferredSize: Size(double.infinity, 100)),
              SizedBox(
                height: 16,
              ),
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: ColorConstant.lightGrey,
                    borderRadius: BorderRadius.circular(20)),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 7,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Image.asset(
                        ImageConstant.search,
                        color: ColorConstant.darkGrey,
                      ),
                    ),
                    Expanded(
                      child: TextField(
                        cursorColor: ColorConstant.darkGrey,
                        style: TextStyle(
                            fontSize: 13,
                            color: ColorConstant.darkGrey,
                            fontFamily: 'Mulish'),
                        decoration: InputDecoration(
                            hintText: 'Search..',
                            hintStyle: TextStyle(
                                fontSize: 13,
                                color: ColorConstant.darkGrey,
                                fontFamily: 'Mulish'),
                            border: InputBorder.none),
                      ),
                    ),
                    Text(
                      '|',
                      style: TextStyle(
                          fontSize: 13,
                          color: ColorConstant.darkGrey,
                          fontFamily: 'Mulish'),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Image.asset(
                        ImageConstant.setting,
                        color: ColorConstant.darkGrey,
                      ),
                    ),
                    SizedBox(
                      width: 7,
                    ),
                  ],
                ),
              ),
              SizedBox(
                height: 16,
              ),
              Expanded(
                  child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      StreamBuilder<QuerySnapshot<Object?>>(
                          stream: bannersStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<String> arrBannerUrls = [];
                              for (QueryDocumentSnapshot doc
                                  in snapshot.data!.docs) {
                                arrBannerUrls.add(doc.get('img'));
                              }
                              return SizedBox(
                                height: 180,
                                child: Stack(
                                  children: [
                                    CarouselSlider(
                                      options: CarouselOptions(
                                        viewportFraction: 1,
                                        height: 180.0,
                                        autoPlay: true,
                                        onPageChanged: (index, _) {
                                          print('Changed');
                                          currentIndex = index;
                                          setState(() {});
                                        },
                                        autoPlayCurve: Curves.fastOutSlowIn,
                                      ),
                                      items: arrBannerUrls.map((url) {
                                        return Builder(
                                          builder: (BuildContext context) {
                                            return Container(
                                                width: MediaQuery.of(context)
                                                    .size
                                                    .width,
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5.0),
                                                decoration: BoxDecoration(
                                                    color: Colors.amber,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20)),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                    url,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ));
                                          },
                                        );
                                      }).toList(),
                                    ),
                                    Align(
                                      alignment: Alignment.bottomCenter,
                                      child: Padding(
                                        padding: const EdgeInsets.only(bottom: 7.0),
                                        child: DotIndicator(
                                          count: arrBannerUrls.length,
                                          index: currentIndex,
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error Loading Banners');
                            } else {
                              return CircularProgressIndicator(
                                color: ColorConstant.mainOrange,
                              );
                            }
                          }),
                      SizedBox(
                        height: 16,
                      ),
                      StreamBuilder<QuerySnapshot<Object?>>(
                          stream: categoryStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<CategoryModel> arrCategories = [];
                              for (QueryDocumentSnapshot doc
                                  in snapshot.data!.docs) {
                                arrCategories.add(CategoryModel.fromMap(
                                    doc.data() as Map<String, dynamic>));
                              }
                              return SizedBox(
                                width: double.infinity,
                                height: 100,
                                child: ListView.builder(
                                    shrinkWrap: true,
                                    itemExtent: 70,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: arrCategories.length,
                                    itemBuilder: (_, index) {
                                      return CategoryWidget(
                                          imgUrl: arrCategories[index].img,
                                          name: arrCategories[index].cat_name);
                                    }),
                              );
                            } else if (snapshot.hasError) {
                              return Text('Error Loading Categories');
                            } else {
                              return CircularProgressIndicator(
                                color: ColorConstant.mainOrange,
                              );
                            }
                          }),
                      SizedBox(
                        height: 8,
                      ),
                      PreferredSize(
                          preferredSize: Size(double.infinity, 100),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Special For You',
                                style: TextStyle(
                                    fontSize: 19,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Mulish'),
                              ),
                              InkWell(
                                onTap: (){
                                  Navigator.pushNamed(context, AppRoutes.allProductsScreen);
                                },
                                child: Text(
                                  'See all',
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                      color: ColorConstant.darkGrey,
                                      fontFamily: 'Mulish'),
                                ),
                              )
                            ],
                          )),
                      SizedBox(
                        height: 8,
                      ),
                      StreamBuilder<QuerySnapshot<Object?>>(
                          stream: productStream,
                          builder: (context, snapshot) {
                            if (snapshot.hasData) {
                              List<ProductModel> arrProducts = [];
                              for (QueryDocumentSnapshot doc
                                  in snapshot.data!.docs) {
                                arrProducts.add(ProductModel.fromMap(
                                    doc.data() as Map<String, dynamic>));
                              }
                              return GridView.builder(
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing: 11,
                                          childAspectRatio: 5 / 6,
                                          crossAxisSpacing: 11),
                                  itemCount: arrProducts.length,
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemBuilder: (_, index) {
                                    return InkWell(
                                      onTap: (){
                                        Navigator.pushNamed(context, AppRoutes.detailProductScreen, arguments: {'productId': arrProducts[index].product_id});
                                      },
                                      child: ProductWidget(
                                        name: arrProducts[index].name,
                                        imgUrl: arrProducts[index].images[0],
                                        price:
                                            arrProducts[index].price.toString(),
                                        colorHex: arrProducts[index].colors,
                                      ),
                                    );
                                  });
                            } else if (snapshot.hasError) {
                              return Text('Error Loading Categories');
                            } else {
                              return CircularProgressIndicator(
                                color: ColorConstant.mainOrange,
                              );
                            }
                          }),
                    ],
                  ),
                ),
              ))
            ],
          ),
        ),
      ),
    );
  }


}
