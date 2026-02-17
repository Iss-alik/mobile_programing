import 'package:flutter/material.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alim Lab6',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 62, 183, 58)),
      ),

      initialRoute: '/',
      routes: {
        '/': (context) => MyHomePage(title: "Alim Lab6"),
        '/2': (context) => SecondScreen(),
        '/3': (context) => ThirdScreen()
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{
  
  @override
  Widget build(BuildContext)
  {
    return Scaffold(
      appBar: AppBar(title: Text('HomeScreen'),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){Navigator.push(context, MaterialPageRoute(builder: (context) => SecondScreen()));},
           child: Text('push')), 

          ElevatedButton(onPressed: (){Navigator.pushNamed(context, "/2");}, child: Text('pushNamed')), 

          ElevatedButton(onPressed: (){Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => SecondScreen()));}, 
          child: Text('pushReplacmnet')), 

          ElevatedButton(onPressed: (){Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => SecondScreen()), (route) => false);}, 
          child: Text('push and remove until')),  

          ElevatedButton(onPressed: (){Navigator.pushNamedAndRemoveUntil(context, '/2', (route) => false);}, 
          child: Text('pushNeamd And remove Until')), 

          ],

      ),
    );
  }
}


class SecondScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('SecondScreen'),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){Navigator.pop(context);},
           child: Text('pop')), 

          ElevatedButton(onPressed: (){Navigator.popAndPushNamed(context, "/3");}, child: Text('pop and pushNamed')), 

          ],

      ),
    );
  }
}


class ThirdScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('ThirdScreen'),),
      body: Column(
        children: [
          ElevatedButton(onPressed: (){Navigator.pop(context);},
           child: Text('pop to prevous')), 
          ],

      ),
    );
  }
}