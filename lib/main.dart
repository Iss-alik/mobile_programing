import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Alim Lab5',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: const Color.fromARGB(255, 62, 183, 58)),
      ),
      home: const MyHomePage(title: 'Alim Lab5'),
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

  late final TabController _tabController;

  @override 
  void initState() {
    super.initState();
    _tabController = TabController(length: 4, vsync: this);

  }

  @override 
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
        bottom: TabBar(controller: _tabController, tabs: const <Widget> [Tab(icon: Icon(Icons.list)), Tab(icon: Icon(Icons.grid_view_rounded)), 
                      Tab(icon: Icon(Icons.card_membership)), Tab(icon: Icon(Icons.draw))   ],),
      ),

      body: 
      TabBarView(
          controller: _tabController,
          children: [
                  ListView(children: [for(int i =0; i<10; i++) ListTile(title:Text('Item $i'), subtitle: Text('with subtitle $i'), )]), 
                  GridView.count(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, primary: false, padding: EdgeInsets.all(40),
                                  children: [for(int i=1; i<7; i++) Container(padding: EdgeInsets.all(4), color: Colors.teal[100*i], child: Text('$i'),)],),
                  Column(mainAxisAlignment: MainAxisAlignment.center, children: [Card(color: Colors.lightGreen[300], child: _SampleCard(cardName: "Elevated Card"),)],),
                  Text("Hello world")
                  ]
      ),

    );
  }
}


class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;

  @override
  Widget build(BuildContext context) {
    return InkWell(splashColor: Colors.blueGrey, onTap: () {ShowToast("Card $cardName was clicked");}, 
                  child: SizedBox(width: 200, height: 100, child: Center(child: Text(cardName))),);
  }

  void ShowToast(String text)
  {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
  }
}
