import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_example/unuse/secondScreen.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:lottie/lottie.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/style.dart';

import 'list_employers.dart';
class VerifyOTP extends StatefulWidget {
  late String verificationID;

  VerifyOTP({required this.verificationID, super.key});

  @override
  State<VerifyOTP> createState() => _VerifyOTPState();
}

class _VerifyOTPState extends State<VerifyOTP> {
  OtpFieldController otpController = OtpFieldController();
  String otpPin='';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: MediaQuery.of(context).size.height/7,),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height*0.4,
                  child: Lottie.asset('lottie/lottie2.json'),
                ),
              ),
              SizedBox(height: 40,),

              Padding(
                padding: const EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
                child: SizedBox(
                  width: MediaQuery.of(context).size.width,
                  child:OtpTextField(
                    numberOfFields: 6,
                    borderColor: Color(0xFF512DA8),
                    //set to true to show as box or false to show as dash
                    showFieldAsBox: false,
                    //runs when a code is typed in
                    onCodeChanged: (String code) {
                      print(code);
                      //handle validation or checks here
                    },
                    //runs when every textfield is filled
                    onSubmit: (String verificationCode){
                      setState(() {
                        otpPin=verificationCode;
                      });
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("Verification Code"),
                              content: Text('Code entered is $verificationCode'),
                            );
                          }
                      );

                    }, // end onSubmit
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
                        verifyOTp();
                      },
                      style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                      child: Text('CONTINUE',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),


                    )
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> verifyOTp()async{
    final auth=await FirebaseAuth.instance.signInWithCredential(
        PhoneAuthProvider.credential(
            verificationId: widget.verificationID,
            smsCode:otpPin));
    if(auth.user!= null){
      Navigator.of(context).push(MaterialPageRoute(builder: (context)=> EmployersList()));
    }else{
    }
  }
}
