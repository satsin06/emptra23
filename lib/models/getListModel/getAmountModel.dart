// To parse this JSON data, do
//
//     final getCredit = getCreditFromJson(jsonString);

import 'dart:convert';

GetCredit getCreditFromJson(String str) => GetCredit.fromJson(json.decode(str));

String getCreditToJson(GetCredit data) => json.encode(data.toJson());

class GetCredit {
  GetCredit({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetCredit.fromJson(Map<String, dynamic> json) => GetCredit(
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
    this.createdAt,
    this.bgcPlan,
    this.updatedAt,
  });

  String id;
  int userId;
  int creditPoints;
  int createdAt;
  dynamic bgcPlan;
  int updatedAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    creditPoints: json["creditPoints"],
    createdAt: json["createdAt"],
    bgcPlan: json["bgcPlan"],
    updatedAt: json["updatedAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "creditPoints": creditPoints,
    "createdAt": createdAt,
    "bgcPlan": bgcPlan,
    "updatedAt": updatedAt,
  };
}
