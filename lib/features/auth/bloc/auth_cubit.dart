import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/auth/bloc/auth_state.dart';
import 'package:kidame_gebiya/features/auth/data/repository/auth_repository.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() :super(AuthInitial());
  
  final AuthRepository authRepository = getIt<AuthRepository>();
  
  void isUserValidate(Map<String, dynamic> userData) async{
    emit(AuthLoading());
    
    try {
      final bool? isUserValidate = await authRepository.isValidate(userData);
      if(isUserValidate != null && isUserValidate){
        emit(AuthSuccessful());
      }
    } on DioException catch (e) {
      emit(AuthError(error: getErrorMessage(e)));
    }catch (e){
      emit(AuthError(error: e.toString()));
    }
  }
}
