class ProductModel {
  List<dynamic> colors;
  String desc;
  String discount;
  List<dynamic> images;
  String name;
  String price;
  String product_id;
  Map<String, dynamic> sizes;

  ProductModel(this.colors, this.desc, this.discount, this.images, this.name,
      this.price, this.product_id, this.sizes);

  factory ProductModel.fromMap(Map<String, dynamic> map) {
    return ProductModel(
        map['colors'],
        map['desc'],
        map['discount'],
        map['images'],
        map['name'],
        map['price'],
        map['product_id'],
        map['sizes']);
  }
}
