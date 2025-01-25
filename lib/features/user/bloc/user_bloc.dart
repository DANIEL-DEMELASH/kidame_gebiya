import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kidame_gebiya/core/locator/locator.dart';
import 'package:kidame_gebiya/core/shared/dio_exception_handler.dart';
import 'package:kidame_gebiya/features/user/bloc/user_event.dart';
import 'package:kidame_gebiya/features/user/bloc/user_state.dart';
import 'package:kidame_gebiya/features/user/data/models/user_model.dart';
import 'package:kidame_gebiya/features/user/data/repository/user_repository.dart';

class UserBloc extends Bloc<UserEvent, UserState>{
  final UserRepository _userRepository = getIt<UserRepository>();
  UserBloc() : super(UserInitial()){
    
    on<FetchUser>((event, emit) async {
      try {
        emit(UserLoading());
        final User user = await _userRepository.getUser();
        emit(UserLoaded(user));
      } on DioException catch (e){
        emit(UserError(getErrorMessage(e)));
      } catch (e) {
        emit(UserError(e.toString()));
      }
    });
    
    
  }  
}