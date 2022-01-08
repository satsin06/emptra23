// To parse this JSON data, do
//
//     final getPhotos = getPhotosFromJson(jsonString);

import 'dart:convert';

GetPhotos getPhotosFromJson(String str) => GetPhotos.fromJson(json.decode(str));

String getPhotosToJson(GetPhotos data) => json.encode(data.toJson());

class GetPhotos {
  GetPhotos({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetPhotos.fromJson(Map<String, dynamic> json) => GetPhotos(
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
    this.images,
    this.status,
    this.createdAt,
    this.createdBy,
  });

  String id;
  int userId;
  List<String> images;
  String status;
  int createdAt;
  dynamic createdBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    images: List<String>.from(json["images"].map((x) => x)),
    status: json["status"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "images": List<dynamic>.from(images.map((x) => x)),
    "status": status,
    "createdAt": createdAt,
    "createdBy": createdBy,
  };
}
