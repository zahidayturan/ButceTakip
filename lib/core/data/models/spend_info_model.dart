class SpendInfoModel {
  int? id;
  String? operationType; // Income or Expense
  int? categoryId;
  int? operationToolId;
  bool? isRegistered;
  double? amount;
  String? note;
  String? operationDate;
  String? createdAt;

  SpendInfoModel({
    this.id,
    this.operationType,
    this.categoryId,
    this.operationToolId,
    this.isRegistered,
    this.amount,
    this.note,
    this.operationDate,
    this.createdAt,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{};
    map['operationType'] = operationType;
    map['categoryId'] = categoryId;
    map['operationToolId'] = operationToolId;
    map['isRegistered'] = isRegistered;
    map['amount'] = amount;
    map['note'] = note;
    map['operationDate'] = operationDate;
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }

  factory SpendInfoModel.fromObject(dynamic o) {
    return SpendInfoModel(
      id: o['id'],
      operationType: o['operationType'],
      categoryId: o['categoryId'],
      operationToolId: o['operationToolId'],
      isRegistered: o['isRegistered'],
      amount: o['amount'],
      note: o['note'],
      operationDate: o['operationDate'],
      createdAt: o['createdAt'],
    );
  }

  dynamic fromCsvValue(String value) {
    return value;
  }

  factory SpendInfoModel.fromCVSObject(List<dynamic> o) {
    return SpendInfoModel(

    );
  }
}