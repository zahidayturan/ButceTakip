class OperationToolModel {

  int id;
  String name;
  String? description;
  String createdAt;

  OperationToolModel({
    required this.id,
    required this.name,
    this.description,
    required this.createdAt
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['id'] = id;
    map['name'] = name;
    map['description'] = description;
    return map;
  }

  factory OperationToolModel.fromObject(dynamic o) {
    return OperationToolModel(
      id: o['id'],
      name: o['name'],
      description: o['description'],
      createdAt: o['createdAt'],
    );
  }

  dynamic fromCsvValue(String value) {
    return value;
  }

  factory OperationToolModel.fromCVSObject(List<dynamic> o) {
    return OperationToolModel(
        id: o[0],
        name: o[1],
        createdAt: o[2]
    );
  }
}