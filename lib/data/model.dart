import 'package:cloud_firestore/cloud_firestore.dart';

class Model{
  late double amount;
  late String name;
  late String explanation;
  Model({required this.name,required this.amount,required this.explanation});

}