import 'package:flutter/material.dart';
import 'package:bot_toast/bot_toast.dart';
import 'registration_screen.dart';
import 'profile_screen.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with TickerProviderStateMixin{


  final draw_options = ["Home", "Profile", "Settings", "Logout"];

  final pages = [RegistrationPage(title: "title"), ProfilePage()];
  int _pageIndex = 0;

  final items = const[
    BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
    BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  ];

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_pageIndex],
      
      bottomNavigationBar: BottomNavigationBar(
        items: items, 
        currentIndex: _pageIndex, 
        onTap: (index) => setState(() {
            _pageIndex = index;
          }),
      ) ,
      
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
