

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../data/constants.dart';
import '../home_screen/homescreen.dart';
import '../log_in/loginscreen.dart';
import 'newlendscreenthree.dart';
TextEditingController amountcontroller=TextEditingController();
class NewLendOrBorrow2 extends StatelessWidget {
  const NewLendOrBorrow2({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(amountcontroller.text.toString().isEmpty!=true && amountcontroller.text.toString()!=" "){
          Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>NewLendOrBorrow3()));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please write a amount")));  
        }
      },child: Icon(Icons.arrow_forward_ios),),
      body: ListView(
        children: [
          Divider(
            height: 25,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(count==0?"Lend":"Borrow",style: TextStyle(color: Constants.color,fontSize: 60.0),),
          ),
          Divider(
            height: 50,
            color: Colors.transparent,
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextFormField(
                controller: amountcontroller,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    label: Container(
                      width: 86,
                      child: Row(
                        children: const [
                          Icon(Icons.attach_money),
                          SizedBox(width:5),
                          Text("Amount")
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