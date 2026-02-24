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

  String? not_empty(String? value){
    if( value == null || value.isEmpty)
    {
        return "This filed can't be empty";
    }

    return null;
  }

  String? min_length(String? value)
  {
    int length = 8;
    if( value !=null && value.length < length)
    {
        return "This filed too short";
    }

    return null;
  }

  String? only_digits(String? value)
  {
    if (value!=null && int.tryParse(value) == null) {
      return "Only digits allowed";
    }

    return null;
  }

  @override
  Widget build(BuildContext)
  {
    return Scaffold(
      appBar: AppBar(title: Text('RegistarionScreen'),),
      body: Form(
        key: _formKey, 
        child: Column(
          children: [
            InputField([not_empty, min_length],
            'FullName',
            Icon(Icons.person),
            null,
            ),

            InputField([not_empty, only_digits], 
            "Phone number", 
            Icon(Icons.phone),  
            null, 
            helper: "Phone format (XXX)XXX-XXXX",
            ),

            InputField([], "Life Story", null, null, 
            helper: "keep it short it is just demo", maxlines: 5, minlines: 3,
            ),

            InputField([not_empty, min_length], "Password", Icon(Icons.shield), null,
            OutlineBorder: false,
            password_mod: true,
            ),

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




class InputField extends StatefulWidget {

  List <String? Function(String?)> validation_funcs;
  String? label;
  Icon? icon;
  TextEditingController? controller;
  String? helper;
  int maxlines; int minlines;
  bool OutlineBorder;
  bool password_mod;
  

  InputField(
    this.validation_funcs,
    this.label,
    this.icon,
    this.controller,
    {this.helper, this.maxlines = 1, this.minlines = 1, 
    this.OutlineBorder = true, this.password_mod = false}
    );

  @override
  State<InputField> createState() => _InputFieldState();
}

class _InputFieldState extends State<InputField> {

  String? _validate(String? value) 
  {
      for ( final validator in widget.validation_funcs) {
        final result = validator(value);
        if (result != null) return result;
      }
      return null;

  }

  bool obscure = true;
  

  @override
  Widget build(BuildContext context) {

    return  Padding
            ( padding: EdgeInsets.all(20),
              child: TextFormField(
                obscureText: widget.password_mod? obscure: false,
                decoration: InputDecoration(
                  border: widget.OutlineBorder? OutlineInputBorder(borderRadius: BorderRadius.circular(20)) : null,
                  labelText: widget.label,
                  prefixIcon: widget.icon,
                  helperText: widget.helper,

                  suffixIcon: widget.password_mod? IconButton(onPressed: (){
                    setState(() {
                      obscure = !obscure;
                    }); 
                    }, icon: Icon(obscure? Icons.visibility : Icons.visibility_off) ) 
                    : null
                ),
                validator: _validate, 
                maxLines: widget.maxlines,
                minLines: widget.minlines,
              ),
            );

  }
}