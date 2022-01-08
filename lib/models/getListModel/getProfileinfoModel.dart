// To parse this JSON data, do
//
//     final getPersonalInfoHistoryModel = getPersonalInfoHistoryModelFromJson(jsonString);

import 'dart:convert';

GetPersonalInfoHistoryModel getPersonalInfoHistoryModelFromJson(String str) => GetPersonalInfoHistoryModel.fromJson(json.decode(str));

String getPersonalInfoHistoryModelToJson(GetPersonalInfoHistoryModel data) => json.encode(data.toJson());

class GetPersonalInfoHistoryModel {
  GetPersonalInfoHistoryModel({
    this.code,
    this.message,
    this.result,
  });

  int code;
  String message;
  Result result;

  factory GetPersonalInfoHistoryModel.fromJson(Map<String, dynamic> json) => GetPersonalInfoHistoryModel(
    code: json["code"],
    message: json["message"],
    result: Result.fromJson(json["result"]),
  );

  Map<String, dynamic> toJson() => {
    "code": code,
    "message": message,
    "result": result.toJson(),
  };
}

class Result {
  Result({
    this.id,
    this.userId,
    this.section,
    this.action,
    this.personalInfo,
    this.basicSkills,
    this.softSkills,
    this.truLink,
    this.createdAt,
    this.createdBy,
    this.etKey,
    this.isActive,
    this.updatedAt,
    this.updatedBy,
  });

  String id;
  int userId;
  String section;
  String action;
  PersonalInfo personalInfo;
  BasicSkills basicSkills;
  SoftSkills softSkills;
  String truLink;
  int createdAt;
  String createdBy;
  String etKey;
  bool isActive;
  int updatedAt;
  String updatedBy;

  factory Result.fromJson(Map<String, dynamic> json) => Result(
    id: json["_id"],
    userId: json["userId"],
    section: json["section"],
    action: json["action"],
    personalInfo: PersonalInfo.fromJson(json["personalInfo"]),
    basicSkills: BasicSkills.fromJson(json["basicSkills"]),
    softSkills: SoftSkills.fromJson(json["softSkills"]),
    truLink: json["truLink"],
    createdAt: json["createdAt"],
    createdBy: json["createdBy"],
    etKey: json["etKey"],
    isActive: json["isActive"],
    updatedAt: json["updatedAt"],
    updatedBy: json["updatedBy"],
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "userId": userId,
    "section": section,
    "action": action,
    "personalInfo": personalInfo.toJson(),
    "basicSkills": basicSkills.toJson(),
    "softSkills": softSkills.toJson(),
    "truLink": truLink,
    "createdAt": createdAt,
    "createdBy": createdBy,
    "etKey": etKey,
    "isActive": isActive,
    "updatedAt": updatedAt,
    "updatedBy": updatedBy,
  };
}

class BasicSkills {
  BasicSkills({
    this.computerSkills,
    this.msOffice,
    this.basicDesigning,
    this.basicAccounting,
  });

  int computerSkills;
  int msOffice;
  int basicDesigning;
  int basicAccounting;

  factory BasicSkills.fromJson(Map<String, dynamic> json) => BasicSkills(
    computerSkills: json["computerSkills"],
    msOffice: json["msOffice"],
    basicDesigning: json["basicDesigning"],
    basicAccounting: json["basicAccounting"],
  );

  Map<String, dynamic> toJson() => {
    "computerSkills": computerSkills,
    "msOffice": msOffice,
    "basicDesigning": basicDesigning,
    "basicAccounting": basicAccounting,
  };
}

class PersonalInfo {
  PersonalInfo({
    this.personal,
    this.professional,
    this.social,
  });

  Personal personal;
  Professional professional;
  Social social;

  factory PersonalInfo.fromJson(Map<String, dynamic> json) => PersonalInfo(
    personal: Personal.fromJson(json["personal"]),
    professional: Professional.fromJson(json["professional"]),
    social: Social.fromJson(json["social"]),
  );

  Map<String, dynamic> toJson() => {
    "personal": personal.toJson(),
    "professional": professional.toJson(),
    "social": social.toJson(),
  };
}

class Personal {
  Personal({
    this.firstName,
    this.lastName,
    this.email,
    this.mobileNo,
    this.dob,
    this.gender,
    this.industryId,
    this.industryName,
    this.isMarried,
    this.about,
    this.profilePicture,
    this.website,
    this.aadharVerified,
  });

  String firstName;
  String lastName;
  String email;
  String mobileNo;
  String dob;
  String gender;
  int industryId;
  String industryName;
  bool isMarried;
  String about;
  String profilePicture;
  String website;
  bool aadharVerified;

  factory Personal.fromJson(Map<String, dynamic> json) => Personal(
    firstName: json["firstName"],
    lastName: json["lastName"],
    email: json["email"],
    mobileNo: json["mobile_no"],
    dob: json["dob"],
    gender: json["gender"],
    industryId: json["industryId"],
    industryName: json["industryName"],
    isMarried: json["isMarried"],
    about: json["about"],
    profilePicture: json["profilePicture"],
    website: json["website"],
    aadharVerified: json["aadharVerified"],
  );

  Map<String, dynamic> toJson() => {
    "firstName": firstName,
    "lastName": lastName,
    "email": email,
    "mobile_no": mobileNo,
    "dob": dob,
    "gender": gender,
    "industryId": industryId,
    "industryName": industryName,
    "isMarried": isMarried,
    "about": about,
    "profilePicture": profilePicture,
    "website": website,
    "aadharVerified": aadharVerified,
  };
}

class Professional {
  Professional({
    this.occupation,
    this.ctc,
  });

  String occupation;
  String ctc;

  factory Professional.fromJson(Map<String, dynamic> json) => Professional(
    occupation: json["occupation"],
    ctc: json["ctc"],
  );

  Map<String, dynamic> toJson() => {
    "occupation": occupation,
    "ctc": ctc,
  };
}

class Social {
  Social({
    this.facebook,
    this.twitter,
    this.linkedin,
    this.instagram,
  });

  String facebook;
  String twitter;
  String linkedin;
  String instagram;

  factory Social.fromJson(Map<String, dynamic> json) => Social(
    facebook: json["facebook"],
    twitter: json["twitter"],
    linkedin: json["linkedin"],
    instagram: json["instagram"],
  );

  Map<String, dynamic> toJson() => {
    "facebook": facebook,
    "twitter": twitter,
    "linkedin": linkedin,
    "instagram": instagram,
  };
}

class SoftSkills {
  SoftSkills({
    this.englishCommunication,
    this.hindiCommunication,
    this.writingEnglish,
    this.writingHindi,
  });

  int englishCommunication;
  int hindiCommunication;
  int writingEnglish;
  int writingHindi;

  factory SoftSkills.fromJson(Map<String, dynamic> json) => SoftSkills(
    englishCommunication: json["englishCommunication"],
    hindiCommunication: json["hindiCommunication"],
    writingEnglish: json["writingEnglish"],
    writingHindi: json["writingHindi"],
  );

  Map<String, dynamic> toJson() => {
    "englishCommunication": englishCommunication,
    "hindiCommunication": hindiCommunication,
    "writingEnglish": writingEnglish,
    "writingHindi": writingHindi,
  };
}
