import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:bot_toast/bot_toast.dart';

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
      builder: BotToastInit(), //1. call BotToastInit
      navigatorObservers: [BotToastNavigatorObserver()], //2. registered route observer
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
  final draw_options = ["Home", "Profile", "Settings", "Logout"];

  @override 
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);

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
                      Tab(icon: Icon(Icons.card_membership))  ],),
      ),

      body: 
      TabBarView(
          controller: _tabController,
          children: [
                  ListView(children: [for(int i =0; i<10; i++) ListTile(title:Text('Item $i'), subtitle: Text('with subtitle $i'), )]), 
                  
                  GridView.count(crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10, primary: false, padding: EdgeInsets.all(40),
                                  children: [for(int i=1; i<7; i++) Container(padding: EdgeInsets.all(4), color: Colors.teal[100*i], child: Text('$i'),)],),
                  
                  Column(mainAxisAlignment: MainAxisAlignment.center, 
                        children: [Card(child: _SampleCard(cardName: "Elevated Card"),), 
                                  Card.filled(child: _SampleCard(cardName: "Filled Card"),),
                                  Card.outlined(child: _SampleCard(cardName: "Outlined Card"),)
                                  ], 
                        
                        ),
                  ]
      ),

      drawer: Drawer(
        child: ListView(
          children: [ for(int i=0; i<4; i++) ListTile(title: Text(draw_options[i]),
                    onTap: () {
                      Navigator.pop(context);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text('This is a ${draw_options[i]} !'),
                        duration: Duration(seconds: 2),));
                    },
          )],
        )
      ),
    );
  }
}


class _SampleCard extends StatelessWidget {
  const _SampleCard({required this.cardName});
  final String cardName;
  
  @override
  Widget build(BuildContext context) {
    return InkWell(splashColor: Colors.blueGrey, onTap: () { BotToast.showText(text: "Card $cardName was clicked");}, 
                  child: SizedBox(width: 200, height: 100, child: Center(child: Text(cardName))),);
  }

}