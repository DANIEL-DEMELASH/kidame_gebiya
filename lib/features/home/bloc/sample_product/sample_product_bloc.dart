import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/home/bloc/sample_product/sample_product_event.dart';
import 'package:kidame_gebiya/features/home/bloc/sample_product/sample_product_state.dart';
import 'package:kidame_gebiya/features/product/data/models/product_model.dart';
import 'package:kidame_gebiya/features/product/data/repository/product_repository.dart';

class SampleProductBloc extends Bloc<SampleProductEvent, SampleProductState>{
  final ProductRepository _productRepository = getIt<ProductRepository>();
  SampleProductBloc() : super(SampleProductInitial()){
    
    on<FetchProducts>((event, emit) async {
      try {
        emit(SampleProductLoading());
        final List<ProductModel> items = await _productRepository.getAllProducts();
        emit(SampleProductLoaded(items.sublist(0, 4)));
      } on DioException catch (e){
        emit(SampleProductError(getErrorMessage(e)));
      } catch (e) {
        emit(SampleProductError(e.toString()));
      }
    });
    
    
  }  
}