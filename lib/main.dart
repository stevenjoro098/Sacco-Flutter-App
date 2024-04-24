import 'dart:convert';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

import 'register.dart';
import 'make_contribution.dart';
import 'view_history.dart';
import 'loans.dart';
import 'loan_calc.dart';
import 'profile.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'poppins'
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
 List<dynamic> recentTransaction = [];
 late String totalAmount;

 Future<void> getHomePageData() async {
   final url = 'http://127.0.0.1:9000/api/home/page/';

   final headers = {
     'Content-Type': 'application/json; charset=UTF-8',
     'Accept': "application/json"
   };
   try{
     final response = await http.post(
       Uri.parse(url),
       headers: headers,
       body: jsonEncode({'id':'30306701'}),
     );
     if(response.statusCode == 200){
       var responseData = json.decode(response.body);

       setState(() {
         totalAmount = responseData['total_amount'];
         recentTransaction = responseData['contributions'];
       });


     } else{
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text("Unable to Update Home Page"),
           )
       );

   }
   }
   catch (e) {

   };
 }
  @override
  void initState(){
   super.initState();
   getHomePageData();
  }
  @override
  Widget build(BuildContext context) {
   // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.start,
          //mainAxisSize: MainAxisSize.max,
          children: <Widget>[
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Hello, Stephen",
                    style: TextStyle(
                      fontSize: 20,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                      onPressed: (){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const userProfile()));

                      },
                      icon: const Icon(Icons.person))
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Total Savings:',
                    style: TextStyle(
                        fontWeight: FontWeight.normal,
                        fontSize: 23,
                      fontFamily: 'Poppins'
                    )
                    ),
                ],
              ),
              Card(
                color: Colors.blueAccent,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.payments_outlined),
                    title: Text("Ksh. ${totalAmount}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                    subtitle: Text("Amount Saved"),
                    trailing: Image.asset('assets/images/cost.png', width: 45,height: 45,),
                  ),
                  SizedBox(height: 5,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      ElevatedButton(
                        child:  const Row(
                            children: [
                                Icon(Icons.history),
                                SizedBox(width: 5),
                              Text('View History', style: TextStyle(fontWeight: FontWeight.bold),),
                                      ],
                              ),
                        onPressed:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const ViewHistory()));

                        },
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        child: const Row(
                          children: [
                            Icon(Icons.payment),
                            SizedBox(width: 5,),
                            Text('Deposit',style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                        onPressed: () {

                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const MakeContribution()));

                        },
                      ),
                      const SizedBox(width: 8),
                    ],
                  ),
                  SizedBox(height: 10,)
                ],
              ),
            ),
            const SizedBox(height: 1,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const loanCalculator()));
                    
                      },
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)
                        )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.5),
                        child: Column(
                          children: [
                            Icon(Icons.calculate),
                            //SizedBox(height: 5,),
                            Text('Loan Calc',style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 20,),
                  Expanded(
                    child: ElevatedButton(
                      onPressed:(){
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => const Loans()));
                    
                      } ,
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          )
                      ),
                      child: const Padding(
                        padding: EdgeInsets.all(4.5),
                         child: Column(
                          children: [
                            Icon(Icons.account_balance),
                            Text('Loans',style: TextStyle(fontWeight: FontWeight.bold)),
                          ],
                        ),
                      ),
                    
                    ),
                  )
                ],
              ),
            ),
            Padding(
                padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){},
                      style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)
                          )
                      ),
                        child: const Column(
                          children: [
                            Icon(Icons.calculate_outlined),
                            Text('Dividends Calc',style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        ),
                    ),
                  ),
                  const SizedBox(width: 10,),
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                          
                        },
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        ),
                        child: const Column(
                          children: [
                            Icon(Icons.money_outlined),
                            Text('Dividends',style: TextStyle(fontWeight: FontWeight.bold))
                          ],
                        )
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(height: 5,),
            const Text('Recent Transaction:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
            recentTransaction.isEmpty ?
                const Center(
                  child: Text('No Recent Transactions Found'),
                )
            :SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                      itemCount: recentTransaction.length,
                      itemBuilder: (context, index){
                        return Card(
                          child: ListTile(
                            leading: Icon(Icons.info),
                            title: Text("Ksh. ${recentTransaction[index]['amount']}",style: TextStyle(fontWeight: FontWeight.bold)),
                            subtitle: Text('${recentTransaction[index]['created']}'),
                            trailing: Text("${recentTransaction[index]['receipt_no']}"),
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
            const SizedBox(height: 8,),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        elevation: 3,
          shape: CircularNotchedRectangle(

          ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            IconButton(
              icon: const Icon(Icons.call),
              onPressed: () {
                // Navigate to home screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.email),
              onPressed: () {
                // Navigate to notifications screen
              },
            ),
            IconButton(
              icon: const Icon(Icons.account_circle),
              onPressed: () {
                // Navigate to account screen
              },
            ),
          ],
        ),
      ),
    );

  }
}
