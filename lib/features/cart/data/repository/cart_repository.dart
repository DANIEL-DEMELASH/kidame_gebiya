import 'package:kidame_gebiya/core/dio/dio_client.dart';
import 'package:kidame_gebiya/core/dio/dio_config.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';
import 'package:kidame_gebiya/features/user/data/models/user_model.dart';
import 'package:kidame_gebiya/features/user/data/repository/user_repository.dart';

class CartRepository {
  final DioClient dioClient;
  
  CartRepository(this.dioClient);
  
  Future<List<CartModel>> getUserCarts () async {
    UserRepository userRepository = getIt<UserRepository>();
    final User user = await userRepository.getUser();
    final int userId = user.id;
    
    final response = await dioClient.client.get("${DioConfig.userCarts}/$userId");
    
    if(response.statusCode == 200 || response.statusCode == 201){
      final List<dynamic> fetchedCarts = (response.data) as List<dynamic>;
      final List<CartModel> cartsList = fetchedCarts.map((cartData) => CartModel.fromJson(cartData)).toList();
      return cartsList;
    }else{
      throw Exception('Error loading user carts ${response.statusCode} ${response.statusMessage}');
    }
  }
}