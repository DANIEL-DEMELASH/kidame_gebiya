import 'package:kidame_gebiya/core/dio/dio_client.dart';
import 'package:kidame_gebiya/core/dio/dio_config.dart';
import 'package:kidame_gebiya/features/user/data/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserRepository {
  final DioClient dioClient;
  
  UserRepository(this.dioClient);
  
  Future<User> getUser () async {
    final response = await dioClient.client.get(DioConfig.users);
    
    if(response.statusCode == 200 || response.statusCode == 201){
      final List<dynamic> fetchedUsers = (response.data) as List<dynamic>;
      final List<User> usersList = fetchedUsers.map((userData) =>
                User.fromJson(userData as Map<String, dynamic>)).toList();
      
      SharedPreferences prefs = await SharedPreferences.getInstance();
      final User user = usersList.firstWhere((user) => user.username == prefs.getString("username"));
      return user;
    }else{
      throw Exception('Error loading user ${response.statusCode} ${response.statusMessage}');
    }
  }
  
}