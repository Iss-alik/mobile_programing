import 'package:flutter/material.dart';

class Standard_text_container extends Container
{
  Standard_text_container(String text)
  {
    Container(color: Colors.green, padding: EdgeInsets.all(10), 
        margin: EdgeInsets.all(20),
        child: Text(text));
  }
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alim Lab3',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 183, 93, 58)),
      ),
      home: const MyHomePage(title: 'Alim Lab3'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override 
  Widget build(BuildContext context)
  {
    return Scaffold(
      appBar: AppBar( title: Text(title)),
      
      body: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly,),
    );
  }
 
}

