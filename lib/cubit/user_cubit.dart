import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:realstate/cubit/user_state.dart';
import 'package:realstate/models/UserModel.dart';
import 'package:realstate/services/Api_Constants.dart';


class UserCubit extends Cubit<UserState> {
  UserCubit(this.dio) : super(UserInitial());

final Dio dio;

  Future<UserModel?> GetUsers() async {
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


Future<void> getUserById(int userId) async {
  emit(UserLoading()); // Emit loading state before making the request

  try {
    final response = await dio.get(
      ApiConstants.baseUrl + '/users/$userId',
    );

    if (response.statusCode == 200) {
      // Parse the data into a UserModel and emit the UserLoaded state
      final user = UserModel.fromJson(response.data);
      emit(UserLoaded([user])); // You can return a list of users or just the user
    } else {
      emit(UserError('Failed to load user details')); // Emit error if the status code is not 200
    }
  } catch (e) {
    emit(UserError('Error: $e')); // Emit error if there is a network error or exception
  }
}


  
}
