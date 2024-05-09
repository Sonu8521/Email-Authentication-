import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'HomePage.dart';
import 'SignupPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  final emailControlller = TextEditingController();
  final PasswordControlller = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String? _validateEmail(String value) {
    if (value.isEmpty) {
      return 'Please enter your email address.';
    }
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

  Future<void> _sigInWithEmailPassword() async {
    try {
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
          email: emailControlller.text.trim(),
          password: PasswordControlller.text.trim());
      Fluttertoast.showToast(msg: "Login Successfully");
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (_) => HomePage()));
    } on FirebaseAuthException catch (e) {
      Fluttertoast.showToast(msg: "$e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Login Page",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
          backgroundColor: Colors.blue,
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: emailControlller,
                  decoration: InputDecoration(
                    labelText: "Email",
                    prefixIcon: Icon(Icons.email),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),


              Padding(
                padding: EdgeInsets.all(15.0),
                child: TextField(
                  controller: PasswordControlller,
                  decoration: InputDecoration(
                    labelText: "Password",
                    prefixIcon: Icon(Icons.key),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),

              ElevatedButton(
                onPressed: () {
                  _sigInWithEmailPassword();
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
                ),
              ),

              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => const SigninPage()));
                  },
                  child: const Text("Don't have an account? Sign up"))
            ],
          ),
        ));
  }
}
