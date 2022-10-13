import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentassistant/screens/sign_up/signupscreen.dart';
import 'package:paymentassistant/screens/sign_up/signupscreentwo.dart';

import '../../data/constants.dart';
import '../../main.dart';
import '../home_screen/homescreen.dart';
import '../log_in/loginscreen.dart';

bool obsecure = true;
bool are_there_Any_errors = false;

class SignUpScreenThree extends StatefulWidget {
  const SignUpScreenThree({Key? key}) : super(key: key);

  @override
  State<SignUpScreenThree> createState() => _SignUpScreenThreeState();
}

TextEditingController passwordcontroller2 = TextEditingController();

class _SignUpScreenThreeState extends State<SignUpScreenThree> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          String password = passwordcontroller2.text.toString();
          showDialog(context: context, builder: (context)=>Center(
            child: CircularProgressIndicator()
          ));
          if (password.length >= 4 && password.length <= 9) {
              auth
                  .createUserWithEmailAndPassword(
                      email: emailcontroller2.text.toString(),
                      password: passwordcontroller2.text.toString())
                  .then((value) {
                    if (are_there_Any_errors == false) {
                firestore
                    .collection("users")
                    .doc(emailcontroller2.text.toString())
                    .set({
                  "name": namecontroller.text.toString(),
                  "email": emailcontroller2.text.toString(),
                  "register_time": Timestamp.now()
                });
                Navigator.of(context).pushAndRemoveUntil(
                    CupertinoPageRoute(builder: (context) => HomeScreen()),
                    (route) => false);
                sharedPreferences!.setBool("remember", true);
                sharedPreferences!
                    .setString("email", emailcontroller2.text.toString());
                sharedPreferences!
                    .setString("password", passwordcontroller2.text.toString());
              } 
                  })
                  .onError((error, stackTrace) {
                are_there_Any_errors = true;
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content:
                        Text("An Error Occured , Please Try Again Later.")));
              });
          } else {
            Navigator.of(context).pop();
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Text(
                    "Please enter a password with a length greater than 4 and less than 9 and 9.")));
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
              "Sign Up",
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
              obscureText: obsecure,
              controller: passwordcontroller2,
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
                Navigator.of(context).push(
                    CupertinoPageRoute(builder: (context) => LoginScreen()));
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Have an account?",
                    style: TextStyle(color: Colors.grey),
                  ),
                  SizedBox(
                    width: 3,
                  ),
                  Text(
                    "Log In",
                    style: TextStyle(color: Constants.color),
                  )
                ],
              )),
          CheckboxListTile(
            value: !obsecure,
            onChanged: (a) {
              setState(() {
                obsecure = !a!;
              });
            },
            title: Text("Show Password"),
          )
        ],
      ),
    );
  }
}
