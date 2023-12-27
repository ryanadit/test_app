import 'package:dio/dio.dart';
import 'package:test_app_project/core/helpers/url_helper.dart';

class DioConfig {

  static Dio dio() {
    final d = Dio();
    d.options.baseUrl = UrlHelper.urlMockApi;
    d.options.connectTimeout = const Duration(milliseconds: 15000);
    d.options.receiveTimeout = const Duration(milliseconds: 15000);
    return d;
  }

}
