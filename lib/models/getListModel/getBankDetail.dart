// To parse this JSON data, do
//
//     final getBankDetail = getBankDetailFromJson(jsonString);

import 'dart:convert';

GetBankDetail getBankDetailFromJson(String str) => GetBankDetail.fromJson(json.decode(str));

String getBankDetailToJson(GetBankDetail data) => json.encode(data.toJson());

class GetBankDetail {
  GetBankDetail({
    this.code,
    this.result,
  });

  int code;
  List<Result> result;

  factory GetBankDetail.fromJson(Map<String, dynamic> json) => GetBankDetail(
    code: json["code"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.userName,
    this.bankName,
    this.bankAccount,
    this.ifsc,
    this.city,
    this.branch,
    this.status,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int userId;
  String userName;
  String bankName;
  String bankAccount;
  String ifsc;
  String city;
  String branch;
  String status;
  int createdAt;
  dynamic createdBy;
  int updatedAt;
  dynamic updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    userName: json["userName"],
    bankName: json["bankName"],
    bankAccount: json["bankAccount"],
    ifsc: json["ifsc"],
    city: json["city"],
    branch: json["branch"],
    status: json["status"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    updatedAt: json["updatedAt"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "userName": userName,
    "bankName": bankName,
    "bankAccount": bankAccount,
    "ifsc": ifsc,
    "city": city,
    "branch": branch,
    "status": status,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
  };
}
