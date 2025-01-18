import 'package:dio/dio.dart';

String getErrorMessage(DioException err) {
    dynamic message;
    
    switch(err.type){
      case DioExceptionType.connectionTimeout:
        message = 'Connection timed out. Please check your internet connection and try again.';
        break;

      case DioExceptionType.receiveTimeout:
        message = 'Server response timed out. Please try again later.';
        break;
        
      case DioExceptionType.sendTimeout:
        message = 'Send timed out. Please try again later.';
        break;

      case DioExceptionType.connectionError:
        message = "Connection error. Please enable your internet connection and try again";
        break;
        
      case DioExceptionType.cancel:
        message = 'Request to the server was cancelled.';
        break;

      case DioExceptionType.badResponse:
        if (message is List && message.isNotEmpty) {
          message = ' ${message[0]}';
        } else {
          message = '${err.response?.data['message'] ?? err.response?.data['error'] ?? 'Unexpected error occurred.'}';
        }
        break;

      case DioExceptionType.badCertificate:
        message = "Bad certificate";
        break;
        
      default:
        if(err.response?.statusCode == 401){
          message = err.response?.data; 
        }else{
          message = 'Something went wrong. Please try again.';  
        }
        break;
    }
    
    return message;
  }