import 'package:flutter/material.dart';

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