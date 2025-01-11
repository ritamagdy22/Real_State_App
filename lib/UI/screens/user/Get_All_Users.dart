import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/UI/screens/user/Add_User.dart';
import 'package:realstate/UI/screens/user/User_Details.dart';
import 'package:realstate/UI/widgets/custom_button.dart';
import 'package:realstate/cubit/user_cubit.dart';
import 'package:realstate/cubit/user_state.dart';

class GetAllUsersScreen extends StatelessWidget {
  const GetAllUsersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(Dio())..GetUsers(),
      child: Scaffold(
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Error")),
              );
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final users = state.users;
              return ListView.builder(
                itemCount: users.length,
                itemBuilder: (context, index) {
                  final user = users[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(user.profileImage ?? ''),
                    ),
                    title: Text(user.name ?? 'No Name'),
                    subtitle: Text(user.email ?? 'No Email'),
                      onTap: () {
                      // Navigate to the UserDetailsScreen when a user is tapped
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UserDetailsScreen(userId: user.id!),
                        ),
                      );
                    },
                  );
                },
              );
            } else {
              return const Center(child: Text("No Users Available"));
            }
          },
        ),
        // FloatingActionButton to navigate to AddUserScreen
        floatingActionButton: CustomButton(
          text: "Add User ",
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const AddUserScreen()),
            );
          },



          
        ),
      ),
    );
  }
}
