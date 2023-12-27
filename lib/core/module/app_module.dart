import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:test_app_project/core/config/dio_config.dart';

@module
abstract class AppModule {

  @lazySingleton
  Dio get dio => DioConfig.dio();

}
