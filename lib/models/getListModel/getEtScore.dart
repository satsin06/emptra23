// To parse this JSON data, do
//
//     final getEtScore = getEtScoreFromJson(jsonString);

import 'dart:convert';

GetEtScore getEtScoreFromJson(String str) => GetEtScore.fromJson(json.decode(str));

String getEtScoreToJson(GetEtScore data) => json.encode(data.toJson());

class GetEtScore {
  GetEtScore({
    this.code,
    this.etScore,
  });

  int code;
  int etScore;

  factory GetEtScore.fromJson(Map<String, dynamic> json) => GetEtScore(
    code: json["code"],
    etScore: json["etScore"],
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "etScore": etScore,
  };
}
