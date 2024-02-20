import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {

  TextEditingController? textEditingController;
  String? hintString;
  IconData? iconData;
  bool? isObscure = true;
  bool? enable = true;

   CustomTextField({super.key, this.textEditingController, this.iconData, this.enable,
  this.hintString, this.isObscure});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12)
      ),
      padding:const EdgeInsets.all(8),
      margin:const EdgeInsets.all(8),
      child: TextFormField(
        style: const TextStyle(color: Colors.black),
        enabled: widget.enable,
        controller: widget.textEditingController,
        obscureText: widget.isObscure!,
        decoration: InputDecoration(
          border: InputBorder.none,
          prefixIcon: Icon(widget.iconData,
          color: Colors.blueAccent,),
          hintText: widget.hintString,
          hintStyle: const TextStyle(
            color: Colors.grey
          )
        ),
      ),

    );
  }
}
