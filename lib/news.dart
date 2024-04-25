import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;


class newsPage extends StatefulWidget {
  const newsPage({super.key});

  @override
  State<newsPage> createState() => _newsPageState();
}

class _newsPageState extends State<newsPage> {
  var responseData;
  List<dynamic> newsList = [];
  Future<void> getNewsUpdates() async {
    final url = 'http://127.0.0.1:9000/api/news/';

    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.get(
          Uri.parse(url),
          headers: headers

      );
      if(response.statusCode == 200){
        responseData = jsonDecode(response.body);
        //print(responseData['news']);
        setState(() {
          newsList = responseData["news"];
        });
      }
      else {

      }

    } catch (e){

    }
  }

  @override
  void initState(){
    super.initState();
    getNewsUpdates();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('News Page'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              newsList.isEmpty ?
                  Center(
                    child:Image.asset('assets/images/world-news.png'),
                  )
                  :ListView.builder(
                    shrinkWrap: true,
                    itemCount: newsList.length,
                    itemBuilder: (context, index){
                      return Card(
                        child: ListTile(
                          title: Text("${ newsList[index]['title']}",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                            ),
                            ),
                          subtitle: Text("${ newsList[index]['content']}"),
                        ),
                      );
                    }
                  )
            ],
          ),
        ),
      ),
    );
  }
}
