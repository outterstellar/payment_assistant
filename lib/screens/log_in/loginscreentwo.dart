import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../../main.dart';
import '../home_screen/homescreen.dart';
import 'loginscreen.dart';

class LoginScreenTwo extends StatefulWidget {
  const LoginScreenTwo({Key? key}) : super(key: key);

  @override
  State<LoginScreenTwo> createState() => _LoginScreenTwoState();
}

TextEditingController passwordcontroller = TextEditingController();
bool obscure = true;

class _LoginScreenTwoState extends State<LoginScreenTwo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          bool are_there_any_error = false;
          showDialog(context: context, builder: (context)=>Center(
            child: CircularProgressIndicator()
          ));
          auth
              .signInWithEmailAndPassword(
                  email: emailcontroller.text.toString(),
                  password: passwordcontroller.text.toString())
              .then((value) {
            if (are_there_any_error == false) {
              sharedPreferences!.setBool("remember", true);
              sharedPreferences!
                  .setString("email", emailcontroller.text.toString());
              sharedPreferences!
                  .setString("password", passwordcontroller.text.toString());
              emailcontroller.clear();
              passwordcontroller.clear();
              Navigator.of(context).pushAndRemoveUntil(
                  CupertinoPageRoute(builder: (context) => HomeScreen()),
                  (route) => false);
            }
          }).onError((error, stackTrace) {
            are_there_any_error = true;
            Navigator.pop(context);
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text("An error has occurred, please check your information and try again.")
              )
            );
          });
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
              obscureText: obscure,
              controller: passwordcontroller,
              decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  label: Container(
                    width: 100,
                    child: Row(
                      children: const [
                        Icon(Icons.password),
                        SizedBox(width: 5),
                        Text("Password")
                      ],
                    ),
                  )),
            ),
          ),
          TextButton(
              onPressed: () {
                _resetpassword(context: context);
              },
              child: const Text("Forgot Password?")),
          const Divider(height: 25, color: Colors.transparent),
          CheckboxListTile(
            value: !obscure,
            onChanged: (a) {
              setState(() {
                obscure = !a!;
              });
            },
            title: const Text("Show Password"),
          )
        ],
      ),
    );
  }
}

void _resetpassword({required BuildContext context}) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: CircularProgressIndicator(),
          ));
  try {
    auth.sendPasswordResetEmail(email: emailcontroller.text.toString());
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text("We have sent you an email to reset your password.")));
    Navigator.of(context).popUntil((route) => route.isFirst);
  } catch (e) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text("An error has occurred, please try again later.")));
    Navigator.of(context).pop();
  }
}
