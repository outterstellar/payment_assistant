import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../data/model.dart';
import '../../../main.dart';
import '../../about_screen/infoscreen.dart';
import '../homescreen.dart';

class LendScreen extends StatefulWidget {
  const LendScreen({Key? key}) : super(key: key);

  @override
  State<LendScreen> createState() => _LendScreenState();
}

bool newlends = false;
double amount = 0;
List<Model> lends = [];
bool datas_first_come = false;

class _LendScreenState extends State<LendScreen> {
  var data_have_came = false;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        builder: ((context, snapshot) {
          if (datas_first_come == false || newlends == true) {
            datas_first_come = true;
            newlends = false;
            if (snapshot.connectionState == ConnectionState.done) {
              return SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    Flexible(
                      flex: 2,
                      child: CircleAvatar(
                          radius: 200,
                          child: Text("-${an().toDouble().toString()}")),
                    ),
                    Flexible(
                        child: Divider(
                      height: 50,
                    )),
                    Flexible(
                        flex: 3,
                        child: ListView.builder(
                          itemBuilder: ((context, index) {
                            return ListTile(
                              onTap: () {
                                Navigator.of(context).push(CupertinoPageRoute(
                                    builder: (context) => InfoScreen(
                                          explanation: lends[index].explanation,
                                          name: lends[index].name,
                                          amount: lends[index].amount,
                                          value_equals_to_lend: true,
                                          index: index,
                                        )));
                              },
                              leading: CircleAvatar(
                                  child:
                                      Text(lends[index].name.characters.first)),
                              title: Text(lends[index].name),
                              trailing: Text(lends[index].amount.toString()),
                              subtitle: Text(returnExplanation(index)),
                            );
                          }),
                          itemCount: lends.length,
                        )),
                  ],
                ),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Image.asset("images/i.jpg"),
              );
            } else {
              return Center(child: CircularProgressIndicator());
            }
          } else {
            return SizedBox(
              height: MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width,
              child: Column(
                children: [
                  Flexible(
                    flex: 2,
                    child: CircleAvatar(
                        radius: 200,
                        child: Text("-${an().toDouble().toString()}")),
                  ),
                  Flexible(
                      child: Divider(
                    height: 50,
                  )),
                  Flexible(
                      flex: 3,
                      child: ListView.builder(
                        itemBuilder: ((context, index) {
                          return ListTile(
                            onTap: () {
                              Navigator.of(context).push(CupertinoPageRoute(
                                  builder: (context) => InfoScreen(
                                        explanation: lends[index].explanation,
                                        name: lends[index].name,
                                        amount: lends[index].amount,
                                        value_equals_to_lend: true,
                                        index: index,
                                      )));
                            },
                            leading: CircleAvatar(
                                child:
                                    Text(lends[index].name.characters.first)),
                            title: Text(lends[index].name),
                            trailing: Text(lends[index].amount.toString()),
                            subtitle: Text(returnExplanation(index)),
                          );
                        }),
                        itemCount: lends.length,
                      )),
                ],
              ),
            );
          }
        }),
        future: newlends == false && datas_first_come == false
            ? firestore.collection("users").doc(email).get().then((value) {
                List newlendslist = value.data()?["lends"];
                debugPrint("liste" + newlendslist.toString());
                for (var i = 0; i < newlendslist.length; i++) {
                  lends.add(Model(
                      name: newlendslist[i]["isim"],
                      amount:
                          double.parse(newlendslist[i]["miktar"].toString()),
                      explanation: newlendslist[i]["aciklama"]));
                }
                debugPrint(lends.toString());
              })
            : firestore
                .collection("users")
                .doc(email)
                .update({"lends": createListFromLends()}));
  }
}

double an() {
  amount = 0;
  lends.forEach((element) {
    amount = amount + element.amount;
  });
  return amount;
}

Future<Object?>? future() {
  Map map = {};
  firestore.collection("users").doc(email).get().then((value) {
    map = value.data()!;
  });
}

List createListFromLends() {
  List list = [];
  for (var i = 0; i < lends.length; i++) {
    list.add({
      "isim": lends[i].name,
      "miktar": lends[i].amount,
      "aciklama": lends[i].explanation
    });
  }
  return list;
}

String returnExplanation(index) {
  String explanation = lends[index].explanation;
  if (explanation.length <= 25) {
    return explanation;
  } else {
    return explanation.substring(0, 25);
  }
}
