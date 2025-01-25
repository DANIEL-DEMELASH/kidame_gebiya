import 'package:kidame_gebiya/core/dio/dio_client.dart';
import 'package:kidame_gebiya/core/dio/dio_config.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';

class ProductRepository {
  final DioClient dioClient;
  
  ProductRepository(this.dioClient);
  
  Future<List<ProductModel>> getAllProducts () async {
    final response = await dioClient.client.get(DioConfig.allProducts);
    
    if(response.statusCode == 200 || response.statusCode == 201){
      final List<dynamic> fetchedProducts = (response.data) as List<dynamic>;
      final List<ProductModel> productList = fetchedProducts.map((productData) =>
                ProductModel.fromJson(productData as Map<String, dynamic>)).toList();
      return productList;
    }else{
      throw Exception('Error loading products ${response.statusCode} ${response.statusMessage}');
    }
  }
  
  Future<List<ProductModel>> getProductsByCategory (String productCategory) async {
    final response = await dioClient.client.get("${DioConfig.productByCategory}/$productCategory");
    
    if(response.statusCode == 200 || response.statusCode == 201){
      final List<dynamic> fetchedProducts = (response.data) as List<dynamic>;
      final List<ProductModel> productList = fetchedProducts.map((productData) =>
                ProductModel.fromJson(productData as Map<String, dynamic>)).toList();
      return productList;
    }else{
      throw Exception('Error loading products ${response.statusCode} ${response.statusMessage}');
    }
  }
  
  
}