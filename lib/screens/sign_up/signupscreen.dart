import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentassistant/screens/sign_up/signupscreentwo.dart';

import '../../data/constants.dart';
import '../log_in/loginscreen.dart';


class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

TextEditingController namecontroller= TextEditingController();

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(namecontroller.text.toString().length>=3 && isThisRealName(name:namecontroller.text.toString())){
          Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>SignUpScreenTwo()));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please write a valid name")));
        }
      },child:Icon(Icons.arrow_forward_ios),
            backgroundColor:Constants.color,
),
      appBar: appbar,
      body: ListView(
        children: [
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text("Sign Up",style: TextStyle(color: Constants.color,fontSize: 60),),
          ),
          Divider(
            height: 50,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                          keyboardType: TextInputType.emailAddress,

              controller: namecontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                       label: Container(
                        width: 72,
                        child: Row(
                          children:const [
                            Icon(Icons.person),
                            SizedBox(
                              width: 5
                            ),
                            Text("Name")
                          ],
                        ),
                       ) 
                      ),
            ),
          ),TextButton(onPressed: (){
            Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>LoginScreen()));
          }, child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Have an account?",style: TextStyle(color: Colors.grey),),
              SizedBox(
                width: 3,
              ),
              Text("Log In",style: TextStyle(color: Constants.color),)
            ],
          )),Divider(
            height: 150,
            color: Colors.transparent,
          ),Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text("By signing up for the app, you agree to our privacy policy and that you are over 13 years old.",style: TextStyle(color: Colors.grey,),),
          ),
        ],
      ),
    );
  }
}

bool isThisRealName({required String name}) {
  bool isThisRealNameResults = true;
  String patttern = r'^[a-z A-Z,.\-]+$';
  RegExp regExp = new RegExp(patttern);
  if(regExp.hasMatch(name)!=true){
    isThisRealNameResults=false;
  }
  return isThisRealNameResults;
}