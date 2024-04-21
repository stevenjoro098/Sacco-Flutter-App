import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class loanCalculator extends StatefulWidget {
  const loanCalculator({super.key});

  @override
  State<loanCalculator> createState() => _loanCalculatorState();
}

class _loanCalculatorState extends State<loanCalculator> {
  late Map<String, dynamic> loanCalc = {};
  var responseData;
  
  TextEditingController amount = TextEditingController();
  TextEditingController int_rate = TextEditingController();
  TextEditingController period = TextEditingController();

  void resetTextController (){
    amount.text = '';
    int_rate.text = '';
    period.text = '';
  }

  Future<void> getLoanRepaymentInfo(Map<String, dynamic> loanData) async {
    final url = 'http://127.0.0.1:9000/api/loan/calculator/';

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };

    try{
      final response = await http.post(
        Uri.parse(url),
        headers: headers,
        body: jsonEncode(loanData),
      );
      if(response.statusCode == 200){
        responseData = jsonDecode(response.body);
        setState(() {
          loanCalc = responseData;
        });
        //resetTextController();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Error Calculating "),
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
        backgroundColor: Colors.transparent,
        title: const Text('Loan Calculator'),

      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Card(
                elevation: 3,
                color: Colors.blueAccent[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      const Text(
                        'LOAN REPAYMENT CALCULATOR',
                        style: TextStyle(
                            fontFamily: 'poppins',
                            fontWeight: FontWeight.bold,
                          fontSize: 17,
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: amount,
                        decoration: const InputDecoration(
                          labelText: 'Amount',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: int_rate,
                        decoration: const InputDecoration(
                          labelText: 'Interest Period',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      TextFormField(
                        controller: period,
                        decoration: const InputDecoration(
                          labelText: 'Payment Period',
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20))
                          ),
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                              onPressed: (){
                                  final loanData = {
                                    'amount': amount.text,
                                    'interest_rate' : int_rate.text,
                                    'period': period.text
                                  };

                                  getLoanRepaymentInfo(loanData);
                              },
                              child: const Row(
                                children: [
                                  Icon(Icons.calculate),
                                  Text('Calculate')
                                ],
                              )
                          ),
                          ElevatedButton(
                              onPressed: (){

                              },
                              child:const Row(
                                children: [
                                  Icon(Icons.close),
                                  Text('Cancel')
                                ],
                              )
                          ),

                        ],
                      ),
                      const SizedBox(height: 20,),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              loanCalc.isEmpty ?
                  const Center(

                  )
              : Card(
                elevation: 3,
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Expanded(
                    child: Column(
                      children: [
                        const Text('RESULTS:', style: TextStyle(fontFamily: 'poppins', fontWeight: FontWeight.bold),),
                        Text('Total Payment: ${ loanCalc['total_amt']}'),
                        Text('Interest Amount: ${ loanCalc['interest_amt']}'),
                        Text('Monthly Payment: ${ loanCalc['monthly_pay']}'),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      )
      ,
    );
  }
}
