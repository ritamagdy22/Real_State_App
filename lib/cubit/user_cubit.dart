import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:realstate/cubit/user_state.dart';
import 'package:realstate/models/Add_User_Response.dart';
import 'package:realstate/models/Update_User_Specefic_Details.dart';
import 'package:realstate/models/UserModel.dart';
import 'package:realstate/services/Api_Constants.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit(this.dio) : super(UserInitial());

  final Dio dio;

  Future<UserModel?> GetUsers() async {
    emit(UserLoading());
    try {
      final response =
          await dio.get(ApiConstants.baseUrl + ApiConstants.usersEndpoint);
      if (response.statusCode == 200) {
        List<UserModel> users = (response.data as List)
            .map((userJson) => UserModel.fromJson(userJson))
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
      // Log the request body
      print("Request Body: ${{
        'name': name,
        'email': email,
        'phone': phone,
        'role': role,
      }}");

      final response = await dio.post(
        ApiConstants.baseUrl + ApiConstants.usersEndpoint,
        data: {
          'name': name,
          'email': email,
          'phone': phone,
          'role': role,
        },
        options: Options(
          followRedirects: false,
          validateStatus: (status) {
            // Allow status codes less than 500, including 422
            return status! < 500;
          },
          headers: {
            // Add any necessary headers here if required by your API
            'Authorization': 'Bearer your-token', // Example header
          },
        ),
      );

      // Log the full response
      print("Response: ${response.data}");

      if (response.statusCode == 201) {
        final createUserResponse = CreateUserResponse.fromJson(response.data);
        if (createUserResponse.user != null) {
          final userModel =
              UserModel.fromJson(createUserResponse.user!.toJson());
          //emit(UseraddedSuccessfully('User added with name: $name'));

          emit(UserLoaded([userModel])); // Emit with the newly created user
        } else {
          emit(UserError('No user data returned.'));
        }
      } else if (response.statusCode == 422) {
        // Log the error response to see what validation failed
        final errorResponse = response.data;
        print("Error Response: $errorResponse");
        String errorMessage = errorResponse["message"] ?? "Validation error";
        emit(UserError('Validation Error: $errorMessage'));
      } else {
        emit(UserError(
            'Failed to add User, Status Code: ${response.statusCode}'));
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
        emit(UserLoaded(
            [user])); // You can return a list of users or just the user
      } else {
        emit(UserError(
            'Failed to load user details')); // Emit error if the status code is not 200
      }
    } catch (e) {
      emit(UserError(
          'Error: $e')); // Emit error if there is a network error or exception
    }
  }

 Future<void> updateUser({required int userId, required String name, required String email}) async {
    emit(UserLoading());
    try {
      final response = await dio.put(
        '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId',
        data: {
          'name': name,
          'email': email,
        },
        options: Options(
          headers: {
            'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        final updatedUser = UpdateUserSpeceficDetails.fromJson(response.data['user']);
        emit(UserUpdated(updatedUser));

        // After updating, fetch the latest user data
        await getUserById(userId);
      } else {
        emit(UserError('Failed to update user'));
      }
    } catch (e) {
      emit(UserError('Error: $e'));
    }
  }




  Future<void> deleteUser({required int userId}) async {
  emit(UserLoading());

  try {
    print("Deleting user with userId=$userId");

    final response = await dio.delete(
      '${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}/$userId',
      options: Options(
        headers: {
          'Authorization': 'Bearer YOUR_ACCESS_TOKEN',
        },
      ),
    );

    print("Response: ${response.data}");

    if (response.statusCode == 200) {
      emit(UserDeletedSuccessfully());
    } else {
      emit(UserError('Failed to delete user: ${response.data}'));
    }
  } on DioException catch (e) {
    print("DioException: ${e.message}");
    print("Error Response: ${e.response?.data}");
    emit(UserError('Error: ${e.response?.data}'));
  } catch (e) {
    print("Other Error: $e");
    emit(UserError('Error: $e'));
  }
}
}
