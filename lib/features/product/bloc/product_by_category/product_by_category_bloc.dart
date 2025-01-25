import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/product/bloc/product_by_category/product_by_category_event.dart';
import 'package:kidame_gebiya/features/product/bloc/product_by_category/product_by_category_state.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';
import 'package:kidame_gebiya/features/product/data/repository/product_repository.dart';

class ProductByCategoryBloc extends Bloc<ProductByCategoryEvent, ProductByCategoryState>{
  final ProductRepository _productRepository = getIt<ProductRepository>();
  ProductByCategoryBloc() : super(ProductByCategoryInitial()){
    
    on<FetchProductByCategory>((event, emit) async {
      try {
        emit(ProductByCategoryLoading());
        final List<ProductModel> items = await _productRepository.getProductsByCategory(event.productCategory);
        emit(ProductByCategoryLoaded(items));
      } on DioException catch (e){
        emit(ProductByCategoryError(getErrorMessage(e)));
      } catch (e) {
        emit(ProductByCategoryError(e.toString()));
      }
    });
    
    
  }  
}