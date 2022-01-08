// To parse this JSON data, do
//
//     final getIndustrySkillsHistoryModel = getIndustrySkillsHistoryModelFromJson(jsonString);

import 'dart:convert';

GetIndustrySkillsHistoryModel getIndustrySkillsHistoryModelFromJson(String str) => GetIndustrySkillsHistoryModel.fromJson(json.decode(str));

String getIndustrySkillsHistoryModelToJson(GetIndustrySkillsHistoryModel data) => json.encode(data.toJson());

class GetIndustrySkillsHistoryModel {
  GetIndustrySkillsHistoryModel({
    this.code,
    this.result,
    this.userId,
  });

  int code;
  List<Result> result;
  String userId;

  factory GetIndustrySkillsHistoryModel.fromJson(Map<String, dynamic> json) => GetIndustrySkillsHistoryModel(
    code: json["code"],
    result: List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
    userId: json["userId"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "result": List<dynamic>.from(result.map((x) => x.toJson())),
    "userId": userId,
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.industryName,
    this.rating,
    this.etScore,
    this.industryId,
    this.createdAt,
  });

  String id;
  int userId;
  String industryName;
  int rating;
  int etScore;
  int industryId;
  DateTime createdAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    industryName: json["industryName"],
    rating: json["rating"],
    etScore: json["etScore"],
    industryId: json["industryId"],
    createdAt: DateTime.parse(json["createdAt"]),
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "industryName": industryName,
    "rating": rating,
    "etScore": etScore,
    "industryId": industryId,
    "createdAt": createdAt.toIso8601String(),
  };
}
