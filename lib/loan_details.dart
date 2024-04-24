import 'dart:convert';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'loan_repayment.dart';

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
        //print(json.decode(response.body));
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text(json.decode(response.body)),
            )
        );
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
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Card(
                elevation: 2,
                color: Colors.blueAccent,
                child: Column(
                  children: [
                    ListTile(
                      title: Text('Target Amount:-> ${loanDetails['amount']}', style: const TextStyle(fontWeight: FontWeight.bold),),
                      subtitle: Text('Repayment Period: ${loanDetails['repayment_term']} days', style: const TextStyle(fontWeight: FontWeight.bold),),
                      trailing: Chip(
                        label: Text('${ loanDetails['interest_rate']} %', style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.bold),),
                        backgroundColor: Colors.deepOrangeAccent,
                      ),
                    ),
                    ListTile(
                      title: Text('Date Applied: ${ loanDetails['date_applied']}', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),),
                      subtitle: Text('Date Approve: ${ loanDetails['date_approved']}', style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'poppins'),),
                    ),
                    ListTile(
                      title: Text('Total Paid: ${loanDetails['total_paid']}', style: const TextStyle(fontWeight: FontWeight.bold),),
                    ),
                    ListTile(
                      title: Text('Guarantor(s): ${ loanDetails['guarantors']}', style: TextStyle(fontWeight: FontWeight.bold),),
                    )
                  ],
                ),
              ),
        
              const SizedBox(height: 20),
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Image.asset('assets/images/spending.png', width: 40, height: 40,)
                  ),
                  const Text(
                    'Loan Repayments:',
                    style: TextStyle(fontFamily:'poppins',fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const loanRepayment()));
        
                      },
                      icon: const Icon(Icons.mobile_screen_share_outlined),
                  )
                ],
              ),
              if (loanRepayments.isEmpty) Center(
                    child: Image.asset('assets/images/not-found.gif', width: 200, height: 200)
                  ) else ListView.builder(
                        shrinkWrap: true,
                        itemCount: loanRepayments.length,
                        itemBuilder: (context, index) {
                          final repayment = loanRepayments[index];
                          return Card(
                            elevation: 2,
                            color: Colors.yellow,
                            child: ListTile(
                              title: Text('Amount: ${repayment['amount']}', style: const TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                              subtitle: Text('Date Paid: ${repayment['date_paid']}', style: const TextStyle(fontFamily: 'poppins', fontSize: 11, fontWeight: FontWeight.bold),),
                              trailing: Chip(
                                label: Text('${ repayment['receipt']}', style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                labelStyle: TextStyle(color: Colors.white), // Set the text color
                                backgroundColor: Colors.cyan, // Set the background color
                              )
                            ),
                          );
                        },
                      ),
        
            ],
        
          ),
        ),
      ),
    );
  }
}
