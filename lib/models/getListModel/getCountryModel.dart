// To parse this JSON data, do
//
//     final getCountryListModel = getCountryListModelFromJson(jsonString);

import 'dart:convert';

GetCountryListModel getCountryListModelFromJson(String str) => GetCountryListModel.fromJson(json.decode(str));

String getCountryListModelToJson(GetCountryListModel data) => json.encode(data.toJson());

class GetCountryListModel {
  GetCountryListModel({
    this.code,
    this.result,
  });

  int code;
  List<Result> result;

  factory GetCountryListModel.fromJson(Map<String, dynamic> json) => GetCountryListModel(
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
    this.resultId,
    this.country,
    this.etScore,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int userId;
  int resultId;
  String country;
  int etScore;
  int createdAt;
  int createdBy;
  int updatedAt;
  int updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    resultId: json["id"],
    country: json["country"],
    etScore: json["etScore"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    updatedAt: json["updatedAt"] == null ? null : json["updatedAt"],
    updatedBy: json["updatedBy"] == null ? null : json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "id": resultId,
    "country": country,
    "etScore": etScore,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "updatedAt": updatedAt == null ? null : updatedAt,
    "updatedBy": updatedBy == null ? null : updatedBy,
  };
}
