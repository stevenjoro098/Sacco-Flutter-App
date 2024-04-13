import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

enum genderCharacter { Male, Female }
class Register extends StatefulWidget {
  const Register({super.key});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {

  String selectedGender = "";

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
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  labelText: 'First Name'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Second Name'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Last Name'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'National ID'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'KRA Pin'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Date Of Birth'
                ),
              ),
              SizedBox(height: 10,),
              TextField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Phone Number'
                ),
              ),
              SizedBox(height: 10,),
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
                decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Residence'
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('Register')
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: Text('Cancel')
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
