import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ViewHistory extends StatefulWidget {
  const ViewHistory({super.key});

  @override
  State<ViewHistory> createState() => _ViewHistoryState();
}

class _ViewHistoryState extends State<ViewHistory> {
  List<Map<String, dynamic>> contrib_list = [];

  Future<void> getContribHistory()async {

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.get(
        Uri.parse('http://127.0.0.1:9000/api/list/contributions/?param=30306701'),
        headers: headers,
      );
      if(response.statusCode == 200){
        //print(json.decode(response.body));
        setState(() {
          contrib_list = json.decode(response.body).cast<Map<String, dynamic>>();
        });
      } else {
          print('Must be error');
      }
    } catch(e){

    }
  }
  @override
  void initState(){
    super.initState();
    getContribHistory();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Payment History', style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              contrib_list.isEmpty ?
                  const Center(
                    child: Text('No Data Available'),
                      )
              :ListView.builder(
                  shrinkWrap: true,
                  itemCount: contrib_list.length,
                  itemBuilder: (context, index){
                    return Card(
                      elevation: 2,
                      color: Colors.blue,
                      child: ListTile(
                        //contentPadding: const EdgeInsets.all(8.0),
                        leading: const Icon(Icons.payments_outlined),
                        title: Text('Ksh. ${contrib_list[index]['amount']}', style: const TextStyle(fontWeight: FontWeight.bold),),
                        subtitle: Text('${contrib_list[index]['created']}', style: TextStyle(fontFamily: 'poppins'),),
                        trailing:Chip(
                          label: Text("${ contrib_list[index]['receipt_no']}"),
                          backgroundColor: Colors.green,
                        ),
                      ),
                    );
                  }
              )
            ],
          ),
        ),
      )
    );
  }
}
