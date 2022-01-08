class GetCovidVaccineModel {
  int code;
  List<Result> result;

  GetCovidVaccineModel({this.code, this.result});

  GetCovidVaccineModel.fromJson(Map<String, dynamic> json) {
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
  String vaccineName;
  String vaccineDate;
  int vaccineDose;
  String type;
  String status;
  int vaccineId;
  String createdAt;

  Result(
      {this.sId,
        this.userId,
        this.vaccineName,
        this.vaccineDate,
        this.vaccineDose,
        this.type,
        this.status,
        this.vaccineId,
        this.createdAt});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    vaccineName = json['vaccineName'];
    vaccineDate = json['vaccineDate'];
    vaccineDose = json['vaccineDose'];
    type = json['type'];
    status = json['status'];
    vaccineId = json['vaccineId'];
    createdAt = json['createdAt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['vaccineName'] = this.vaccineName;
    data['vaccineDate'] = this.vaccineDate;
    data['vaccineDose'] = this.vaccineDose;
    data['type'] = this.type;
    data['status'] = this.status;
    data['vaccineId'] = this.vaccineId;
    data['createdAt'] = this.createdAt;
    return data;
  }
}
