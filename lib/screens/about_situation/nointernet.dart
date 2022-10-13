import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../main.dart';

class NoInternets extends StatelessWidget {
  const NoInternets({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text("No Internet !!!",style: TextStyle(fontSize: 16),),
              Text("We Miss You Please Connect To Internet",style: TextStyle(fontSize: 16)),
              ElevatedButton(child: Text("Retry"),onPressed: (){
                Connectivity().checkConnectivity().then((value){
    if(value==ConnectivityResult.none){
      no_internet=true;
    }else{
      no_internet=false;
    }
   });
  Navigator.of(context).pushAndRemoveUntil(CupertinoPageRoute(builder: (context)=>MyApp()),(route) => false,);
              },)],
          ),
        ),
      ),
    );
  }
}
