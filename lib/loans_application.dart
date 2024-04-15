import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class makeApplication extends StatefulWidget {
  const makeApplication({super.key});

  @override
  State<makeApplication> createState() => _makeApplicationState();
}

class _makeApplicationState extends State<makeApplication> {
  TextEditingController _borrowerController = TextEditingController();
  TextEditingController _amountController = TextEditingController();
  TextEditingController _repaymentPeriod = TextEditingController();

  Future<void> loanApplication(Map<String, dynamic> loanData) async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.post(
        Uri.parse('http://127.0.0.1:9000/api/loan/application/'),
        headers: headers,
        body: jsonEncode(loanData),
      );
      if(response.statusCode == 200){
        print(json.decode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${ response.body }'),
            )
        );

      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('${ response.body }'),
            )
        );
      }
    } catch(e){

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Application Form', style: TextStyle(fontFamily:'poppins'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Card(
          elevation: 3,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextFormField(
                  controller: _borrowerController,
                  decoration: const InputDecoration(
                    hintText: 'National ID',
                    prefixIcon: Icon(Icons.account_box),

                  ),
                ),
                TextFormField(
                  controller: _amountController,
                  decoration: const InputDecoration(
                    hintText: 'Amount',
                    prefixIcon: Icon(Icons.money),

                  ),
                ),
                TextFormField(
                  controller: _repaymentPeriod,
                  decoration: const InputDecoration(
                    hintText: 'Repayment Period',
                    prefixIcon: Icon(Icons.calendar_month),

                  ),
                ),
                const SizedBox(height: 18,),
                ElevatedButton(
                    onPressed: (){
                      final loanData = {
                        'national_id': _borrowerController.text,
                        'repayment_period': _repaymentPeriod.text,
                        'amount': _amountController.text
                      };
                      loanApplication(loanData);
                    },
                    child: const Text('Submit Application',style: TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold),)
                ),
                const SizedBox(height: 18,),
                ElevatedButton(
                    onPressed: (){},
                    child: const Text('Cancel',style: TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold),)
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
