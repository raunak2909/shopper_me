class CategoryModel{
  String cat_id;
  String cat_name;
  String img;

  CategoryModel(this.cat_id, this.cat_name, this.img);

  factory CategoryModel.fromMap(Map<String, dynamic> map){
    return CategoryModel(map['cat_id'], map['cat_name'], map['img']);
  }
}