

import 'package:dio/dio.dart';


class ApiUtils {
  static postApi(String url, var options, var data) async {
    var dio = Dio();
     return await dio.post(
       url,
      options: options,
      data: data,
    );
  }
}
