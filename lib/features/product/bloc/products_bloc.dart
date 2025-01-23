import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/product/bloc/products_event.dart';
import 'package:kidame_gebiya/features/product/bloc/products_state.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';
import 'package:kidame_gebiya/features/product/data/repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState>{
  final ProductRepository _productRepository = getIt<ProductRepository>();
  ProductBloc() : super(ProductInitial()){
    
    on<FetchAllProducts>((event, emit) async {
      try {
        emit(ProductLoading());
        final List<ProductModel> items = await _productRepository.getAllProducts();
        emit(ProductLoaded(items));
      } on DioException catch (e){
        emit(ProductError(getErrorMessage(e)));
      } catch (e) {
        emit(ProductError(e.toString()));
      }
    });
    
    
  }  
}