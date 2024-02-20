import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

import 'package:firebase_storage/firebase_storage.dart' as fStorage;


import '../global/global_instances.dart';
import '../global/global_vars.dart';
import '../view/mainScreen/home_screen.dart';

class AuthViewModel {
  validateSignUpForm(
      XFile? imageFile,
      String password,
      String confirmPassword,
      String email,
      String name,
      BuildContext context) async {
    if (imageFile == null) {
      commonViewModel.showSnackBar('Please select image file.', context);
      return;
    } else {
      if (password == confirmPassword) {
        if (name.isNotEmpty &&
            email.isNotEmpty &&
            password.isNotEmpty &&
            confirmPassword.isNotEmpty
            ) {

          commonViewModel.showSnackBar("Please wait..", context);
          // signup

          User? currentFirebaseUser =
              await createUserInFirebaseAuth(email, password, context);

          String downloadUrl = await uploadImageToStorage(imageFile);

          await saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name,
              email, password);

          Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
          
          commonViewModel.showSnackBar("Account Create Successfully", context);

        } else {
          commonViewModel.showSnackBar('password fill all fields.', context);
          return;
        }
      } else {
        commonViewModel.showSnackBar('password do not match.', context);
        return;
      }
    }
  }

  createUserInFirebaseAuth(
      String email, String password, BuildContext context) async {
    User? currentFirebaseUser;

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password)
        .then((valueAuth) {
      currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg) {
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if (currentFirebaseUser == null) {
      FirebaseAuth.instance.signOut();
      return;
    }

    return currentFirebaseUser;
  }

  uploadImageToStorage(XFile? imageFile) async {
    String downloadUrl = "";

    String fileName = DateTime.now().millisecondsSinceEpoch.toString();
    fStorage.Reference storageRef = fStorage.FirebaseStorage.instance
        .ref()
        .child('usersImages')
        .child(fileName);

    fStorage.UploadTask uploadTask = storageRef.putFile(File(imageFile!.path));
    fStorage.TaskSnapshot taskSnapshot =
        await uploadTask.whenComplete(() => {});
    await taskSnapshot.ref.getDownloadURL().then((imageUrl) {
      downloadUrl = imageUrl;
    });

    return downloadUrl;
  }

  saveUserDataToFirestore(currentFirebaseUser, downloadUrl, name, email,
      password) async{
    FirebaseFirestore.instance
        .collection("users")
        .doc(currentFirebaseUser.uid)
        .set({
      "uid": currentFirebaseUser.uid,
      "email": email,
      "image":downloadUrl,
      "name": name,
      "status": "approved",
      "userCart": ["garbageValue"]
    });


    await sharedPreferences!.setString("uid", currentFirebaseUser.uid);
    await sharedPreferences!.setString("email", email);
    await sharedPreferences!.setString("name", name);
    await sharedPreferences!.setString("imageUrl", downloadUrl);
    await sharedPreferences!.setStringList("userCart", ["garbageValue"]);


  }


  validateSignInForm(String email, String password, BuildContext context)async{

    if(email.isNotEmpty && password.isNotEmpty){

      commonViewModel.showSnackBar('checking credentials...', context);

   User? currentFirebaseUser = await loginUser(email, password, context);

  await readDataFromFirestoreAndSetDataLocally(currentFirebaseUser, context);

  Navigator.push(context, MaterialPageRoute(builder: (_)=> HomeScreen()));
      commonViewModel.showSnackBar('logged-in successfully.', context);

    }else{
      commonViewModel.showSnackBar('Email and Password are required', context);
      return;
    }
  }

  loginUser(email, password, context)async{

    User? currentFirebaseUser;

   await FirebaseAuth.instance.signInWithEmailAndPassword
      (email: email,
        password: password).then((valueAuth){
          currentFirebaseUser = valueAuth.user;
    }).catchError((errorMsg){
      commonViewModel.showSnackBar(errorMsg, context);
    });

    if(currentFirebaseUser == null){
      FirebaseAuth.instance.signOut();
      return;
    }

    return currentFirebaseUser;
  }

  readDataFromFirestoreAndSetDataLocally(User? currentFirebaseUser, BuildContext context)async{

    await FirebaseFirestore.instance.collection('users')
        .doc(currentFirebaseUser!.uid)
        .get().then((dataSnapshot){

          if(dataSnapshot.exists){
            if(dataSnapshot.data()!['status'] == 'approved'){


              sharedPreferences!.setString("uid", currentFirebaseUser.uid);
              sharedPreferences!.setString("email", dataSnapshot.data()!['email']);
              sharedPreferences!.setString("name", dataSnapshot.data()!['name']);
              sharedPreferences!.setString("imageUrl", dataSnapshot.data()!['image']);

            }else{
              commonViewModel.showSnackBar('Your are blocked admin. Contact: limon222019@gmail.com', context);
              FirebaseAuth.instance.signOut();
              return;
            }
          }else{
            commonViewModel.showSnackBar('This seller record do not exist', context);
            FirebaseAuth.instance.signOut();
            return;
          }
    });
  }
}
