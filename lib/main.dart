import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:realstate/UI/screens/BookingScreen.dart';
import 'package:realstate/UI/screens/Layout.dart';
import 'package:realstate/UI/screens/PropertiesScreen.dart';
import 'package:realstate/UI/screens/user/Users.dart';
import 'package:realstate/cubit/user_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensures Flutter bindings are ready

  runApp(
    BlocProvider(
      create: (context) => UserCubit(Dio()),
      child: MainApp(),
    ),
  );
}


class MainApp extends StatelessWidget {
   const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    //Named Routes
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context) => LayoutScreen(),
        '/users': (context) => GetAllUsersScreen(),
        '/properties': (context) => Propertiesscreen(),
        '/booking': (context) => Bookingscreen(),
      },
    );
  }
}
