// To parse this JSON data, do
//
//     final getPhotosHistoryModel = getPhotosHistoryModelFromJson(jsonString);

import 'dart:convert';

GetPhotosHistoryModel getPhotosHistoryModelFromJson(String str) => GetPhotosHistoryModel.fromJson(json.decode(str));

String getPhotosHistoryModelToJson(GetPhotosHistoryModel data) => json.encode(data.toJson());

class GetPhotosHistoryModel {
  GetPhotosHistoryModel({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetPhotosHistoryModel.fromJson(Map<String, dynamic> json) => GetPhotosHistoryModel(
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
    this.etId,
    this.photos,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int etId;
  Photos photos;
  int createdAt;
  dynamic createdBy;
  int updatedAt;
  int updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    etId: json["etId"],
    photos: Photos.fromJson(json["photos"]),
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    updatedAt: json["updatedAt"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "etId": etId,
    "photos": photos.toJson(),
    "createdAt": createdAt,
    "createdBy": createdBy,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
  };
}

class Photos {
  Photos({
    this.photos1,
    this.photos2,
    this.photos3,
    this.photos4,
    this.photos5,
    this.photos6,
  });

  String photos1;
  String photos2;
  String photos3;
  String photos4;
  String photos5;
  String photos6;

  factory Photos.fromJson(Map<String, dynamic> json) => Photos(
    photos1: json["photos1"],
    photos2: json["photos2"],
    photos3: json["photos3"],
    photos4: json["photos4"],
    photos5: json["photos5"],
    photos6: json["photos6"],
  );

  Map<String, dynamic> toJson() => {
    "photos1": photos1,
    "photos2": photos2,
    "photos3": photos3,
    "photos4": photos4,
    "photos5": photos5,
    "photos6": photos6,
  };
}
