import 'package:flutter/material.dart';

Widget customTextFeild({
  required BuildContext context,
  TextEditingController? controller, 
  bool? obscureText,
  String? labelText,
  TextAlign? textAlign, 
  String? obscuringCharacter,
  TextInputType? keyboardType 
  }){
  return Center(
    child: Container(
      width: MediaQuery.of(context).size.width*0.95,
      child: TextFormField(
        controller:controller,
        keyboardType: keyboardType??TextInputType.text,
        obscuringCharacter: obscuringCharacter??'•',
        obscureText: obscureText??false,
        textAlign: textAlign??TextAlign.start,
        decoration:
            InputDecoration(
              labelText: labelText??"",
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(20.0)),
            ),
        ),
    ),
  );
}