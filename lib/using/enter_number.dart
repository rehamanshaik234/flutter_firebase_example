import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_example/using/list_employers.dart';
import 'package:flutter_firebase_example/using/verify_otp.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

class Mobile extends StatefulWidget {
  const Mobile({Key? key}) : super(key: key);

  @override
  State<Mobile> createState() => _MobileState();
}

class _MobileState extends State<Mobile> {
  String verifyID='';
  String  phoneNumber='';
  TextEditingController otp=TextEditingController();
  final formKey=GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Data'),),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.4,
                  child: Lottie.asset('lottie/lottie-logo.json'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:  IntlPhoneField(
                    
                    decoration: InputDecoration(
                      labelText: 'Phone Number',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                    initialCountryCode: 'IN',
                    onChanged: (phone) {
                      setState(() {
                        phoneNumber=phone.completeNumber;
                      });
                    },
                    onCountryChanged: (country) {
                      print('Country changed to: ' + country.name);
                    },
                  ),
                ),
              ),
              SizedBox(height: 40,),
              Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
                child: SizedBox(
                  width:  MediaQuery.of(context).size.width,
                  child: TextButton(
                    onPressed: (){
                      print(phoneNumber);
                      setState(() {
                        number=phoneNumber;
                      });
                      sendNumber(phoneNumber);
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    child: Text('VERIFY',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),


                  )
                ),
              ),

            ],
          ),
        ),
      ),
      /*StreamBuilder(
        stream: readUsers(),
        builder: (context, AsyncSnapshot<List<Users>> snapshot){
            final users = snapshot.data;
            return ListView(
              children: users!.map(buildUser).toList(),
            );
          }
        ),*/
    );
  }
  Future<void> sendNumber(String number)async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: number,
        verificationCompleted: (PhoneAuthCredential credential){
        print(credential.verificationId);
        },
        verificationFailed: (FirebaseAuthException e){

        },
        codeSent: (String verifyId,token){
        setState(() {
          verifyID=verifyId;
        });
        },
        codeAutoRetrievalTimeout: (codeAutoRetrievalTimeout){
        }
    ).whenComplete(() => Navigator.of(context).push(MaterialPageRoute(builder: (context) =>VerifyOTP( verificationID: verifyID,))));
  }
}
