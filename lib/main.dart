import 'package:flutter/material.dart';

class StandardTextContainer extends Container {
  StandardTextContainer(String text, {super.key})
      : super(
          color: Colors.green,
          padding: const EdgeInsets.all(10),
          margin: const EdgeInsets.all(20),
          child: Text(text),
        );
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
      title: 'Alim Lab 3: Layout Basics',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.grey),
        scaffoldBackgroundColor: Colors.grey[300],
      ),
      home: const MyHomePage(title: 'Alim Lab 3: Layout Basics'),
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
      appBar: AppBar( 
      title: Text(title, 
              style: TextStyle(
                fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold, 
              )
            ), 
      backgroundColor: Colors.teal,),
      body: Column(children: 
        [Container
                  (child: Text("Welcome to Flutter", style: TextStyle(fontSize: 18, color: Colors.white, fontWeight: FontWeight.bold), textAlign: TextAlign.center,), 
                   padding: const EdgeInsets.all(16),
                   decoration: BoxDecoration( 
                                              color: Colors.blue,
                                              borderRadius: BorderRadius.circular(12), 
                                              boxShadow:  [BoxShadow(color: Colors.black.withOpacity(0.2), blurRadius: 6, offset: Offset(2,2) )] 
                                            ),
                  ),
                const SizedBox(height: 16),
                Container
                  (child: Row(  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [Text("Left text", style: TextStyle(fontSize: 16, color: Colors.white) ), Text("Rigth text", style: TextStyle(fontSize: 16, color: Colors.white) ) ],), 
                   padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20) ,
                   decoration: BoxDecoration( 
                                              color: Colors.green,
                                              borderRadius: BorderRadius.circular(8), 
                                              border: Border.all(color: Colors.white, width: 2)
                                            ),
                  ),], )
    );
  }
 
}

