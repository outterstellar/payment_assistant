import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paymentassistant/main.dart';
import 'package:paymentassistant/screens/new_lend_or_borrow/newlendorborrow.dart';
import '../../data/constants.dart';
import '../log_in/loginscreen.dart';
import '../settings/accountscreen.dart';
import 'home_screen_widgets/borrow.dart';
import 'home_screen_widgets/lendscreen.dart';

bool are_there_any_error = false;

class HomeScreen extends StatefulWidget {
  HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int howManyTimesYouTap = 1;
String email = "";
String password = "";
int count = 0;

class _HomeScreenState extends State<HomeScreen> {
  bool pressed = false;
  @override
  void initState() {
    super.initState();
    email = sharedPreferences!.getString("email")!;
    password = sharedPreferences!.getString("password")!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      endDrawer: Drawer(
        child: SafeArea(
          child: ListTile(
            leading: Text("Account"),
            onTap: () => Navigator.of(context).push(
                CupertinoPageRoute(builder: ((context) => AccountScreen()))),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
              CupertinoPageRoute(builder: (context) => NewLendOrBorrow()));
        },
        child: Text(
          "+",
          style: TextStyle(fontSize: 28),
        ),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        foregroundColor: Colors.black,
        title: Text(
          "Payment Assistant",
          style: TextStyle(color: Constants.color, fontSize: 25),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (pressed_button) {
            
            howManyTimesYouTap++;
             if ((howManyTimesYouTap % 6) == 0) {
              myAd!.show();
            } 
            setState(
              () {
                count = pressed_button;
              },
            );
          },
          currentIndex: count,
          type: BottomNavigationBarType.fixed,
          items: [
            BottomNavigationBarItem(
                icon: Image.asset(
                  "images/home/increase-money.png",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
                label: "Lends"),
            BottomNavigationBarItem(
                icon: Image.asset(
                  "images/home/decrease-money.png",
                  fit: BoxFit.cover,
                  height: 40,
                  width: 40,
                ),
                label: "Borrows")
          ]),
      body: count == 0 ? LendScreen() : BorrowScreen(),
    );
  }
}

void deleteCharacter({required BuildContext context}) {
  try {
    auth
        .signInWithEmailAndPassword(email: email, password: password)
        .then((value) => null)
        .onError((error, stackTrace) {
      are_there_any_error = true;
    });
    auth.currentUser!
        .delete()
        .then((value) => null)
        .onError((error, stackTrace) {
      are_there_any_error = true;
    });
    if (are_there_any_error == false) {
      firestore.collection("users").doc(email).delete();
      sharedPreferences!.setBool("remember", false);
      sharedPreferences!.setString("email", "");
      sharedPreferences!.setString("password", "");
      Navigator.pushReplacement(
          context, CupertinoPageRoute(builder: (context) => LoginScreen()));
    } else {
      Navigator.of(context).pop();
      showCupertinoDialog(context: context, builder: (context)=>CupertinoAlertDialog(
        content: Text("An Error Occured , Please Try Again Later."),
        actions: [CupertinoButton(child: 
        Text("Ok"), onPressed: (){
          Navigator.of(context).pop();
        })],
      ));
    }
  } catch (e) {}
}

void logOut(BuildContext context) {
  showDialog(
      context: context,
      builder: (context) => Center(
            child: CircularProgressIndicator(),
          ));
  try {
    auth.signOut();
    sharedPreferences!.setBool("remember", false);
    sharedPreferences!.setString("email", "");
    sharedPreferences!.setString("password", "");
    Navigator.of(context).pushAndRemoveUntil(
        CupertinoPageRoute(builder: (context) => LoginScreen()),
        (route) => false);
  } catch (e) {
    Navigator.of(context).pop();
  }
}
