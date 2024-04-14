import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class Member {
  final String firstName;
  final String secondName;
  final String lastName;
  final String nationalID;
  final String kraPin;
  final String phoneNumber;
  final String residence;

  const Member({
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.nationalID,
    required this.kraPin,
    required this.phoneNumber,
    required this.residence});

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
        firstName: json['firstName'],
        secondName: json['secondName'],
        lastName: json['lastName'],
        nationalID: json['nationalID'],
        kraPin: json['kraPin'],
        phoneNumber: json['phoneNumber'],
        residence: json['residence']
    );
  }
}

class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String selectedGender = "";

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  TextEditingController krapinController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  // ========================= Create Member ====================================
  Future<void> createMember(
   String firstName,
   String secondName,
   String lastName,
   String nationalID,
   String kraPin,
   String phoneNumber,
   String residence) async {
    final repsonse = await http.post(
      Uri.parse('http://127.0.0.1:9000/api/register/'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Accept': "application/json"
      },
      body: jsonEncode(<String, String>
      {
        'first_name': firstName,
        'second_name': secondName,
        'last_name': lastName,
        'nationalID': nationalID,
        'kraPin': kraPin,
        'phone_number': phoneNumber,
        'residence': residence
      }),
    );
    if(repsonse.statusCode == 201){
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text("Created"),

        )
      );
      //return Member.fromJson(jsonDecode(repsonse.body) as Map<String, dynamic>);
    } else {
      List<dynamic> jsonResponse = json.decode(repsonse.body);
      var data = jsonResponse.first;
      Map<String, List<String>> _data = data;
      List<String> errorMessageList = [];
      _data.forEach((key, value) {
        for(String error in value){
          errorMessageList.add('$key: $error');
        }
      });
      print(_data);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text("Created"),

          )
          );
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Register Member'),
        elevation: 3,

      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children:<Widget>[
              TextField(
                controller: firstNameController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: secondNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Second Name'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: lastNameController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: nationalIDController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'National ID'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: krapinController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'KRA Pin'
                ),
              ),
              const SizedBox(height: 10,),
              const TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date Of Birth'
                ),
              ),
              const SizedBox(height: 10,),
              TextField(
                controller: phoneNumberController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number'
                ),
              ),
              const SizedBox(height: 10,),
              Column(
                children: [
                  ListTile(
                    title: const Text('Male'),
                    leading: Radio(
                        value: 'Male',
                        groupValue:selectedGender,
                        onChanged: (value) {
                          setState(() {
                              selectedGender = value!;
                          });
                        }
                    ),
                  ),
                  ListTile(
                    title: const Text('Female'),
                    leading: Radio(
                        value:'Female',
                        groupValue:selectedGender,
                        onChanged: (value) {
                          setState(() {
                            selectedGender = value!;
                          });
                        }
                    ),
                  )
                ],
              ),
              TextField(
                controller: residenceController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Residence'
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        createMember(
                            firstNameController.text,
                            secondNameController.text,
                            lastNameController.text,
                            nationalIDController.text,
                            krapinController.text,
                            phoneNumberController.text,
                            residenceController.text);
                      },
                      child: const Text('Register')
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: const Text('Cancel')
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
