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
        '/': (context) => MyHomePage(title: "Alim Lab7"),
        '/profile': (context) => UserInfo(),
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

class _MyHomePageState extends State<MyHomePage>{
  
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext)
  {
    return Scaffold(
      appBar: AppBar(title: Text('RegistarionScreen'),),
      body: Form(
        key: _formKey, 
        child: Column(
          children: [
            InputField(),

            ElevatedButton(onPressed: (){
                if (_formKey.currentState!.validate()) 
                {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Processing Data')),
                  );
                }
              }, 
              child: Text("Submit form"))
          ],
        ),
        
      )
    );
  }
}


class UserInfo extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserInfo'),),
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


class InputField extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return  Padding
            ( padding: EdgeInsets.all(20),
              child: TextFormField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(20)),
                  labelText: 'FullName',
                  prefixIcon: Icon(Icons.person)
                ),
                validator: (value)
                {
                  if( value == null || value.isEmpty)
                  {
                    return "Name can't be empty";
                  }

                  return null;
                },
              ),
            );

  }
}