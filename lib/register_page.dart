import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lottie/lottie.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'components/button.dart';
import 'components/textfield.dart';
import 'package:google_fonts/google_fonts.dart';
import 'loginpage.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final emailTextController = TextEditingController();
  final passwordTextController = TextEditingController();
  final confirmpasswordTextController = TextEditingController();


 void signUp() async {
    showDialog(context: context,
      builder: (context) =>
    const Center(child: CircularProgressIndicator(),),
    );

    //make sure passwords match
    if(passwordTextController.text != confirmpasswordTextController.text){
      //pop loading circle
      Navigator.pop(context);
      //show error to the user
      displayMessage("Passwords dont match");
      return;

    }

    try{
      //creating the user
     UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
         email: emailTextController.text,
          password: passwordTextController.text);

     //after creating user, new document in cloud firestore called Users

     FirebaseFirestore.instance
         .collection("Users")
         .doc(userCredential.user!.email)
         .set({
       'username' : emailTextController.text.split('@')[0],
       'bio':'Empty bio..'//initially empty bio
     });


     if(context.mounted)Navigator.pop(context);
    }


    on FirebaseAuthException catch (e)
    {
      Navigator.pop(context);
      displayMessage(e.code);
    }
  }
  void displayMessage(String message){
    showDialog(context: context,
      builder: (context)=> AlertDialog(
        title:Text(message,
          style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
        ),
      ),);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF1B2154),
      
      body:SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  
                 SizedBox(height:35),
                  
                  Text("Create an account!",
                    style: GoogleFonts.poppins(
                      color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 24
                  ),
                  ),
                 
                  Lottie.network(
                    'https://lottie.host/eb91d82b-e0a4-4ebf-a323-6088faa2f898/a2gk8e76M0.json',
                    
                    height: 290,
                    width: 290,
                  ),
      
                  MyTextField(controller: emailTextController,
                    hintText: 'Email',
                    obscureText: false,),
                  const SizedBox(height: 25),
                  MyTextField(controller: passwordTextController,
                    hintText: 'Password',
                    obscureText: true,),
                  const SizedBox(height: 25),
                  MyTextField(controller: confirmpasswordTextController,
                    hintText: 'Confirm Password',
                    obscureText: true,),
                  const SizedBox(height:16),
      
                  MyButton(onTap: signUp,
                    text: 'Sign Up',
      
                  ),
                  const SizedBox(height: 16),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Text("Already have an account?",
                          style: TextStyle(color:  Colors.white,),),
      
                        const SizedBox(width: 4),
                        GestureDetector(
                          onTap: widget.onTap,
                          child: const Text(
                              "Login now",
                              style:TextStyle(
                                fontWeight: FontWeight.bold,
                                color:Colors.blue,
                              )
                          ),
                        )
                      ]
                  )
      
                  //email textfield
                ],
              ),
            ),
          ),
        ),
      ),

    );
  }
}

