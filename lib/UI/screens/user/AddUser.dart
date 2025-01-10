import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/cubit/user_cubit.dart';

class AddUserScreen extends StatelessWidget {
  const AddUserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    final nameController = TextEditingController();
    final emailController = TextEditingController();
    final phoneController = TextEditingController();
    final roleController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text("Add User"),
      ),
      body: Padding(
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
                    context.read<UserCubit>().addUser(
                          name: nameController.text,
                          email: emailController.text,
                          phone: phoneController.text,
                          role: roleController.text,
                        );
                    Navigator.pop(context); // Close the screen after adding the user
                  }
                },
                child: const Text('Add User'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
