

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model.dart';
import '../homescreen.dart';
import '../../about_screen/infoscreen.dart';
import '../../../main.dart';

class BorrowScreen extends StatefulWidget {
  const BorrowScreen({Key? key}) : super(key: key);

  @override
  State<BorrowScreen> createState() => _BorrowScreenState();
}
bool datas_first_come2=false;
bool newborrows=false;
List<Model> borrows=[];
class _BorrowScreenState extends State<BorrowScreen> {
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(builder: ((context, snapshot){
      if(datas_first_come2==false || newborrows==true){
            datas_first_come2=true;
            newborrows=false;
      if(snapshot.connectionState==ConnectionState.done){
        return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: CircleAvatar(
              radius: 200,
              child: Text(getAmount().toDouble().toString())
            ),
          ),const Flexible(child: Divider(
            height: 50,
          )),Flexible(
            flex: 3,
            child: ListView.builder(itemBuilder: ((context, index) {
              return ListTile(
                onTap: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>InfoScreen(explanation: borrows[index].explanation, name: borrows[index].name, amount:  borrows[index].amount,value_equals_to_lend: false,index: index,)));
                },
                leading: CircleAvatar(child: Text(borrows[index].name.characters.first)),
                title: Text(borrows[index].name),
                trailing: Text(borrows[index].amount.toString()),
                subtitle: Text(returnExplanataion(index)),
              );
      
            }),itemCount: borrows.length,)
            
            ),
          
        ],
      ),
    );
      }else if(snapshot.hasError){
       return Center(
        child: Image.asset("images/i.jpg"),
       );
      }else{
        return const Center(child: CircularProgressIndicator());
      }
      }else{return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          Flexible(
            flex: 2,
            child: CircleAvatar(
              radius: 200,
              child: Text(getAmount().toDouble().toString())
            ),
          ),Flexible(child: Divider(
            height: 50,
          )),Flexible(
            flex: 3,
            child: ListView.builder(itemBuilder: ((context, index) {
              return ListTile(
                onTap: (){
                  Navigator.of(context).push(CupertinoPageRoute(builder: (context)=>InfoScreen(explanation: borrows[index].explanation, name: borrows[index].name, amount:  borrows[index].amount,value_equals_to_lend: false,index: index,)));
                },
                leading: CircleAvatar(child: Text(borrows[index].name.characters.first)),
                title: Text(borrows[index].name),
                trailing: Text(borrows[index].amount.toString()),
                subtitle: Text(returnExplanataion(index)),
              );
      
            }),itemCount: borrows.length,)
            
            ),
          
        ],
      ),
    );}
    }),future: newborrows==false&& datas_first_come2==false?firestore.collection("users").doc(email).get().then((value) {
      List ahandayenicikanlendler=value.data()?["borrows"];
      debugPrint("liste"+ahandayenicikanlendler.toString());
      for (var i = 0; i < ahandayenicikanlendler.length; i++) {
        borrows.add(Model(name: ahandayenicikanlendler[i]["isim"], amount:double.parse( ahandayenicikanlendler[i]["miktar"].toString()), explanation: ahandayenicikanlendler[i]["aciklama"]));
      }
      debugPrint(borrows.toString());
    
      
    }):firestore.collection("users").doc(email).update({"borrows":createListFromBorrows()})

    
    );
  }
}
double amount=0;
double getAmount(){
  amount=0;
  borrows.forEach((element) {
            amount = amount+element.amount;
          });
          return amount;
}
List createListFromBorrows(){
  List liste=[];
  for (var i = 0; i < borrows.length; i++) {
    liste.add({"isim":borrows[i].name,"miktar":borrows[i].amount,"aciklama":borrows[i].explanation});
  }
  return liste;
}
String returnExplanataion(
index
){
  String  aciklama=borrows[index].explanation;
  if(aciklama.length<=25){
    return aciklama;
  }else{
    return aciklama.substring(0,25); }
}
