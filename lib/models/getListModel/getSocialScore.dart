class GetSocialScore {
  int code;
  String userId;
  int socialScore;

  GetSocialScore({this.code, this.userId, this.socialScore});

  GetSocialScore.fromJson(Map<String, dynamic> json) {
    code = json['code'];
    userId = json['userId'];
    socialScore = json['socialScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['code'] = this.code;
    data['userId'] = this.userId;
    data['socialScore'] = this.socialScore;
    return data;
  }
}
