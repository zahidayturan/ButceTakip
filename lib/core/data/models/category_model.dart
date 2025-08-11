class CategoryModel {

  int id;
  String name;
  String type; //Income or Expense
  String createdAt;

  CategoryModel({
    required this.id,
    required this.name,
    required this.type,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['type'] = type;
    return map;
  }

  factory CategoryModel.fromObject(dynamic o) {
    return CategoryModel(
      id: o['id'],
      name: o['name'],
      type: o['type'],
      createdAt: o['createdAt'],
    );
  }

  dynamic fromCsvValue(String value) {
    return value;
  }

  factory CategoryModel.fromCVSObject(List<dynamic> o) {
    return CategoryModel(
        id: o[0],
        name: o[1],
        type: o[2],
        createdAt: o[3]
    );
  }
}