import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class MakeContribution extends StatefulWidget {
  var firstName;
  var secondName;
  var thirdName;

   MakeContribution({super.key,
        required this.idNo,
        required this.firstName,
        required this.secondName,
        required this.thirdName
        });

  final String idNo;

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

  void setTextController (){
    _fullnameController.text = "${widget.firstName} ${ widget.secondName } ${ widget.thirdName}";
    _nationalIDController.text = widget.idNo;
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
                    content:Text(res[0], style: const TextStyle(color: Colors.black,fontWeight: FontWeight.bold),
                ),
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
  void initState(){
      super.initState();
      setTextController();
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
             const Row(
               children: [
                 Padding(
                   padding: const EdgeInsets.all(8.0),
                   child: Text(
                      'Member Details.',
                      style: TextStyle(
                        fontFamily: 'poppins',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,

                      )
                               ),
                 ),
               ],
             ),
            Card(
              color: Colors.blue[100],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: [

                    TextFormField(
                      controller: _fullnameController,
                      readOnly: true,
                      decoration:  InputDecoration(
                          hintText: 'Full Name',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/profile.png', width: 30,),
                          ),
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
                      readOnly: true,
                      decoration:  InputDecoration(
                          hintText: 'National ID No.',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/id.png', width: 30,),
                          ),
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
                      decoration: InputDecoration(
                          hintText: 'Amount',
                          prefixIcon: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Image.asset('assets/images/money.png', width: 30,),
                          ),
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
            const Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Text(
                    'Mode of Payment:',
                    style: TextStyle(
                    fontFamily: 'poppins',
                      fontWeight: FontWeight.bold,
                      fontSize: 18
                    ),
                  ),
                ],
              ),
            ),
            Card(
              color: Colors.lightGreen[100],
              child: Padding(
                padding: const EdgeInsets.all(10.0),
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
                      decoration: InputDecoration(
                        labelText: '254**********',
                        border: OutlineInputBorder(),
                        prefixIcon: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Image.asset('assets/images/mobile_phone.png', width: 30,),
                        )
                      ),
                    ),
                    const SizedBox(height: 20,),
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
                            child: const Text('Pay', style:TextStyle(fontWeight: FontWeight.bold),)
                        ),
                        ElevatedButton(onPressed: (){
                          _textEditingController.text = "";
                        },
                            child: Text('Cancel', style: TextStyle(fontWeight: FontWeight.bold),)
                        )
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
