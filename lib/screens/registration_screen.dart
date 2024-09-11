import 'package:flutter/material.dart';
import 'package:flash_chat/widgets/text_box.dart';
import 'package:flash_chat/widgets/input_box.dart';
import 'package:flash_chat/screens/chat_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

class RegistrationScreen extends StatefulWidget {
  @override
  _RegistrationScreenState createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _auth = FirebaseAuth.instance;
  String email="";
  String password="";
  bool showSpinner=false;
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
            children:[
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
                  placeholderContent:"Enter your Email",
                  varStore:(value)=>{email=value}
              ),
              SizedBox(
                height: 8.0,
              ),
              InputBox(
                placeholderContent: "Enter your password",
                varStore:(value)=>{password=value}
              ),
              SizedBox(
                height: 24.0,
              ),
              TextBox(
                content: 'Register',
                boxColor: Colors.blueAccent,
                //func: () => Navigator.pushNamed(context, '/register'),
                func: () async{
                  setState(() {
                    showSpinner=true;
                  });
                  try {
                    final newUser = await _auth.createUserWithEmailAndPassword(email: email, password: password);
                    if(newUser != null)
                      {
                        Navigator.pushNamed(context,'/chat');

                      }
                      setState((){
                        showSpinner=false;
                      });
                  }
                  catch (e){
                    print(e);
                  }
                }
              ),
            ],
          ),
        ),
      ),
    );
  }
}
