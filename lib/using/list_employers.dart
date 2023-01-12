import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_example/using/register_employer.dart';
class EmployersList extends StatefulWidget {
  const EmployersList({Key? key}) : super(key: key);

  @override
  State<EmployersList> createState() => _EmployersListState();
}

class _EmployersListState extends State<EmployersList> {
  final query= FirebaseDatabase.instance.ref().child('Employees');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(title: const Text('Employees'),),
      body: Column(
        children: [
          Expanded(
              child: FirebaseAnimatedList(
                query: query,
                itemBuilder: (BuildContext context, DataSnapshot snapshot, Animation<double> animation, int index) {
                Map data= snapshot.value as Map;
                bool flag= false;
                var flaging=data['experience'].toString();
                if(int.parse(flaging[0].toString())>=5){
                 flag=true;
                }
                return snapshot.value!= null? Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ListTile(
                      title:Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: Text(data['name']),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: flag? Icon(Icons.flag,color: Colors.green,):Text(''),
                          ),
                        ],
                      ),
                      subtitle: Padding(
                        padding: const EdgeInsets.all(0.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(data['number'].toString()),
                            SizedBox(height: 8,),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(data['experience']),
                                Row(
                                  children: [
                                    Icon(Icons.circle,color:data['status'].toString()=='Active'? Colors.green : Colors.red,size: 10,),
                                    SizedBox(width: 8,),
                                    Text(data['status']),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ) : Center( child:  CircularProgressIndicator(color: Colors.blue,));
                },

              )
          )
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: (){
        Navigator.of(context).push(MaterialPageRoute(builder: (context)=> RegisterEmployee()));
      },child: Icon(Icons.add,color: Colors.white,),tooltip: 'Add Employers',),
    );
  }
}
String number='';