import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';
class RealData extends StatefulWidget {
  const RealData({Key? key}) : super(key: key);

  @override
  State<RealData> createState() => _RealDataState();
}

class _RealDataState extends State<RealData> {
  late final TextEditingController controller1;
  late final TextEditingController controller2;
  late final DatabaseReference firebaseDatabase;
  @override
  void initState() {
    firebaseDatabase= FirebaseDatabase.instance.ref().child('Students');
    controller1 = TextEditingController();
    controller2=TextEditingController();
    super.initState();
  }
  @override
  void dispose() {
    controller1.dispose();
    controller2.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:const Text('Insert Data')),
      // ignore: prefer_const_literals_to_create_immutables
      body: Center(
        child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const  SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child:TextField(
                  style: TextStyle(color: Colors.black),
                  maxLines: 1,
                  controller: controller1,
                  keyboardType: TextInputType.emailAddress,
                  decoration: const InputDecoration(
                      label: Text('Email'),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                height: 40,
                width: 300,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                child:   TextField(
                  style: const TextStyle(color: Colors.black),
                  maxLines: 1,
                  keyboardType: TextInputType.visiblePassword,
                  controller: controller2,
                  decoration:const  InputDecoration(
                      label: Text('Password'),
                      border: OutlineInputBorder()
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Container(
                  height: 30,
                  width: 200,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
                  child:ElevatedButton(onPressed: (){
                    String email= controller1.text;
                    String pwd=controller2.text;
                    Map<String,dynamic> obj= {'email':email.toString(),'password':pwd.toString()};
                    firebaseDatabase.push().set(obj);
                  },child: const Text('Create'),)
              ),
            ]
        ),
      ),
    );
  }
}
