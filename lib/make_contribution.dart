import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MakeContribution extends StatefulWidget {
  const MakeContribution({super.key});

  @override
  State<MakeContribution> createState() => _MakeContributionState();
}

class _MakeContributionState extends State<MakeContribution> {

  TextEditingController _textEditingController = TextEditingController();
  TextEditingController _fullnameController = TextEditingController();
  TextEditingController _nationalIDController = TextEditingController();
  TextEditingController _amountController = TextEditingController();

  // *************************** Send Contribution ********************************
  void resetTextController(){
    _amountController.text = '';
    _fullnameController.text = '';
    _nationalIDController.text = '';
  }
  Future<void> sendMemberContribution(Map<String, dynamic> contribData)async {
    final url = 'http://127.0.0.1:9000/api/make/contribution/';

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(contribData),
      );
      if(response.statusCode == 200){
        List<dynamic> res = jsonDecode(response.body);
        print(res[0]);
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text('${ res[0] }'),
            )
        );
        resetTextController();
      } else if(response.statusCode == 404){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Member Not Found"),
            )
        );
      }
    } catch(e){
      print('Error: $e');
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contribute'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
                'Member Details.',
                style: TextStyle(
                  fontFamily: 'poppins',
                  fontSize: 20,
                  fontWeight: FontWeight.bold,

                )
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [

                    TextFormField(
                      controller: _fullnameController,
                      decoration: const InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Icon(Icons.person)
                      ),
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return 'Please Enter First Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _nationalIDController,
                      decoration: const InputDecoration(
                          hintText: 'National ID No.',
                          prefixIcon: Icon(Icons.numbers)
                      ),
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return 'Please Enter First Name';
                        }
                        return null;
                      },
                    ),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(
                          hintText: 'Amount',
                          prefixIcon: Icon(Icons.attach_money_sharp)
                      ),
                      validator: (String? value){
                        if(value == null || value.isEmpty){
                          return 'Please Enter Amount';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 20,)
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20,),
            const Text(
              'Mode of Payment:',
              style: TextStyle(
              fontFamily: 'poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18
              ),
            ),
            Card(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'MPESA',
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8.0),
                    const Text('Enter Mobile Number to Initiate transaction'),
                    const SizedBox(height: 16.0),

                    TextFormField(
                      controller: _textEditingController,
                      decoration: const InputDecoration(
                        labelText: '254**********',
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(height: 6,),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                            onPressed: (){
                              final contribData = {
                                'full_name': _fullnameController.text,
                                'national_id': _nationalIDController.text,
                                'amount': _amountController.text
                              };
                              //print(contribData);
                              sendMemberContribution(contribData);
                            },
                            child: Text('Pay')
                        ),
                        ElevatedButton(onPressed: (){
                          _textEditingController.text = "";
                        }, child: Text('Cancel'))
                      ],
                    )


                  ],
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}
