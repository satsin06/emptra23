// To parse this JSON data, do
//
//     final getCreditModel = getCreditModelFromJson(jsonString);

import 'dart:convert';

GetCreditModel getCreditModelFromJson(String str) => GetCreditModel.fromJson(json.decode(str));

String getCreditModelToJson(GetCreditModel data) => json.encode(data.toJson());

class GetCreditModel {
  GetCreditModel({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetCreditModel.fromJson(Map<String, dynamic> json) => GetCreditModel(
    code: json["code"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.creditPoints,
    this.bgcPlan,
    this.createdAt,
    this.createdBy,
  });

  String id;
  int userId;
  int creditPoints;
  dynamic bgcPlan;
  int createdAt;
  dynamic createdBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    creditPoints: json["creditPoints"],
    bgcPlan: json["bgcPlan"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "creditPoints": creditPoints,
    "bgcPlan": bgcPlan,
    "createdAt": createdAt,
    "createdBy": createdBy,
  };
}
