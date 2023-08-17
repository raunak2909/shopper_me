import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shopper_me/app_widgets/round_icon_widget.dart';

import '../../app_widgets/product_widget.dart';
import '../../firebase/firebase_provider.dart';
import '../../models/product_model.dart';
import '../../utils/color_constant.dart';
import '../../utils/image_constant.dart';

class AllProductsPage extends StatefulWidget {
  const AllProductsPage({super.key});

  @override
  State<AllProductsPage> createState() => _AllProductsPageState();
}

class _AllProductsPageState extends State<AllProductsPage> {
  late Stream<QuerySnapshot<Object?>> productStream;

  @override
  void initState() {
    super.initState();
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
                  preferredSize: const Size(double.infinity, 100),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(onTap: (){
                        Navigator.pop(context);
                      },
                          child: RoundIconWidget(img: ImageConstant.app_drawer)),
                    ],
                  )),
              const SizedBox(
                height: 21,
              ),
              Expanded(
                child: StreamBuilder<QuerySnapshot<Object?>>(
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
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                mainAxisSpacing: 11,
                                childAspectRatio: 5 / 6,
                                crossAxisSpacing: 11),
                            itemCount: arrProducts.length,
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemBuilder: (_, index) {
                              return ProductWidget(
                                name: arrProducts[index].name,
                                imgUrl: arrProducts[index].images[0],
                                price:
                                arrProducts[index].price.toString(),
                                colorHex: arrProducts[index].colors,
                              );
                            });
                      } else if (snapshot.hasError) {
                        return const Text('Error Loading Categories');
                      } else {
                        return CircularProgressIndicator(
                          color: ColorConstant.mainOrange,
                        );
                      }
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
