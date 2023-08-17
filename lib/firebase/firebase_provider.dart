import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopper_me/models/product_model.dart';

class FirebaseProvider {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  addProducts() {
    for (int i = 0; i < 11; i++) {
      firestore.collection('products').add(ProductModel(
          "1",
          "1",
          ["#ff660e", "#000000", "#ff0000", "#00ff00", "#0000ff"],
          "Lion Printed Shirt",
          "10",
          [
            "https://i.pinimg.com/originals/4b/e1/01/4be101b42cb649e3655ded44a9669981.png",
            "https://electrothreads.com/cdn/shop/products/into-the-darkness-lion-unisex-shirt-t-shirts-collectiontitle-479366_1800x.png?v=1571438687",
            "https://i.pinimg.com/originals/4b/e1/01/4be101b42cb649e3655ded44a9669981.png",
            "https://electrothreads.com/cdn/shop/products/into-the-darkness-lion-unisex-shirt-t-shirts-collectiontitle-479366_1800x.png?v=1571438687",
            "https://i.pinimg.com/originals/4b/e1/01/4be101b42cb649e3655ded44a9669981.png",
          ],
          "Lion Shirt",
          "1099",
          "${i+1}",
          {"L": "1199", "M": "999", "R": "1099", "S": "899", "XL": "1299"})
          .toMap());
    }

    for(int i=11; i<21;i++){

      firestore.collection('products').add(ProductModel(
          "1",
          "1",
          ["#ff0000", "#00ff00"],
          "Lion Printed Shirt Type 2",
          "20",
          [
            "https://electrothreads.com/cdn/shop/products/into-the-darkness-lion-unisex-shirt-t-shirts-collectiontitle-479366_1800x.png?v=1571438687",
            "https://i.pinimg.com/originals/4b/e1/01/4be101b42cb649e3655ded44a9669981.png",
            "https://electrothreads.com/cdn/shop/products/into-the-darkness-lion-unisex-shirt-t-shirts-collectiontitle-479366_1800x.png?v=1571438687",
            "https://i.pinimg.com/originals/4b/e1/01/4be101b42cb649e3655ded44a9669981.png",
            "https://electrothreads.com/cdn/shop/products/into-the-darkness-lion-unisex-shirt-t-shirts-collectiontitle-479366_1800x.png?v=1571438687",
            "https://i.pinimg.com/originals/4b/e1/01/4be101b42cb649e3655ded44a9669981.png",
            "https://electrothreads.com/cdn/shop/products/into-the-darkness-lion-unisex-shirt-t-shirts-collectiontitle-479366_1800x.png?v=1571438687",
          ],
          "Lion Shirt 2",
          "1599",
          "${i+1}",
          {
            "L": "1699",
            "M": "1499",
            "R": "1599",
            "S": "1399",
            "XL": "1799"
          }).toMap());
    }
  }

  Stream<QuerySnapshot<Object?>> getBanners() {
    CollectionReference banners = firestore.collection('banners');
    return banners.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getCategories() {
    CollectionReference category = firestore.collection('category');
    return category.snapshots();
  }

  Stream<QuerySnapshot<Object?>> getProductDetail(String productId) {
    CollectionReference product = firestore.collection('products');
    return product.where('product_id', isEqualTo: productId).snapshots();
  }

  Stream<QuerySnapshot<Object?>> getAllProducts() {
    CollectionReference products = firestore.collection('products');

    return products.limit(5).snapshots();
  }
}
