import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


import '../../data/constants.dart';
import '../sign_up/signupscreen.dart';
import 'loginscreentwo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

TextEditingController emailcontroller = TextEditingController();

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool email_real = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(emailcontroller.text.toString());
          if (email_real) {
            Navigator.of(context).push(
                CupertinoPageRoute(builder: (context) => LoginScreenTwo()));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please write a valid email")));
          }
        },
        child: Icon(Icons.arrow_forward_ios),
        backgroundColor: Constants.color,
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
            child: Text(
              "Log In",
              style: TextStyle(color: Constants.color, fontSize: 60),
            ),
          ),
          Divider(
            height: 50,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.emailAddress,
              controller: emailcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  label: Container(
                    width: 69,
                    child: Row(
                      children: const [
                        Icon(Icons.email),
                        SizedBox(width: 5),
                        Text("Email")
                      ],
                    ),
                  )),
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => SignUpScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Don't have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Sign Up",
                    style: TextStyle(color: Constants.color),
                  )
                ],
              )),
        ],
      ),
    );
  }
}

AppBar appbar = AppBar(
  foregroundColor: Colors.black,
  automaticallyImplyLeading: false,
  title: Text(
    "Payment Assistant",
    style: TextStyle(color: Constants.color, fontSize: 25),
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
);
