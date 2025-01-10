import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:realstate/cubit/user_state.dart';
import 'package:realstate/models/UserModel.dart';
import 'package:realstate/services/Api_Constants.dart';


class UserCubit extends Cubit<UserState> {
  UserCubit(this.dio) : super(UserInitial());

final Dio dio;

   GetUsers() async {
    emit(UserLoading()); 
    try {
      final response = await dio.get(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
            if (response.statusCode == 200) {
        List<UserModel> users = (response.data as List).map((userJson) => UserModel.fromJson(userJson))
            .toList();
        emit(UserLoaded(users)); 
      } else {
        emit(UserError('Failed to fetch users'));
      }
    } catch (e) {
      emit(UserError('Error: $e')); 
    }
  }


  Future<void> addUser({
    required String name,
    required String email,
    required String phone,
    required String role,
  }) async {
    emit(UserLoading()); 

    try {
      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.usersEndpoint,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'role': role,
        },
      );

      if (response.statusCode == 200) {
      
        final List<UserModel> users = (response.data as List)
            .map((userJson) => UserModel.fromJson(userJson))
            .toList();
        emit(UserLoaded(users));
      } else {
        emit(UserError('Failed to add User')); 
      }
    } catch (e) {
      emit(UserError('Error: $e'));
    }
  }


  
}
