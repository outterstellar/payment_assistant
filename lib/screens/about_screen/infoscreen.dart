import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentassistant/data/constants.dart';

import '../../data/model.dart';
import '../home_screen/home_screen_widgets/borrow.dart';
import '../home_screen/home_screen_widgets/lendscreen.dart';
import '../home_screen/homescreen.dart';
import '../new_lend_or_borrow/newlendorborrow.dart';
import '../new_lend_or_borrow/newlendorborrowtwo.dart';
import '../new_lend_or_borrow/newlendscreenthree.dart';


bool edited=false;
Model? model_that_will_be_deleted;
int index2=0;
class InfoScreen extends StatelessWidget {
  String name;
  String explanation;
  double amount;
  bool value_equals_to_lend;
  int index;
  InfoScreen({Key? key,required this.explanation,required this.name,required this.amount,required this.value_equals_to_lend,required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
  automaticallyImplyLeading: false,
  title: Text(
    "Payment Assistant",
    style: TextStyle(color: Constants.color, fontSize: 25),
  ),
  backgroundColor: Colors.transparent,
  elevation: 0,
  actions: [
    IconButton(onPressed: (){
      lends.forEach((element) {
          debugPrint(element.name);
        });
      if(value_equals_to_lend==true){
        lends.removeAt(index);
        lends.forEach((element) {
          debugPrint(element.name);
        });
        newlends=true;
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomeScreen()));
      }else{
        borrows.removeAt(index);
        newborrows=true;
        Navigator.push(context, CupertinoPageRoute(builder: (context)=>HomeScreen()));
      }
    }, icon: Image.asset("images/info_screen/trash.png",height: 25,width: 20,fit: BoxFit.fill,)),
    IconButton(
      onPressed: (){
        edited=true;
        index2=index;
        namecontroller2.text=name;
        commentcontroller.text=explanation;
        amountcontroller.text=amount.toString();
        Navigator.of(context).push(CupertinoPageRoute(
          builder:(context)=>NewLendOrBorrow()
        ));
      },icon: Image.asset("images/info_screen/draw.png",height: 25,width: 25,fit: BoxFit.fill,),
    )
  ],
),
      body: Center(
        child: SizedBox(
          height:MediaQuery.of(context).size.height-200,
            width:MediaQuery.of(context).size.width-50,
          child: Card(
            child:ListView(
              children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(name.characters.first.toUpperCase()+name.substring(1,name.length),style: TextStyle(fontSize: 50,color: Colors.blue),),
              ),
              Padding(
                padding: const EdgeInsets.all(24.0),
                child: Text(explanation,style: TextStyle(fontSize: 30),),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(amount.toString(),style: TextStyle(fontSize: 25),),
              )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
