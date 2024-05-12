import 'dart:convert';   // library utility for json conversion. encoding and decoding.
import 'dart:ui'; //is library that provides low-level access  to flutter graphics engine
// and input capabilities.

import 'package:flutter/cupertino.dart'; //iOs style  widgets for UI
import 'package:flutter/material.dart';  //provides material design for UI
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
import 'news.dart';
import 'login.dart';

var BASE_url = "http://127.0.0.1:9000";

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sacco App',
      theme: ThemeData( // define app theme properties.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
        fontFamily: 'poppins',
        snackBarTheme: SnackBarThemeData( // define Snackbar theme
          backgroundColor: Colors.blue,
          shape: RoundedRectangleBorder( // Round corners of Snackbar
            borderRadius: BorderRadius.circular(20.0),
          ),
          insetPadding: const EdgeInsets.all(10.0)

        )
      ),
      home: const loginPage()//const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title, required this.id_no});

  final String title;
  final String id_no;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

 List<dynamic> recentTransaction = []; // list of recent transactions.
 late String totalAmount = ""; // String for total amount
 late String memberFirstName = ""; // String first name
 late String secondName = ""; //String second name
 late String thirdName = "";  // String third name.

 Future<void> getHomePageData() async { // Asynchronous request for homepage data
   final url = '$BASE_url /api/home/page/';  // server Url
   // define header
   final headers = {
     'Content-Type': 'application/json; charset=UTF-8',
     'Accept': "application/json"
   };

   try{
     final response = await http.post( // the Http library method
       Uri.parse(url),
       headers: headers,
       body: jsonEncode({'id': widget.id_no}), // encode the id data.
     );

     if(response.statusCode == 200){ // Check on request status code from the server
       var responseData = json.decode(response.body); // define a variable and decode the response data.

       setState(() {
         // render the data to the widgets.
           totalAmount = responseData['total_amount'];
           recentTransaction = responseData['contributions'];
           memberFirstName = responseData['member_first_name'];
           secondName = responseData['second_name'];
           thirdName = responseData['third_name'];
       });


     } else{
       // if error render/ any other status code
       ScaffoldMessenger.of(context).showSnackBar(
           const SnackBar(
             content: Text("Unable to Update Home Page"),
           )
       );

   }
   }
   catch (e) {
     ScaffoldMessenger.of(context).showSnackBar(
         const SnackBar(
           content: Text(""),
         )
     );
   };
 }
  @override
  void initState(){
   // override the initialize method.
   super.initState();
   getHomePageData(); // call the method on initialization
  }
  @override
  Widget build(BuildContext context) {
   // than having to individually change instances of widgets.
    return Scaffold( //
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0), 
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.start,
            //mainAxisSize: MainAxisSize.max,
            children: <Widget>[
                const SizedBox(height: 20,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Hello, $memberFirstName .",
                      style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.bold
                      ),
                    ),
                    IconButton(
                        onPressed: (){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) =>  userProfile( idNo: widget.id_no )));
        
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
                      title: Text("Ksh. $totalAmount",style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                      subtitle: const Text("Amount Saved"),
                      trailing: Image.asset('assets/images/cost.png', width: 45,height: 45,),
                    ),
                    const SizedBox(height: 5,),
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
                                MaterialPageRoute(builder: (context) => ViewHistory(idNo: widget.id_no,)));
        
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
                                MaterialPageRoute(builder: (context) => MakeContribution(idNo: widget.id_no, firstName: memberFirstName, secondName: secondName,thirdName: thirdName)));
        
                          },
                        ),
                        const SizedBox(width: 8),
                      ],
                    ),
                    const SizedBox(height: 10,)
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
                          backgroundColor: Colors.yellowAccent[100],
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)
                          )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.5),
                          child: Column(
                            children: [
                              const SizedBox(height: 6,),
                              Image.asset('assets/images/calculator.png', width: 35,),
                              const SizedBox(height: 5,),
                              const Text('Loan Calc',style: TextStyle(fontWeight: FontWeight.bold))
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
                              MaterialPageRoute(builder: (context) => Loans( id_no: widget.id_no)));
                      
                        } ,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellowAccent[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.5),
                           child: Column(
                            children: [
                              const SizedBox(height: 6,),
                              Image.asset('assets/images/signing.png', width: 35,),
                              const SizedBox(height: 6,),
                              const Text('Loans',style: TextStyle(fontWeight: FontWeight.bold)),
        
                            ],
                          ),
                        ),
                      
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                  padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed:(){
        
                        } ,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellowAccent[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.5),
                          child: Column(
                            children: [
                              const SizedBox(height: 6,),
                              Image.asset('assets/images/budget.png', width: 35,),
                              const SizedBox(height: 6,),
                              const Text('Dividends Calc',style: TextStyle(fontWeight: FontWeight.bold)),
        
                            ],
                          ),
                        ),
        
                      ),
                    ),
                    const SizedBox(width: 10,),
                    Expanded(
                      child: ElevatedButton(
                        onPressed:(){
        
                        } ,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.yellowAccent[100],
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.0)
                            )
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(4.5),
                          child: Column(
                            children: [
                              const SizedBox(height: 6,),
                              Image.asset('assets/images/money.png', width: 35,),
                              const SizedBox(height: 6,),
                              const Text('Dividends',style: TextStyle(fontWeight: FontWeight.bold)),
        
                            ],
                          ),
                        ),
        
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 5,),
              const Padding(
                padding: EdgeInsets.all(6.0),
                child: Row(
                  children: [
                    Text('Recent Transaction:', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 17),),
                  ],
                ),
              ),
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
                            color: Colors.deepOrangeAccent[100],
                            child: ListTile(
                              leading: const Icon(Icons.info),
                              title: Text("Ksh. ${recentTransaction[index]['amount']}",style: const TextStyle(fontWeight: FontWeight.bold)),
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
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.blueAccent,
        elevation: 3,
          shape: const CircularNotchedRectangle(

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
              icon: Image.asset('assets/images/news.png'),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const newsPage()));
                // Navigate to account screen
              },
            ),
          ],
        ),
      ),
    );

  }
}
