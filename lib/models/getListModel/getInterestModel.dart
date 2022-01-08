// To parse this JSON data, do
//
//     final getInterestHistoryModel = getInterestHistoryModelFromJson(jsonString);

import 'dart:convert';

GetInterestHistoryModel getInterestHistoryModelFromJson(String str) => GetInterestHistoryModel.fromJson(json.decode(str));

String getInterestHistoryModelToJson(GetInterestHistoryModel data) => json.encode(data.toJson());

class GetInterestHistoryModel {
  GetInterestHistoryModel({
    this.code,
    this.result,
  });

  int code;
  Result result;

  factory GetInterestHistoryModel.fromJson(Map<String, dynamic> json) => GetInterestHistoryModel(
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
    this.interests,
    this.updatedAt,
    this.createdAt,
    this.createdBy,
    this.updatedBy,
  });

  String id;
  int userId;
  Interests interests;
  int updatedAt;
  int createdAt;
  dynamic createdBy;
  dynamic updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    interests: Interests.fromJson(json["interests"]),
    updatedAt: json["updatedAt"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "interests": interests.toJson(),
    "updatedAt": updatedAt,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "updatedBy": updatedBy,
  };
}

class Interests {
  Interests({
    this.hobbies,
    this.music,
    this.tvShows,
    this.books,
    this.movies,
    this.writers,
    this.games,
    this.others,
    this.etScore,
  });

  String hobbies;
  String music;
  String tvShows;
  String books;
  String movies;
  String writers;
  String games;
  String others;
  int etScore;

  factory Interests.fromJson(Map<String, dynamic> json) => Interests(
    hobbies: json["hobbies"],
    music: json["music"],
    tvShows: json["tvShows"],
    books: json["books"],
    movies: json["movies"],
    writers: json["writers"],
    games: json["games"],
    others: json["others"],
    etScore: json["etScore"],
  );

  Map<String, dynamic> toJson() => {
    "hobbies": hobbies,
    "music": music,
    "tvShows": tvShows,
    "books": books,
    "movies": movies,
    "writers": writers,
    "games": games,
    "others": others,
    "etScore": etScore,
  };
}
