import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/cubit/user_cubit.dart';
import 'package:realstate/cubit/user_state.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final roleController = TextEditingController();

    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Add User"),
        ),
        body: BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserError) {
              // Show an error message if there's an error adding the user
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.error)),
              );
            } else if (state is UseraddedSuccessfully) {
              // Show success message after the user is added successfully
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('User Added Successfully')),
              );
      
              // Print success in the terminal
              print('User Added Successfully');
      
              // Close the screen after adding the user
              Future.delayed(Duration(seconds: 1), () {
                Navigator.pop(context);
              });
            } else if (state is UserError) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Registration Failed")),
              );
            } else if (state is UseraddedSuccessfully) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("User Registration Successful")),
              );
            }
          },
          builder: (context, state) {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: nameController,
                      decoration: const InputDecoration(labelText: 'User Name'),
                      validator: (value) => value!.isEmpty ? 'Name is required' : null,
                    ),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(labelText: 'User Email'),
                      validator: (value) => value!.isEmpty ? 'Email is required' : null,
                    ),
                    TextFormField(
                      controller: phoneController,
                      decoration: const InputDecoration(labelText: 'User Phone'),
                      validator: (value) => value!.isEmpty ? 'Phone is required' : null,
                    ),
                    TextFormField(
                      controller: roleController,
                      decoration: const InputDecoration(labelText: 'User Role'),
                      validator: (value) => value!.isEmpty ? 'Role is required' : null,
                    ),
                    ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          // Add the user when the form is valid
                          context.read<UserCubit>().addUser(
                                name: nameController.text,
                                email: emailController.text,
                                phone: phoneController.text,
                                role: roleController.text,
                              );
                        }
                      },
                      child: const Text('Add User'),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
