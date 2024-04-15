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
        title: const Text('All Payment History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: contrib_list.isEmpty
             ? Center(
          child: Text("No data Available"),
        )
            :ListView.builder(
            itemCount: contrib_list.length,
            itemBuilder: (context, index){
              return Card(
                elevation: 2,
                color: Colors.white24,
                child: ListTile(
                  contentPadding: const EdgeInsets.all(8.0),
                  leading: const Icon(Icons.monetization_on),
                  title: Text('${contrib_list[index]['amount']}', style: TextStyle(fontFamily: 'poppins'),),
                  subtitle: Text('${contrib_list[index]['created']}', style: TextStyle(fontFamily: 'poppins'),),
                ),
              );
            }
        ),
      ),
    );
  }
}
