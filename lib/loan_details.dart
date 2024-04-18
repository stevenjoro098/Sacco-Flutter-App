import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class loanDetails extends StatefulWidget {
  const loanDetails({super.key});

  @override
  State<loanDetails> createState() => _loanDetailsState();
}

class _loanDetailsState extends State<loanDetails> {
  var responseData;
  late Map<String, dynamic> loanDetails = {};
  late List<dynamic> loanRepayments = [];
  Future<void> getLoanDetails() async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.post(
        Uri.parse('http://127.0.0.1:9000/api/loan/details/?param=30306701'),
        headers: headers,
        body: jsonEncode({'loan_id':'2'}),

      );
      if(response.statusCode == 200){
        print(json.decode(response.body));
        responseData = json.decode(response.body);
        setState(() {
          loanDetails = responseData['loan_details'];
          loanRepayments = responseData['loan_repayment'];
        });

      } else if( response.statusCode == 404){
        print(json.decode(response.body));
      } else {

      }
    } catch(e){

    }
  }
  @override
  void initState(){
    super.initState();
    getLoanDetails();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details', style: TextStyle(fontFamily: 'poppins'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Card(
              elevation: 2,
              child: Column(
                children: [
                  ListTile(
                    title: Text('Period: ${loanDetails['period']} days'),
                    subtitle: Text('Target Amount: ${loanDetails['target_amount']}'),
                  ),
                  ListTile(
                    title: Text('From Date: ${loanDetails['from_date']}'),
                    subtitle: Text('To Date: ${loanDetails['to_date']}'),
                  ),
                  ListTile(
                    title: Text('Total Paid: ${loanDetails['total_paid']}'),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),
            const Text(
              'Loan Repayments:',
              style: TextStyle(fontFamily:'poppins',fontSize: 18, fontWeight: FontWeight.bold),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: loanRepayments.length,
              itemBuilder: (context, index) {
                final repayment = loanRepayments[index];
                return Card(
                  elevation: 2,
                  color: Colors.grey[200],
                  child: ListTile(
                    title: Text('Amount: ${repayment['amount']}', style: const TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                    subtitle: Text('Date Paid: ${repayment['date_paid']}', style: const TextStyle(fontFamily: 'poppins'),),
                  ),
                );
              },
            ),
          ],

        ),
      ),
    );
  }
}
