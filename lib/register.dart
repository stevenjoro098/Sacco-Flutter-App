import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:sacco_app/login.dart';


class Member {
  final String firstName;
  final String secondName;
  final String lastName;
  final String nationalID;
  final String kraPin;
  final String email;
  final String dob;
  final String phoneNumber;
  final String residence;
  final String password;

  const Member({
    required this.firstName,
    required this.secondName,
    required this.lastName,
    required this.nationalID,
    required this.kraPin,
    required this.email,
    required this.dob,
    required this.phoneNumber,
    required this.residence,
    required this.password
  });

  factory Member.fromJson(Map<String, dynamic> json){
    return Member(
        firstName: json['firstName'],
        secondName: json['secondName'],
        lastName: json['lastName'],
        nationalID: json['nationalID'],
        kraPin: json['kraPin'],
        email: json['email'],
        dob: json['dob'],
        phoneNumber: json['phoneNumber'],
        residence: json['residence'],
        password: json['password']
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
  DateTime selectedDate = DateTime.now();

  TextEditingController firstNameController = TextEditingController();
  TextEditingController secondNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController nationalIDController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController krapinController = TextEditingController();
  TextEditingController phoneNumberController = TextEditingController();
  TextEditingController dobController = TextEditingController();
  TextEditingController residenceController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  // ========================= Create Member ====================================
  Future<void> createMember(
   String firstName,
   String secondName,
   String lastName,
   String nationalID,
   String kraPin,
   String email,
   String dob,
   String gender,
   String phoneNumber,
   String residence,
   String password,
      ) async {
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
        'email': email,
        'dob':dob,
        'gender':gender,
        'phone_number': phoneNumber,
        'residence': residence,
        'password':password
      }),
    );
    if(repsonse.statusCode == 201){
      var jsonResponse = jsonDecode(repsonse.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonResponse['res']),
          )

      );
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const loginPage()));
      //
    } else if(repsonse.statusCode==403){
      var jsonResponse = json.decode(repsonse.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(jsonResponse['res']),
          )
      );

    } else{
      var jsonResponse = json.decode(repsonse.body);
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
      content: Text(jsonResponse['res']),
      )
      );

    }
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(1940, 8),
        lastDate: DateTime(2100),
    );
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
        dobController.text = picked.toString();
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text('Register Member'),
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
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email'
                ),
              ),
              const SizedBox(height: 20,),
               TextField(
                 controller: dobController,
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date Of Birth',
                  suffixIcon: IconButton(
                      onPressed: (){
                        _selectDate(context);
                      },
                      icon: Icon(Icons.calendar_month)
                  ),
                  suffixIconColor: Colors.blue
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
                        value: 'MALE',
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
                        value:'FEMALE',
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
              SizedBox(height: 10,),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                controller: password2Controller,
                decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Confirm Password'
                ),
              ),
              const SizedBox(height: 10,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (){
                        print(passwordController.text);
                        print(password2Controller.text);
                        if(passwordController.text == password2Controller.text){
                          createMember(
                              firstNameController.text,
                              secondNameController.text,
                              lastNameController.text,
                              nationalIDController.text,
                              krapinController.text,
                              emailController.text,
                              selectedDate.toString(),
                              selectedGender,
                              phoneNumberController.text,
                              residenceController.text,
                              password2Controller.text
                          );
                        }
                        else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Password Mismatch. Try Again!!"),
                              )
                          );
                        }

                      },
                      child: const Text('Register'),
                    style: ButtonStyle(
                      //backgroundColor: Colors.redAccent
                    ),
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
