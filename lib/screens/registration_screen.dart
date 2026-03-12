import 'package:flutter/material.dart';
import '../utils/validations.dart';
import '../widgets/input_filed.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../blocs/auth_bloc.dart';
import '../blocs/auth_state.dart';
import '../blocs/auth_event.dart';
import 'main_screen.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key, required this.title});

  final String title;

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage>{

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

  @override
  Widget build(BuildContext context)
  { 
    
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess)
        {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => MyHomePage(title: "Lab9")),
          );
        }

        else if(state is AuthFailure)
        {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error))
          );
        }
      },

      child: Scaffold(
      appBar: AppBar(title: Text('RegistarionScreen'),),
      body: Form(
        key: _formKey, 
        child: Column(
          children: [
            InputField([Validators.notEmpty],
            'FullName',
            Icon(Icons.person),
            (value) => name = value,
            focusNode: _nameFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_phoneFocus),
            ),

            InputField([Validators.notEmpty, Validators.email], "Email", Icon(Icons.email), 
            (value) => email = value,
            OutlineBorder: false,
            focusNode: _emailFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_storyFocus),
            ),

            InputField([Validators.notEmpty, Validators.minLength], "Password", Icon(Icons.shield), 
            (value) => password = value,
            OutlineBorder: false,
            password_mod: true,
            controller: password_controller,
            focusNode: _passwordFocus,
            onFieldSubmitted:  (_) => FocusScope.of(context).requestFocus(_passwordConfirmFocus),
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

                  context.read<AuthBloc>().add(
                  RegisterEvent(
                    email!,
                    password!,
                  ),
                );
                }
              }, 
              child: Text("Submit form"))
          ],
        ),
        
      )
    )
    );
    
  }
}
