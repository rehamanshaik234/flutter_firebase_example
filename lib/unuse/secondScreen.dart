

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
class SecondScreen extends StatefulWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override
  State<SecondScreen> createState() => _SecondScreenState();
}

class _SecondScreenState extends State<SecondScreen> {
  final TextEditingController textController1= TextEditingController();
  final TextEditingController textController2= TextEditingController();
  final TextEditingController textController3= TextEditingController();


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    textController1.dispose();
    textController2.dispose();
    textController3.dispose();

    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Screen'),),
      body: Center(
        child: Column(
          children: [const SizedBox(
            height: 20,
          ),
            Container(
              color: Colors.white,
              height: 40,
              width: 220,
              child: TextField(
                style: const TextStyle(color: Colors.blue),
                controller: textController1,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('Name'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              height: 40,
              width: 220,
              child: TextField(
                style: const TextStyle(color: Colors.blue),
                controller: textController2,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('Age'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Container(
              color: Colors.white,
              height: 40,
              width: 220,
              child: TextField(
                style: const TextStyle(color: Colors.blue),
                controller: textController3,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  label: Text('DOB'),
                  border: OutlineInputBorder(),
                ),
              ),
            ),const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 40,
              width: 220,
              child: ElevatedButton(onPressed: (){
                  create();
              },child: const Text('Create',style: TextStyle(color:Colors.white,),)),
            )
          ],
        ),
      ),
    );
  }

  Future create() async {
    final docUser= FirebaseFirestore.instance.collection('users').doc();
    final user= Users(name:textController1.text , age: int.parse(textController2.text), birthDay:textController3.text, id: docUser.id);

    await docUser.set(toJson(user: user));
  }

  Map<String,dynamic> toJson({required Users user})=>{
    'id':user.id,
    'name':user.name,
    'age':user.age,
    'DOB':user.birthDay
  };
}
class Users{
  late String id;
  late String name;
  late int age;
  late String birthDay;
  Users({required this.id,required this.name,required this.age,required this.birthDay});
  static Users fromJson(Map<String,dynamic> json) =>
      Users(
          id: json['id'],
          name: json['name'],
          age: json['age'],
          birthDay: json['DOB']
      );
}
