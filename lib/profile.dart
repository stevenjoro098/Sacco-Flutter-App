import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'login.dart';

class userProfile extends StatefulWidget {
  var idNo;
  userProfile({super.key, required this.idNo});

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  bool _displayEditForm = false;
  final _formKey = GlobalKey<FormState>();

  String firstName = "";
  String secondName = "";
  String thirdName = "";
  String idNo = "";
  String dob = "";
  String gender = "";
  String telephone = "";
  String residence = "";
  String imagePath = "";
  Future<void> getProfile() async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.post(
          Uri.parse('http://127.0.0.1:9000/api/member/profile/'),
          headers: headers,
          body: jsonEncode({"id_no": widget.idNo})
      );
      if(response.statusCode == 200){

        var response_data = jsonDecode(response.body);

        setState(() {
          imagePath = response_data['image'];
          firstName = response_data['first_name'];
          secondName = response_data['second_name'];
          thirdName = response_data['third_name'];
          idNo = response_data['id_no'];
          dob = response_data['dob'];
          gender = response_data['gender'];
          telephone = response_data['telephone'];
          residence = response_data['residence'];

        });

      } else {
        var response_data = jsonDecode(response.body);
        print(response_data);
      }
    } catch(e){

    }
  }
  @override
  void initState(){
    super.initState();
    getProfile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
              onPressed:(){
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const loginPage()));


              },
              icon: const Icon(Icons.login)
          ),
          const SizedBox(width: 30,),

        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
                Card(
                  color: Colors.greenAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const SizedBox(width: 10,),
                         Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            imagePath.isEmpty ? Image.asset('assets/images/profile.png', width: 100, height: 100,)
                                :ClipRRect(borderRadius: BorderRadius.circular(26), child: Image.network('http://127.0.0.1:9000/media/${imagePath}', width: 300, height: 200,)),
                            const SizedBox(height: 10,),
                            const Text('Name:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("${ firstName } ${ secondName } ${thirdName}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.blue)),
                            const Text('National ID/Passport:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text("${idNo}",style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.blue)),
                            const Text('Residence:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(residence, style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.blue)),
                            const Text('DOB:',style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Text(dob,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 17, color: Colors.blue)),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: (){
                      setState(() {
                        _displayEditForm = !_displayEditForm;
                      });
                    },
                    child: const Text('Edit Profile'),
                  ),
                ],
              ),
              if(_displayEditForm)...[
                Card(
                  color: Colors.lightBlueAccent[100],
                  child: Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Column(
                      children: [
                        const Row(
                          children: [
                            Icon(Icons.person),
                            SizedBox(width: 20,),
                            Text('Edit Profile Form'),
                          ],
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Full Name'
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                            labelText: 'National ID/Passport'
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'Residence'
                          ),
                        ),
                        TextFormField(
                          decoration: const InputDecoration(
                              labelText: 'DOB'
                          ),
                        ),
                        const SizedBox(height: 20,),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            TextButton(
                              onPressed: (){},
                              child: const Text('Save'),
                            ),
                            TextButton(
                              onPressed: (){},
                              child: const Text('Cancel'),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                )
              ]
        
            ],
          ),
        ),
      ),
    );
  }
}
