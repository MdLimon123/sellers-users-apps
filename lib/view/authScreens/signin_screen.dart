import 'package:flutter/material.dart';


import '../../global/global_instances.dart';
import '../Widgets/custom_text_field.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {

  final _formKey = GlobalKey<FormState>();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return  SingleChildScrollView(
      child: Column(
        children: [

          Container(
            height: 270,
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("images/login.png"),
            ),
          ),
          Form(
            key: _formKey,
              child: Column(
            children: [
              CustomTextField(
                textEditingController: emailTextEditingController,
                hintString: "Email",
                iconData: Icons.email,
                isObscure: false,
                enable: true,

              ),
              CustomTextField(
                textEditingController: passwordTextEditingController,
                hintString: "Password",
                iconData: Icons.lock,
                isObscure: true,
                enable: true,

              ),

              ElevatedButton(
                  onPressed: (){
                    authViewModel.validateSignInForm(
                      emailTextEditingController.text.trim(),
                      passwordTextEditingController.text.trim(),
                      context
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
                  ),
                  child: const Text("Login",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                  ),
                  ))

            ],
          ))
        ],
      ),
    );
  }
}
