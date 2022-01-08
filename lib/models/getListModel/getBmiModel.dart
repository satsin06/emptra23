// To parse this JSON data, do
//
//     final getBmiModel = getBmiModelFromJson(jsonString);

import 'dart:convert';

GetBmiModel getBmiModelFromJson(String str) => GetBmiModel.fromJson(json.decode(str));

String getBmiModelToJson(GetBmiModel data) => json.encode(data.toJson());

class GetBmiModel {
  GetBmiModel({
    this.code,
    this.bmi,
    this.message,
    this.result,
  });

  int code;
  String bmi;
  String message;
  Result result;

  factory GetBmiModel.fromJson(Map<String, dynamic> json) => GetBmiModel(
    code: json["code"],
    bmi: json["bmi"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "bmi": bmi,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.weight,
    this.height,
    this.bmi,
    this.bmiId,
    this.createdAt,
    this.updated,
  });

  String id;
  int userId;
  int weight;
  double height;
  String bmi;
  int bmiId;
  DateTime createdAt;
  int updated;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    weight: json["weight"],
    height: json["height"].toDouble(),
    bmi: json["bmi"],
    bmiId: json["bmiId"],
    createdAt: DateTime.parse(json["createdAt"]),
    updated: json["updated"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "weight": weight,
    "height": height,
    "bmi": bmi,
    "bmiId": bmiId,
    "createdAt": createdAt.toIso8601String(),
    "updated": updated,
  };
}
