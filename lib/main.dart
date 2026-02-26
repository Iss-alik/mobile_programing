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
        '/': (context) => MyHomePage(title: "Alim Lab7")
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

  String? name;
  String? email;
  String? phone;
  String? story;
  String? password;  

  final _formKey = GlobalKey<FormState>();
  final password_controller = TextEditingController();

  final _emailFocus = FocusNode();
  final _passwordFocus = FocusNode();
   final _passwordConfirmFocus = FocusNode();
  final _nameFocus = FocusNode();
  final _phoneFocus = FocusNode();
  final _storyFocus = FocusNode();

  @override
  void dispose() {
    password_controller.dispose();
    _emailFocus.dispose();
    _passwordConfirmFocus.dispose();
    _passwordFocus.dispose();
    _nameFocus.dispose();
    _phoneFocus.dispose();
    _storyFocus.dispose();
    super.dispose();
  }

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

  String? validateEmail(String? value) {
    final emailRegex = RegExp(
      r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
    );

    if (value != null && !emailRegex.hasMatch(value)) {
      return 'Not correct format of email';
    }

    return null; 
  }

  String? password_match(String? value)
  {
    if(value != null && value != password_controller.text)
    {  return "Passwords are not same";}
    
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
            (value) => name = value,
            focusNode: _nameFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_phoneFocus),
            ),

            InputField([not_empty, only_digits], 
            "Phone number", 
            Icon(Icons.phone),  
            (value) => phone = value, 
            helper: "Phone format (XXX)XXX-XXXX",
            focusNode: _phoneFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_emailFocus),
            ),

            InputField([not_empty, validateEmail], "Email", Icon(Icons.email), 
            (value) => email = value,
            OutlineBorder: false,
            focusNode: _emailFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_storyFocus),
            ),

            InputField([], "Life Story", null, 
            (value) => story = value, 
            helper: "keep it short it is just demo", maxlines: 5, minlines: 3,
            focusNode: _storyFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_passwordFocus),
            ),

            InputField([not_empty, min_length], "Password", Icon(Icons.shield), 
            (value) => password = value,
            OutlineBorder: false,
            password_mod: true,
            controller: password_controller,
            focusNode: _passwordFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_passwordConfirmFocus),
            ),

            InputField([not_empty, min_length, password_match], "Confirm Password", Icon(Icons.draw), null,
            OutlineBorder: false,
            password_mod: true,
            focusNode: _passwordConfirmFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_nameFocus),
            ),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.lightGreen,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                ),
              onPressed: (){
                if (_formKey.currentState!.validate()) 
                {
                  _formKey.currentState!.save(); 

                  Navigator.push(context, 
                    MaterialPageRoute(
                      builder: (context) => UserInfo(email: email!, name: name!, password: password!, phone: phone!, story: story!,)
                    )
                  
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

  final String email;
  final String name;
  final String phone;
  final String story;
  final String password;  

  

  const UserInfo({
    required this.email,
    required this.name,
    required this.phone,
    required this.story,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('UserInfo'),),
      body: Column(
        children: [
          Text("Full Name: $name"),
          Text("Phone Number: $phone"),
          Text("Life story: $story"),
          Text("Email: $email"),
          Text("Password: $password"),
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
  void Function(String?)? save_var;
  
  final FocusNode focusNode;
  final void Function(String)? onFieldSubmitted;

  InputField(
    this.validation_funcs,
    this.label,
    this.icon,
    this.save_var,
    {this.helper, this.maxlines = 1, this.minlines = 1, 
    this.OutlineBorder = true, this.password_mod = false,
    this.controller,
    required this.onFieldSubmitted, required this.focusNode}
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
            ( padding: EdgeInsets.all(10),
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
                controller: widget.controller,
                onSaved: widget.save_var,
                focusNode: widget.focusNode,
                onFieldSubmitted: widget.onFieldSubmitted
              ),
            );

  }
}