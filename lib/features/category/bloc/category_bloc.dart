import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/category/bloc/category_event.dart';
import 'package:kidame_gebiya/features/category/bloc/category_state.dart';
import 'package:kidame_gebiya/features/category/data/repository/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState>{
  final CategoryRepository _categoryRepository = getIt<CategoryRepository>();
  CategoryBloc() : super(CategoryInitial()){
    
    on<FetchCategories>((event, emit) async {
      try {
        emit(CategoryLoading());
        final List<String> items = await _categoryRepository.getAllCategories();
        emit(CategoryLoaded(items));
      } on DioException catch (e){
        emit(CategoryError(getErrorMessage(e)));
      } catch (e) {
        emit(CategoryError(e.toString()));
      }
    });
    
    
  }  
}