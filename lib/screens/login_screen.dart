import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/text_box.dart';
import 'package:flash_chat/widgets/input_box.dart';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _auth = FirebaseAuth.instance;
  String email="";
  String password="";
  bool showSpinner= false;

  @override
  void initState(){
    super.initState();
  }

  void checkCurrentUser() async{
    try{
      final user=await _auth.signInWithEmailAndPassword(email:email, password : password);
      if(user != null){
        Navigator.pushNamed(context, '/chat');
      }
    }catch(e){
      print("EXCEPTION !!!");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ModalProgressHUD(
        inAsyncCall: showSpinner,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              Flexible(
                child: Hero(
                  tag:"logo",
                  child: Container(
                    height: 200.0,
                    child: Image.asset('images/logo.png'),
                  ),
                ),
              ),
              SizedBox(
                height: 48.0,
              ),
              InputBox(
                placeholderContent: "Enter your email",
                varStore:(value)=>setState(() {
                  email=value;
                })
              ),
              SizedBox(
                height: 8.0,
              ),
              InputBox(
                placeholderContent:"Enter your password",
                  varStore:(value)=>{
                  setState(() {
                    password=value;
                  })}
              ),
              SizedBox(
                height: 24.0,
              ),
              TextBox(
                content: 'Login',
                boxColor: Colors.lightBlueAccent,
                //func: () => Navigator.pushNamed(context, '/login'),
                func: (){
                  setState(() {
                    showSpinner=true;
                  });
                  checkCurrentUser();
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
