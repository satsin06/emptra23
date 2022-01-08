class GetPhysicalBodyModel {
  int code;
  List<Result> result;

  GetPhysicalBodyModel({this.code, this.result});

  GetPhysicalBodyModel.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    if (json['result'] != null) {
      result = new List<Result>();
      json['result'].forEach((v) {
        result.add(new Result.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    if (this.result != null) {
      data['result'] = this.result.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Result {
  String sId;
  int userId;
  String bust;
  String waist;
  String hips;
  String skinTone;
  String eyeColor;
  String hairColor;
  String hairTexture;
  String identificationMark;
  String shoeSize;
  String status;
  int createdAt;
  Null createdBy;

  Result(
      {this.sId,
        this.userId,
        this.bust,
        this.waist,
        this.hips,
        this.skinTone,
        this.eyeColor,
        this.hairColor,
        this.hairTexture,
        this.identificationMark,
        this.shoeSize,
        this.status,
        this.createdAt,
        this.createdBy});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    bust = json['bust'];
    waist = json['waist'];
    hips = json['hips'];
    skinTone = json['skinTone'];
    eyeColor = json['eyeColor'];
    hairColor = json['hairColor'];
    hairTexture = json['hairTexture'];
    identificationMark = json['identificationMark'];
    shoeSize = json['shoeSize'];
    status = json['status'];
    createdAt = json['createdAt'];
    createdBy = json['createdBy'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['bust'] = this.bust;
    data['waist'] = this.waist;
    data['hips'] = this.hips;
    data['skinTone'] = this.skinTone;
    data['eyeColor'] = this.eyeColor;
    data['hairColor'] = this.hairColor;
    data['hairTexture'] = this.hairTexture;
    data['identificationMark'] = this.identificationMark;
    data['shoeSize'] = this.shoeSize;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['createdBy'] = this.createdBy;
    return data;
  }
}
