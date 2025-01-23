import 'package:kidame_gebiya/core/dio/dio_client.dart';
import 'package:kidame_gebiya/core/dio/dio_config.dart';

class CategoryRepository {
  final DioClient dioClient;
  
  CategoryRepository(this.dioClient);
  
  Future<List<String>> getAllCategories () async {
    final response = await dioClient.client.get(DioConfig.categories);
    
    if(response.statusCode == 200 || response.statusCode == 201){
      final List<dynamic> fetchedCategories = (response.data) as List<dynamic>;
      final List<String> categoriesList = fetchedCategories.map((categoryData) => categoryData.toString()).toList();
      return categoriesList;
    }else{
      throw Exception('Error loading categories ${response.statusCode} ${response.statusMessage}');
    }
  }
}