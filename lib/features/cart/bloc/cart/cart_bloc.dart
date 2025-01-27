import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/cart/bloc/cart/cart_event.dart';
import 'package:kidame_gebiya/features/cart/bloc/cart/cart_state.dart';
import 'package:kidame_gebiya/features/cart/data/models/cart_model.dart';
import 'package:kidame_gebiya/features/cart/data/repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState>{
  final CartRepository _cartRepository = getIt<CartRepository>();
  CartBloc() : super(CartInitial()){
    
    on<FetchUserCarts>((event, emit) async {
      try {
        emit(CartLoading());
        final List<CartModel> items = await _cartRepository.getUserCarts();
        emit(CartLoaded(userCarts: items));
      } on DioException catch (e){
        emit(CartError(error: getErrorMessage(e)));
      } catch (e) {
        emit(CartError(error: e.toString()));
      }
    });
    
    
  }  
}