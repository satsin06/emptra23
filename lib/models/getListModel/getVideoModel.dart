// To parse this JSON data, do
//
//     final getVideoModel = getVideoModelFromJson(jsonString);

import 'dart:convert';

GetVideoModel getVideoModelFromJson(String str) => GetVideoModel.fromJson(json.decode(str));

String getVideoModelToJson(GetVideoModel data) => json.encode(data.toJson());

class GetVideoModel {
  GetVideoModel({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetVideoModel.fromJson(Map<String, dynamic> json) => GetVideoModel(
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
    this.videos,
    this.createdAt,
  });

  String id;
  int userId;
  Videos videos;
  int createdAt;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    videos: Videos.fromJson(json["videos"]),
    createdAt: json["createdAt"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "videos": videos.toJson(),
    "createdAt": createdAt,
  };
}

class Videos {
  Videos({
    this.video1,
    this.video2,
    this.video3,
    this.video4,
    this.video5,
    this.video6,
    this.etScore,
  });

  String video1;
  String video2;
  String video3;
  String video4;
  String video5;
  String video6;
  int etScore;

  factory Videos.fromJson(Map<String, dynamic> json) => Videos(
    video1: json["video1"],
    video2: json["video2"],
    video3: json["video3"],
    video4: json["video4"],
    video5: json["video5"],
    video6: json["video6"],
    etScore: json["etScore"],
  );

  Map<String, dynamic> toJson() => {
    "video1": video1,
    "video2": video2,
    "video3": video3,
    "video4": video4,
    "video5": video5,
    "video6": video6,
    "etScore": etScore,
  };
}
