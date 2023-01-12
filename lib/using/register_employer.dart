import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:lottie/lottie.dart';

import 'list_employers.dart';
class RegisterEmployee extends StatefulWidget {
  const RegisterEmployee({Key? key}) : super(key: key);

  @override
  State<RegisterEmployee> createState() => _RegisterEmployeeState();
}

class _RegisterEmployeeState extends State<RegisterEmployee> {
  final List<String> items = [
    '0 years',
    '1 years',
    '2 years',
    '3 years',
    '4 years',
    '5 years',
    '5++ years'
  ];
  final List<String> statusList = [
    'Active',
    'Inactive'
  ];
  String phoneNumber='';
  String? experience;
  String? status;
  TextEditingController controller1=TextEditingController();
  final dbRef= FirebaseDatabase.instance.ref().child('Employees');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Register'),centerTitle: true,),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                height: MediaQuery.of(context).size.height*0.3,
                child: Lottie.asset('lottie/lottie-logo.json'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child:  TextField(
                  controller: controller1,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderSide: BorderSide(),
                    ),
                  ),
                  maxLines: 1,
                ),
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
            Padding(
              padding:  EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton2(
                  hint: const Text(
                    'Select Experience',
                    style: TextStyle(
                        fontSize: 18,
                        color:Colors.black
                    ),
                  ),
                  items: items
                      .map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                        ),
                      ))
                      .toList(),
                  value: experience,
                  onChanged: (value) {
                    setState(() {
                      experience = value as String;
                    });
                  },
                  dropdownOverButton: true,
                  dropdownDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,width: 2)

                  ),
                  buttonHeight: 40,
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonPadding: EdgeInsets.all(10),
                  scrollbarAlwaysShow: true,
                  itemHeight: 40,
                ),
              ),
            ),
            Padding(
              padding:  EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
              child: SizedBox(
                height: 50,
                width: MediaQuery.of(context).size.width,
                child: DropdownButton2(
                  hint: const Text(
                    'Select Status',
                    style: TextStyle(
                        fontSize: 18,
                        color:Colors.black
                    ),
                  ),
                  items: statusList
                      .map((item) =>
                      DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 18,
                              color: Colors.black
                          ),
                        ),
                      ))
                      .toList(),
                  value: status,
                  onChanged: (value) {
                    setState(() {
                      status = value as String;
                    });
                  },
                  dropdownOverButton: true,
                  dropdownDecoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(color: Colors.black,width: 2)

                  ),
                  buttonHeight: 40,
                  buttonWidth: MediaQuery.of(context).size.width,
                  buttonPadding: EdgeInsets.all(10),
                  scrollbarAlwaysShow: true,
                  itemHeight: 40,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 8.0,bottom: 16,left:32,right: 32 ),
              child: SizedBox(
                  width:  MediaQuery.of(context).size.width,
                  child: ElevatedButton(
                    onPressed: (){
                      if(controller1.text.isNotEmpty && experience!=null && status!=null&& phoneNumber!='' ){
                        Map<String,String> data={
                          'name':controller1.text.toString(),
                          'experience':experience.toString(),
                          'status':status.toString(),
                          'number': phoneNumber
                        };
                        dbRef.push().set(data);
                        toast('Sucessfully Updated', Colors.blue,context);
                      }
                     else{
                       if(controller1.text.isEmpty){
                         toast('Please Enter Name', Colors.red,context);

                       }else if(phoneNumber==''){
                         toast('Please Enter Number', Colors.red,context);

                       }
                       else if(experience==null){
                         toast('Please Select Experience', Colors.red,context);

                       }
                       else{
                         toast('Please Select Status', Colors.red,context);
                       }
                      }
                    },
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all(Colors.blue)),
                    child: Text('CONTINUE',style: TextStyle(color: Colors.white,fontSize: 16,fontWeight: FontWeight.w600),),


                  )
              ),
            )

          ],
        ),
      ),
    );
  }
}
ScaffoldFeatureController<SnackBar, SnackBarClosedReason> toast(String message,Color color,BuildContext context){
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
          backgroundColor : color,
          content: Text(message))
  );
}