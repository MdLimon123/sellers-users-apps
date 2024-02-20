import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import '../../global/global_instances.dart';
import '../../global/global_vars.dart';
import '../Widgets/custom_text_field.dart';


class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameTextEditingController = TextEditingController();
  TextEditingController emailTextEditingController = TextEditingController();
  TextEditingController passwordTextEditingController = TextEditingController();
  TextEditingController confirmPasswordTextEditingController = TextEditingController();




  XFile? imageFile;
  ImagePicker pickedImage = ImagePicker();

  pickImageFormGallery()async{
    imageFile = await pickedImage.pickImage(source: ImageSource.gallery);
    setState(() {
      imageFile;
    });
  }


  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
         const SizedBox(height: 11,),

          InkWell(
            onTap: (){
              pickImageFormGallery();
            },
            child: CircleAvatar(
              radius: MediaQuery.of(context).size.width * 0.20,
              backgroundColor: Colors.white,
              backgroundImage: imageFile == null ? null: FileImage(File(imageFile!.path)),
              child: imageFile == null?
              Icon(Icons.add_photo_alternate,
              size: MediaQuery.of(context).size.width * 0.20,
              color: Colors.grey,)
              : null,
            ),
          ),

          const SizedBox(height: 10,),
          Form(
              key: _formKey,
              child: Column(
                children: [

                  CustomTextField(
                    textEditingController: nameTextEditingController,
                    hintString: "Name",
                    iconData: Icons.person,
                    isObscure: false,
                    enable: true,

                  ),

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
                  CustomTextField(
                    textEditingController: confirmPasswordTextEditingController,
                    hintString: "Confirm Password",
                    iconData: Icons.lock,
                    isObscure: true,
                    enable: true,

                  ),

                  const SizedBox(height: 20,),
                  ElevatedButton(
                      onPressed: ()async{
                       await authViewModel.validateSignUpForm(
                            imageFile,
                            passwordTextEditingController.text.trim(),
                            confirmPasswordTextEditingController.text.trim(),
                            emailTextEditingController.text.trim(),
                            nameTextEditingController.text.trim(),
                            context);
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 10)
                      ),
                      child: const Text("Sign Up",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold
                        ),
                      )),
                  const SizedBox(height: 20,),
                ],
              ))


        ],
      ),
    );
  }
}
