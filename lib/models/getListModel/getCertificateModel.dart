class GetCertificateModel {
  int code;
  List<Result> result;

  GetCertificateModel({this.code, this.result});

  GetCertificateModel.fromJson(Map<String, dynamic> json) {
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
  String certificateName;
  String organizationName;
  String dateFrom;
  String dateTo;
  String description;
  String status;
  int organizationId;
  String createdAt;
  Null comment;
  String docUrl;
  int updatedAt;
  String uploadedStatus;

  Result(
      {this.sId,
        this.userId,
        this.certificateName,
        this.organizationName,
        this.dateFrom,
        this.dateTo,
        this.description,
        this.status,
        this.organizationId,
        this.createdAt,
        this.comment,
        this.docUrl,
        this.updatedAt,
        this.uploadedStatus});

  Result.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    certificateName = json['certificateName'];
    organizationName = json['organizationName'];
    dateFrom = json['dateFrom'];
    dateTo = json['dateTo'];
    description = json['description'];
    status = json['status'];
    organizationId = json['organizationId'];
    createdAt = json['createdAt'];
    comment = json['comment'];
    docUrl = json['docUrl'];
    updatedAt = json['updatedAt'];
    uploadedStatus = json['uploadedStatus'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['userId'] = this.userId;
    data['certificateName'] = this.certificateName;
    data['organizationName'] = this.organizationName;
    data['dateFrom'] = this.dateFrom;
    data['dateTo'] = this.dateTo;
    data['description'] = this.description;
    data['status'] = this.status;
    data['organizationId'] = this.organizationId;
    data['createdAt'] = this.createdAt;
    data['comment'] = this.comment;
    data['docUrl'] = this.docUrl;
    data['updatedAt'] = this.updatedAt;
    data['uploadedStatus'] = this.uploadedStatus;
    return data;
  }
}
