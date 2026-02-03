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
      title: 'Alim Lab4',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 62, 183, 58)),
      ),
      home: const MyHomePage(title: 'Alim Lab4'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),

      body: Center(
        child: Stack(
          children: [
            Container(
                width: 800,
                height: 800,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  // color: Colors.blue, // for contrast you can add color to container
                  image: DecorationImage(
                    image: AssetImage('assets/image1.jpg'),
                    fit: BoxFit.fill, // .fill - Image fully in the box, no cut only proportion changing.
                    // .contain - original proportions, no cuts, there are white space
                    // .cover - Image fully in the box, cutted, proportions saved.
                    // .fitWidth - fit by the width, can cut by height or free space, try with height - 200 and 700
                    // .fitHeight -  same to fitWidth but for Height, try with width 200 and 700
                    // .none - no scaling, can cut, could be wight space
                    // .scaleDown - deacrease scale if image is not feeting, no cuts, original proportions, could be wight space
                  ),
                ),
            ),

            Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.jpeg'),
                    fit: BoxFit.contain, 
                  ),
                ),
            ),

            Center( 
              child: Container(
                width: 400,
                height: 400,
                decoration: BoxDecoration(
                color: const Color.fromARGB(137, 0, 0, 0)
                ),
                child: Column(
                  children:[
                    Text("Welcome to the flutter", textAlign: TextAlign.center, style: TextStyle(color: const Color.fromARGB(255, 223, 43, 43), fontSize: 35),),
                    
                    ElevatedButton(onPressed: (){}, 
                                  style: ButtonStyle(backgroundColor:  WidgetStatePropertyAll<Color>(Colors.blue), fixedSize: WidgetStateProperty.all<Size>(Size(200, 50)), ), 
                                  child: Text("Show SnackBar", style: TextStyle(fontSize: 16, color: Colors.white),)),

                    TextButton(onPressed: (){}, 
                                  style: ButtonStyle(backgroundColor:  WidgetStatePropertyAll<Color>(Colors.transparent), fixedSize: WidgetStateProperty.all<Size>(Size(200, 50)), ), 
                                  child: Text("Go to second Screen", style: TextStyle(fontSize: 16, color: Colors.green),)),

                    OutlinedButton(onPressed: (){}, 
                                  style: OutlinedButton.styleFrom( side: BorderSide( color: Colors.black), fixedSize: Size(200, 50)), 
                                  child: Text("Toggle Image", style: TextStyle(fontSize: 16, color: Colors.black),))
                  ])
              ),
            )

            
          ],
        ),
      ),


      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
