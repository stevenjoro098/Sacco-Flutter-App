import 'package:flutter/material.dart';

import 'register.dart';
import 'make_contribution.dart';
import 'view_history.dart';
import 'loans.dart';
import 'loan_calc.dart';

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
 List<Map<String, dynamic>> recentTransaction = [{'amt':200}];
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
                      onPressed: (){},
                      icon: const Icon(Icons.person))
                ],
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Total Contributions:',
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
                    leading: Icon(Icons.money_outlined),
                    title: Text("Ksh. 5000"),
                    subtitle: Text("Amount"),
                    trailing: Image.asset('assets/images/cost.png', width: 45,height: 45,),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      ElevatedButton(
                        child: const Text('View History'),
                        onPressed:(){
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => const ViewHistory()));

                        },
                      ),
                      const SizedBox(width: 8),
                      ElevatedButton(
                        child: const Text('Make Contribution'),
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
            const SizedBox(height: 18,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                //mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const loanCalculator()));

                    },
                    child: const Padding(
                      padding: EdgeInsets.all(4.5),
                      child: Column(
                        children: [
                          Icon(Icons.calculate),
                          Text('Loan Calculator')
                        ],
                      ),
                    ),
                  ),

                  ElevatedButton(
                    onPressed:(){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const Loans()));

                    } ,
                    child: const Padding(
                      padding: EdgeInsets.all(4.5),
                       child: Column(
                        children: [
                          Icon(Icons.account_balance),
                          Text('Loans'),
                        ],
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
                  ElevatedButton(
                      onPressed: (){},
                      child: const Column(
                        children: [
                          Icon(Icons.attach_money),
                          Text('Dividends')
                        ],
                      )
                  ),
                  ElevatedButton(
                      onPressed: (){},
                      child: const Column(
                        children: [
                          Icon(Icons.attach_money),
                          Text('Dividends')
                        ],
                      )
                  )
                ],
              ),
            ),
            const SizedBox(height: 10,),
            const Text('Recent Transaction:', style: TextStyle(fontFamily: 'poppins'),),
            recentTransaction.isEmpty ?
                const Center(
                  child: Text('No Recent Transactions Found'),
                )
            :ListView.builder(
              shrinkWrap: true,
                itemCount: recentTransaction.length,
                itemBuilder: (context, index){
                  return const Card(
                    child: ListTile(
                      title: Text('200'),
                    ),
                  );
                }
            ),
            const SizedBox(height: 15,),
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
