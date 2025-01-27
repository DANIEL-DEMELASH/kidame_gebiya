import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_event.dart';
import 'package:kidame_gebiya/features/cart/bloc/product_by_id/product_by_id_state.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';
import 'package:kidame_gebiya/features/product/data/repository/product_repository.dart';

class ProductByIdBloc extends Bloc<ProductByIdEvent, ProductByIdState>{
  final ProductRepository _productRepository = getIt<ProductRepository>();
  ProductByIdBloc() : super(ProductByIdInitial()){
    
    on<FetchProductById>((event, emit) async {
      try {
        emit(ProductByIdLoading());
        final ProductModel item = await _productRepository.getProductById(event.productId);
        emit(ProductByIdLoaded(product: item));
      } on DioException catch (e){
        emit(ProductByIdError(error: getErrorMessage(e)));
      } catch (e) {
        emit(ProductByIdError(error: e.toString()));
      }
    });
    
    
  }  
}