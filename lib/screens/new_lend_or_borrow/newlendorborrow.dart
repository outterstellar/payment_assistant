import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/constants.dart';
import '../home_screen/homescreen.dart';
import '../log_in/loginscreen.dart';
import 'newlendorborrowtwo.dart';
TextEditingController namecontroller2=TextEditingController();
class NewLendOrBorrow extends StatelessWidget {
  const NewLendOrBorrow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appbar,
      floatingActionButton: FloatingActionButton(onPressed: (){
        if(namecontroller2.text.toString().isEmpty!=true && namecontroller2.text.toString()!=" "){
          Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>NewLendOrBorrow2()));
        }else{
          ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Please write a name")));  
        }
      },child: Icon(Icons.arrow_forward_ios_outlined),),
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
              maxLength: 20,
                keyboardType: TextInputType.name,
                controller: namecontroller2,
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12)),
                    label: Container(
                      width: 72,
                      child: Row(
                        children: const [
                          Icon(Icons.person),
                          SizedBox(width:5),
                          Text("Name")
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