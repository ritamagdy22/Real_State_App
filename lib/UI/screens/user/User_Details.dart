import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/cubit/user_cubit.dart';
import 'package:realstate/cubit/user_state.dart';
import 'package:realstate/models/UserModel.dart';

class UserDetailsScreen extends StatelessWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(Dio())..getUserById(userId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('User Details'),
          backgroundColor: Colors.blue,
        ),
        body: BlocBuilder<UserCubit, UserState>(
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.users[0]; // assuming single user loaded
              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Profile Image and Name
                    Center(
                      child: CircleAvatar(
                        radius: 60,
                        backgroundImage: NetworkImage(user.profileImage ?? ''),
                        backgroundColor: Colors.grey[200],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      user.name ?? 'No Name',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Email: ${user.email ?? 'No Email'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Phone: ${user.phone ?? 'No Phone'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'Role: ${user.role ?? 'No Role'}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 20),

                    // Actions Section (Example: Edit Button)
                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          // Edit user action
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          padding: const EdgeInsets.symmetric(
                            horizontal: 40,
                            vertical: 12,
                          ),
                        ),
                        child: const Text('Edit User'),
                      ),
                    ),
                  ],
                ),
              );
            } else {
              return const Center(child: Text("User not found"));
            }
          },
        ),
      ),
    );
  }
}
