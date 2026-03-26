import 'package:flutter/material.dart';
import 'package:flutter_application_3/screens/main_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'blocs/auth/auth_bloc.dart';
import '../repositories/auth_repo.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => AuthBloc(AuthRepository()),
      child: MaterialApp(
        title: 'Alim Lab9',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 62, 183, 58),
          ),
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => MyHomePage(title: "Alim Lab9"),
        },
      ),
    );
  }
}
