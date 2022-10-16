import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentassistant/main.dart';

import '../../data/constants.dart';
import '../../data/model.dart';
import '../about_screen/infoscreen.dart';
import '../home_screen/home_screen_widgets/borrow.dart';
import '../home_screen/home_screen_widgets/lendscreen.dart';
import '../home_screen/homescreen.dart';
import '../log_in/loginscreen.dart';
import 'newlendorborrow.dart';
import 'newlendorborrowtwo.dart';

TextEditingController commentcontroller = TextEditingController();
bool adShown = false;
class NewLendOrBorrow3 extends StatelessWidget {
  const NewLendOrBorrow3({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (count == 0) {
            if (edited == true) {
              lends.removeAt(index2);
            }
            lends.add(Model(
                name: namecontroller2.text.toString(),
                amount: returnAmountFromString(),
                explanation: commentcontroller.text.toString()));
            newlends = true;
            datas_first_come = false;
          } else {
            if (edited == true) {
              borrows.removeAt(index2);
            }
            borrows.add(Model(
                name: namecontroller2.text.toString(),
                amount: returnAmountFromString(),
                explanation: commentcontroller.text.toString()));
            newborrows = true;
            datas_first_come2 = false;
          }
          namecontroller2.clear();
          amountcontroller.clear();
          commentcontroller.clear();
          Navigator.of(context)
              .push(CupertinoPageRoute(builder: (context) => HomeScreen()));
         sleep(Duration(milliseconds: 5));
          if (myAd != null) {
            if(adShown == false){
              adShown=true;
              myAd!.show();
            }
          }
        },
        child: Icon(Icons.arrow_forward_ios),
      ),
      body: ListView(
        children: [
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              count == 0 ? "Lend" : "Borrow",
              style: TextStyle(color: Constants.color, fontSize: 60.0),
            ),
          ),
          Divider(
            height: 50,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
              keyboardType: TextInputType.name,
              maxLines: 5,
              maxLength: 190,
              controller: commentcontroller,
              decoration: InputDecoration(
                  alignLabelWithHint: true,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  label: Container(
                    width: 100,
                    child: Row(
                      children: const [
                        Icon(
                          Icons.comment,
                        ),
                        SizedBox(width: 5),
                        Text("Comment")
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}

double returnAmountFromString() {
  String amount = amountcontroller.text.toString();
  double asilamount;
  try {
    asilamount = double.parse(amount);
    debugPrint("düzgün çalıştı beya");
  } catch (e) {
    List splitted = amount.split(",");
    amount = splitted[0] + "." + splitted[1];
    asilamount = double.parse(amount);
    debugPrint("a" + asilamount.toString() + "a");
  }
  return asilamount;
}
