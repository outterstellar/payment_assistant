import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentassistant/screens/sign_up/signupscreenthree.dart';

import '../../data/constants.dart';
import '../log_in/loginscreen.dart';

class SignUpScreenTwo extends StatefulWidget {
  const SignUpScreenTwo({Key? key}) : super(key: key);

  @override
  State<SignUpScreenTwo> createState() => _SignUpScreenTwoState();
}
TextEditingController emailcontroller2 = TextEditingController();

class _SignUpScreenTwoState extends State<SignUpScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
        
        String email=  emailcontroller2.text.toString();
  bool emaildogrumugiz=RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(email);
  if(emaildogrumugiz){
    Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>SignUpScreenThree()));
  }else{
ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Please write a valid email")));
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
              controller: emailcontroller2,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                       label: Container(
                        width: 72,
                        child: Row(
                          children:const [
                            Icon(Icons.email),
                            SizedBox(
                              width: 5
                            ),
                            Text("Email")
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
          )),
        ],
      ),
    );
  }
}