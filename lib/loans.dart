import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'loans_application.dart';
import 'loan_details.dart';

class Loans extends StatefulWidget {
  const Loans({super.key});

  @override
  State<Loans> createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  List<Map<String, dynamic>> loans_list = [];


  Future<void> getLoansHistory()async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try {
      final response = await http.get(
        Uri.parse(
            'http://127.0.0.1:9000/api/member/loans/list/?param=30306701'),
        headers: headers,
      );
      if (response.statusCode == 200) {
        //print(json.decode(response.body));
        setState(() {
          loans_list = json.decode(response.body).cast<Map<String, dynamic>>();
        });

      } else {
        print('Must be error');
      }
    } catch (e) {

    }
  }
  @override
  void initState(){
    super.initState();
    getLoansHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const
        Text('Loans', style:
                TextStyle(
                    fontFamily: 'poppins'),
        ),

      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            //padding: const EdgeInsets.all(8.0),
            children: [loans_list.isEmpty
                ? const Center(
                        child: Text("No data Available"),
                      )
                :ListView.builder(
                    shrinkWrap: true,
                    itemCount: loans_list.length,
                    itemBuilder: (context, index){
                      final status = loans_list[index]['status'];
                      Color cardColor = status == 'Approved' ? Colors.green : Colors.grey;
                      return Card(
                        color: cardColor,
                        child: Column(
                          children: <Widget>[
                            ListTile(
                              title: Text('Loan Amount: ${ loans_list[index]['amount']}', style: const TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                              subtitle: Text('Repayment Period: ${ loans_list[index]['repayment_term']} days.', style: const TextStyle(fontFamily: 'poppins',fontWeight: FontWeight.bold),),
                              trailing: Image.asset('assets/images/loan.png')
                              ),
                            const SizedBox(height: 5,),
                            Row(
                              mainAxisAlignment:MainAxisAlignment.spaceAround,
                              children: [

                                Chip(
                                  label:Text('${loans_list[index]['status']}'),
                                  labelStyle: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold), // Set the text color
                                  backgroundColor: Colors.cyan, // Set the background color
                                ),
                                if(status == 'Approved')
                                  ElevatedButton(
                                      onPressed: (){
                                        Navigator.push(context,
                                            MaterialPageRoute(builder: (context) => const loanDetails()));
                                      },
                                      child: Text('View')
                                  ),

                              ],
                            ),

                            const SizedBox(height: 10,)
                          ],
                        ),
                      );
                    },
                  ),
              ]
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const makeApplication()));

        },
        child: const Padding(
          padding: EdgeInsets.all(3.0),
          child: Column(
            children: [
              Icon(Icons.add),
              Text('Apply')
            ],
          ),
        ),
      ),

    );
  }
}
