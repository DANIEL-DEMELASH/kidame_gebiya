import 'package:get_it/get_it.dart';
import 'package:kidame_gebiya/core/dio/dio_client.dart';
import 'package:kidame_gebiya/features/auth/data/repository/auth_repository.dart';
import 'package:kidame_gebiya/features/category/data/repository/category_repository.dart';
import 'package:kidame_gebiya/features/product/data/repository/product_repository.dart';

final getIt = GetIt.instance;

void setupLocator(){
  getIt.registerLazySingleton<DioClient>(() => DioClient());
  
  getIt.registerLazySingleton<AuthRepository>(() => AuthRepository(getIt<DioClient>()));
  getIt.registerLazySingleton<ProductRepository>(() => ProductRepository(getIt<DioClient>()));
  getIt.registerLazySingleton<CategoryRepository>(() => CategoryRepository(getIt<DioClient>()));
}