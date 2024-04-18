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
        title: const Text('Loans', style: TextStyle(fontFamily: 'poppins'),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: loans_list.isEmpty
            ? const Center(
                    child: Text("No data Available"),
                  )
            :ListView.builder(
                itemCount: loans_list.length,
                itemBuilder: (context, index){
                  return Card(
                    color: Colors.blue,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text('Loan Amount: ${ loans_list[index]['amount']}'),
                          subtitle: Padding(
                            padding: const EdgeInsets.all(4.0),
                            child: Column(
                              children: [
                                Text('Repayment Period: ${ loans_list[index]['repayment_term']} days.'),
                                Text('Date Applied: ${ loans_list[index]['date_applied']}')
                              ],
                            ),
                          ),
                          trailing: Text('${loans_list[index]['status']}'),
                        ),
                        ElevatedButton(
                            onPressed: (){
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) => const loanDetails()));
                            },
                            child: Text('View')
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  );
                },
              ),
      ),

    );
  }
}
