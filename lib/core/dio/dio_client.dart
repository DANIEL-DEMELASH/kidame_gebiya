import 'package:dio/dio.dart';
import 'package:kidame_gebiya/core/dio/dio_config.dart';
import 'package:kidame_gebiya/core/dio/interceptors/auth_interceptor.dart';
import 'package:kidame_gebiya/core/dio/interceptors/error_interceptor.dart';
import 'package:kidame_gebiya/core/dio/interceptors/logging_interceptor.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

class DioClient {
  late final Dio _dio;
  
  DioClient(){
    _dio = Dio(BaseOptions(
      baseUrl: DioConfig.baseUrl,
      connectTimeout: const Duration(seconds: DioConfig.connectTimeout),
      receiveTimeout: const Duration(seconds: DioConfig.receiveTimeout),
      sendTimeout: const Duration(seconds: DioConfig.sendTimeout),
    ));
    
    _dio.interceptors.add(AuthInterceptor());
    _dio.interceptors.add(ErrorInterceptor());
    _dio.interceptors.add(LoggingInterceptor());
    
    _dio.interceptors.add(
      PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
        responseBody: true,
        error: true,
        compact: true,
      )
    );
  }
  
  
  Dio get client => _dio;
}