import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'LoginPage.dart';

class SigninPage extends StatefulWidget {
  const SigninPage({super.key});

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {

  final emailControlller = TextEditingController();
  final PasswordControlller = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address.';
    }

    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address.';
    }
    return null;
  }

  String? _validatePassword(String value) {
    if (value.isEmpty) {
      return 'Please enter your password.';
    }
    // You can define your password requirements here, like minimum length.
    if (value.length < 8) {
      return 'Password must be at least 6 characters long.';
    }
    return null;
  }

  Future<void> _signUpWithEmailPassword() async{
    try{
      UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
          email: emailControlller.text.trim(),
          password: PasswordControlller.text.trim()
      );
      Fluttertoast.showToast(msg: "Signup Successfully");
      Navigator.pop(context);
    }
    on FirebaseAuthException catch (e){
      Fluttertoast.showToast(msg: "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("SignUP Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
        backgroundColor: Colors.blue,
      ),

      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            TextField(
              controller: emailControlller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: "Email",
                prefixIcon: Icon(Icons.email),

              ),
            ),

            SizedBox(height: 10,),
            TextField(
              controller: PasswordControlller,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                  labelText: "password",
                prefixIcon: Icon(Icons.key)
              ),
              obscureText: false,
            ),
            SizedBox(height: 10,),

            ElevatedButton(
              onPressed: _signUpWithEmailPassword,
              child: Text("Sign Up",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
            ),

            TextButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
                }, child: Text("allready have an account")),
          ],
        ),
      ),
    );

  }
}
