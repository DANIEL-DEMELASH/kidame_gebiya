import 'dart:convert';

import 'package:kidame_gebiya/core/dio/dio_client.dart';
import 'package:kidame_gebiya/core/dio/dio_config.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthRepository {
  final DioClient dioClient;
  
  AuthRepository(this.dioClient);
  
  Future<bool?> isValidate(Map<String, dynamic> userData) async {
    final response = await dioClient.client.post(DioConfig.login, data: jsonEncode(userData));
    
    if(response.statusCode == 200){
      SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
      sharedPreferences.setString("token", response.data["token"]);
      return true;  
    }else{
      throw Exception('unknown error');  
    }
    
  }
}