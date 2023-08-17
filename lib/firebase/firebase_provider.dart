import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseProvider{

  FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<QuerySnapshot<Object?>> getBanners(){
    CollectionReference banners = firestore.collection('banners');
    return banners.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getCategories(){
    CollectionReference category = firestore.collection('category');
    return category.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getAllProducts(){
    CollectionReference products = firestore
        .collection('category')
        .doc('E0whr1fV8mhHS50MOrgT')
        .collection('sub_cat')
        .doc('Shirts').collection('products');
    
    

    return products.snapshots();
  }


}