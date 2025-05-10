import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/UI/widgets/custom_app_bar.dart';
import 'package:realstate/UI/widgets/custom_button.dart';
import 'package:realstate/cubit/user_cubit.dart';
import 'package:realstate/cubit/user_state.dart';

class UserDetailsScreen extends StatefulWidget {
  final int userId;

  const UserDetailsScreen({super.key, required this.userId});

  @override
  _UserDetailsScreenState createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UserCubit(Dio())..getUserById(widget.userId),
      child: Scaffold(
        appBar: CustomAppBar(title: "User Details"),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            }
            if (state is UserUpdated) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User updated successfully!")),
              );
              // Fetch the updated user data and refresh the UI
              context.read<UserCubit>().getUserById(widget.userId);
            }
          },
          builder: (context, state) {
            if (state is UserLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is UserLoaded) {
              final user = state.users[0]; // Assuming a single user

              // Update TextEditingControllers after state has changed
              nameController.text = user.name ?? '';
              emailController.text = user.email ?? '';

              return Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomButton(
                          text: "Update User",
                          onPressed: () {
                            showModalBottomSheet(
                              context: context,
                              builder: (BuildContext context) {
                                return Padding(
                                  padding: const EdgeInsets.all(16.0),
                                  child: Form(
                                    child: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        TextFormField(
                                          controller: nameController,
                                          decoration: const InputDecoration(
                                            labelText: 'Name',
                                          ),
                                          validator: (value) =>
                                              value!.isEmpty
                                                  ? 'Name is required'
                                                  : null,
                                        ),
                                        const SizedBox(height: 20),
                                        TextFormField(
                                          controller: emailController,
                                          decoration: const InputDecoration(
                                            labelText: 'Email',
                                          ),
                                          validator: (value) =>
                                              value!.isEmpty
                                                  ? 'Email is required'
                                                  : null,
                                        ),
                                        const SizedBox(height: 20),
                                        CustomButton(
                                          text: "Update",
                                          onPressed: () {
                                            // Call updateUser and trigger state change
                                            context.read<UserCubit>().updateUser(
                                              userId: widget.userId,
                                              name: nameController.text,
                                              email: emailController.text,
                                            );
                                            // After update, close the modal
                                            Navigator.pop(context);
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                        const SizedBox(width: 16),
                        CustomButton(
                          text: "Delete User",
                          onPressed: () {
                            context.read<UserCubit>().deleteUser(userId: widget.userId);
                          },
                        ),
                      ],
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
