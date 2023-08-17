import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopper_me/firebase/firebase_provider.dart';
import 'package:shopper_me/models/product_model.dart';
import 'package:shopper_me/utils/color_constant.dart';

import '../../app_widgets/dot_indicator.dart';
import '../../app_widgets/round_icon_widget.dart';
import '../../utils/image_constant.dart';

class ProductDetailPage extends StatefulWidget {
  const ProductDetailPage({super.key});

  @override
  State<ProductDetailPage> createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  late String product_id;
  int currentIndex = 0;
  int selectedSize = 0;
  int selectedColor = 0;
  int quantity = 1;
  late Stream<QuerySnapshot<Object?>> productStream;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic> arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    print('${arguments['productId']}');
    productStream = FirebaseProvider().getProductDetail(arguments['productId']);
    return SafeArea(
        child: Scaffold(
      backgroundColor: ColorConstant.lightGrey,
      body: StreamBuilder<QuerySnapshot<Object?>>(
          stream: productStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.docs.isNotEmpty) {
                var data = ProductModel.fromMap(
                    snapshot.data!.docs[0].data() as Map<String, dynamic>);
                return Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(11.0),
                      child: Stack(
                        children: [
                          StatefulBuilder(builder: (context, setState) {
                            return SizedBox(
                              height: 300,
                              child: Stack(
                                children: [
                                  CarouselSlider(
                                    options: CarouselOptions(
                                      viewportFraction: 1,
                                      height: 280.0,
                                      autoPlay: true,
                                      onPageChanged: (index, _) {
                                        print('Changed');
                                        currentIndex = index;
                                        setState(() {});
                                      },
                                      autoPlayCurve: Curves.fastOutSlowIn,
                                    ),
                                    items: data.images.map((url) {
                                      return Builder(
                                        builder: (BuildContext context) {
                                          return Container(
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              margin:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 5.0),
                                              decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          20)),
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  url,
                                                  fit: BoxFit.contain,
                                                ),
                                              ));
                                        },
                                      );
                                    }).toList(),
                                  ),
                                  Align(
                                    alignment: Alignment.bottomCenter,
                                    child: Padding(
                                      padding:
                                          const EdgeInsets.only(bottom: 7.0),
                                      child: DotIndicator(
                                        count: data.images.length,
                                        index: currentIndex,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          }),
                          Align(
                            alignment: Alignment.topCenter,
                            child: PreferredSize(
                                preferredSize: Size(
                                    MediaQuery.of(context).size.width, 100),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: RoundIconWidget(
                                          img: ImageConstant.back,
                                          bgColor: Colors.white,
                                          iconColor: Colors.black,
                                        )),
                                    Expanded(child: Container()),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: RoundIconWidget(
                                          img: ImageConstant.share,
                                          bgColor: Colors.white,
                                          iconColor: Colors.black,
                                        )),
                                    const SizedBox(
                                      width: 8,
                                    ),
                                    InkWell(
                                        onTap: () {
                                          Navigator.pop(context);
                                        },
                                        child: RoundIconWidget(
                                          img: ImageConstant.heart,
                                          bgColor: Colors.white,
                                          iconColor: Colors.black,
                                        )),
                                  ],
                                )),
                          ),
                        ],
                      ),
                    ),
                    StatefulBuilder(
                      builder: (context, setState) {
                        return Expanded(
                            child: Stack(
                          children: [
                            Container(
                              padding:
                                  const EdgeInsets.only(top: 16, left: 16, right: 16),
                              decoration: const BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(21),
                                      topRight: Radius.circular(25))),
                              child: ListView(
                                children: [
                                  Text(
                                    data.name,
                                    style: const TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Mulish'),
                                  ),
                                  Text(
                                    '\u{20B9}${data.sizes[data.sizes.keys.elementAt(selectedSize)]}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Mulish'),
                                  ),
                                  const SizedBox(
                                    height: 11,
                                  ),
                                  Row(
                                    children: [
                                      Container(
                                        height: 16,
                                        width: MediaQuery.of(context).size.width*0.09,
                                        decoration: BoxDecoration(
                                          color: ColorConstant.mainOrange,
                                          borderRadius: BorderRadius.circular(8)
                                        ),
                                        child: const Row(
                                          mainAxisAlignment: MainAxisAlignment.center,
                                          crossAxisAlignment: CrossAxisAlignment.center,
                                          children: [
                                            Icon(Icons.star, size: 11, color: Colors.white,),
                                            Text('4.8', style: TextStyle(
                                                fontSize: 10,
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Mulish'),)
                                          ],
                                        ),
                                      ),
                                      Text(
                                        ' (320 Review)',
                                        style: TextStyle(
                                            fontSize: 11,
                                            color: ColorConstant.darkGrey,
                                            fontFamily: 'Mulish'),
                                      )
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 21,
                                  ),
                                  const Text(
                                    'Color',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Mulish'),
                                  ),
                                  SizedBox(
                                    height: MediaQuery.of(context).size.height*0.055,
                                    child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        shrinkWrap: true,
                                        itemCount: data.colors.length,
                                        itemBuilder: (_,index){
                                          return InkWell(
                                            onTap: (){
                                              selectedColor = index;
                                              setState((){});
                                            },
                                            child: Container(
                                              margin: const EdgeInsets.only(right: 14),
                                              width: MediaQuery.of(context).size.height*0.055-10,
                                              height: MediaQuery.of(context).size.height*0.055-10,
                                              decoration:
                                              BoxDecoration(
                                                  border: Border.all(
                                                      color: ColorConstant.fromHex(data.colors![index])
                                                  ), shape: BoxShape.circle),
                                              child: Container(
                                                  margin: selectedColor == index ? const EdgeInsets.all(2) : EdgeInsets.zero,
                                                  decoration: BoxDecoration(shape: BoxShape.circle, color: ColorConstant.fromHex(data.colors[index]))
                                              ),
                                            ),
                                          );
                                        }),
                                  ),
                                  const SizedBox(
                                    height: 7,
                                  ),
                                  Text(
                                    '${data.desc}',
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                        color: ColorConstant.darkGrey,
                                        fontFamily: 'Mulish'),
                                  ),
                                ],
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                margin: const EdgeInsets.all(16),
                                height: 70,
                                decoration: BoxDecoration(
                                    color: Colors.black,
                                    borderRadius: BorderRadius.circular(35)),
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Container(
                                        margin: const EdgeInsets.all(7),
                                        width: MediaQuery.of(context).size.width *
                                            0.28,
                                        height: double.infinity,
                                        decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(35),
                                            border: Border.all(
                                                width: 2, color: Colors.white)),
                                        child: Padding(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: (){
                                                  if(quantity>1){
                                                    quantity--;
                                                    setState((){});
                                                  }
                                                },
                                                child: const Icon(
                                                  Icons.remove,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              ),
                                              Text(
                                                '$quantity',
                                                style: const TextStyle(
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.white,
                                                    fontFamily: 'Mulish'),
                                              ),
                                              InkWell(
                                                onTap: (){
                                                  quantity++;
                                                  setState((){});
                                                },
                                                child: const Icon(
                                                  Icons.add,
                                                  color: Colors.white,
                                                  size: 16,
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Add to Cart'),
                                        style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                ColorConstant.mainOrange,
                                            foregroundColor: Colors.white,
                                            textStyle: const TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Mulish'),
                                            minimumSize: Size(
                                                MediaQuery.of(context).size.width *
                                                    0.49,
                                                double.infinity)),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                            Align(
                              alignment: Alignment.topRight,
                              child: Container(
                                decoration:
                                BoxDecoration(
                                  color: Colors.black.withOpacity(0.8),
                                  borderRadius: BorderRadius.circular((MediaQuery.of(context).size.height*0.055)/2),
                                    ),
                                margin: const EdgeInsets.only(top: 21, right: 14,),
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                width: MediaQuery.of(context).size.height*0.055,
                                child: ListView.builder(
                                    scrollDirection: Axis.vertical,
                                    shrinkWrap: true,
                                    itemCount: data.sizes.length,
                                    itemBuilder: (_,index){
                                      return InkWell(
                                        onTap: (){
                                          selectedSize = index;
                                          setState(() {

                                          });
                                        },
                                        child: Container(
                                          margin: const EdgeInsets.symmetric(vertical: 5),
                                          width: MediaQuery.of(context).size.height*0.055-10,
                                          height: MediaQuery.of(context).size.height*0.055-10,
                                          decoration:
                                          const BoxDecoration(shape: BoxShape.circle),
                                          child: Container(
                                            child: Center(child: Text('${data.sizes.keys.elementAt(index)}', style: TextStyle(
                                                fontSize: 14,
                                                color: index==selectedSize ? Colors.white : Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Mulish'),)),
                                              decoration: BoxDecoration(shape: BoxShape.circle, color: index==selectedSize ? ColorConstant.mainOrange : Colors.white)
                                          ),
                                        ),
                                      );
                                    }),
                              ),
                            )
                          ],
                        ));
                      }
                    )
                  ],
                );
              } else {
                return Container();
              }
            } else if (snapshot.hasError) {
              return Center(
                child: Text('${snapshot.error}'),
              );
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: ColorConstant.mainOrange,
                ),
              );
            }
          }),
    ));
  }
}
