import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../home_screen/homescreen.dart';
import '../log_in/loginscreen.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({Key? key}) : super(key: key);

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      body: ListView(
        children: [
          ListTile(
            leading: Text(
              "Delete Account",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        content: Text(
                            "Your Payment Assistant Account ,Your Lends and Borrows Will Be Delete.Are You Sure?"),
                        actions: [
                          CupertinoButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          CupertinoButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                          child: CircularProgressIndicator(),
                                        ));
                                deleteCharacter(context: context);
                              })
                        ],
                      ));
            },
          ),
          Divider(
            color: Colors.grey,
          ),
          ListTile(
            leading: Text(
              "Log Out",
              style: TextStyle(fontSize: 20),
            ),
            onTap: () {
              showCupertinoDialog(
                  context: context,
                  builder: (context) => CupertinoAlertDialog(
                        content: Text(
                            "Are you sure? You are Logging Out from your Payment Assistant."),
                        actions: [
                          CupertinoButton(
                              child: Text("Cancel"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              }),
                          CupertinoButton(
                              child: Text("Ok"),
                              onPressed: () {
                                Navigator.pop(context);
                                showDialog(
                                    context: context,
                                    builder: (context) => Center(
                                          child: CircularProgressIndicator(),
                                        ));
                                logOut(context);
                              })
                        ],
                      ));
            },
          ),
          Divider(
            color: Colors.grey,
          )
        ],
      ),
    );
  }
}
/*Center(
                        child: Card(
                          child: Container(
                            height: 150,
                            width: 300,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    "Your Payment Assistant Account ,Your Lends and Borrows Will Be Delete.Are You Sure ",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    TextButton(
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                        child: Text("Cancel")),
                                    TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          showDialog(
                                              context: context,
                                              builder: (context) => Center(
                                                    child:
                                                        CircularProgressIndicator(),
                                                  ));
                                          deleteCharacter(context: context);
                                        },
                                        child: Text("Ok"))
                                  ],
                                )
                              ],
                            ),
                          ),
                        ),
                      )*/