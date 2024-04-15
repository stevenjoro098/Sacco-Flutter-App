import 'package:flutter/material.dart';
import 'loans_application.dart';

class Loans extends StatefulWidget {
  const Loans({super.key});

  @override
  State<Loans> createState() => _LoansState();
}

class _LoansState extends State<Loans> {
  List<Map<String, dynamic>> loans_list = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loans', style: TextStyle(fontFamily: 'poppins'),),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                    onPressed: (){},
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Icon(Icons.calculate_outlined),
                        SizedBox(),
                        Text('Loan Calculator')
                      ],
                    )
                ),
                ElevatedButton(
                    onPressed: (){
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => const makeApplication()));

                    },
                    child: const Row(
                      //mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(Icons.add),
                        SizedBox(),
                        Text('Make Application')
                      ],
                    )
                ),
              ],
            ),


          ],
        ),
      ),

    );
  }
}
