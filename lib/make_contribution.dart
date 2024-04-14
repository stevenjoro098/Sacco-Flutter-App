import 'package:flutter/material.dart';

import 'card_drawer.dart';

class MakeContribution extends StatefulWidget {
  const MakeContribution({super.key});

  @override
  State<MakeContribution> createState() => _MakeContributionState();
}

class _MakeContributionState extends State<MakeContribution> {
  bool isDrawerOpen = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Contribute'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                hintText: 'Full Name',
                prefixIcon: Icon(Icons.person)
              ),
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return 'Please Enter First Name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'National ID No.',
                  prefixIcon: Icon(Icons.numbers)
              ),
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return 'Please Enter First Name';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(
                  hintText: 'Amount',
                  prefixIcon: Icon(Icons.attach_money_sharp)
              ),
              validator: (String? value){
                if(value == null || value.isEmpty){
                  return 'Please Enter Amount';
                }
                return null;
              },
            ),


            SizedBox(height: 20,),
            Text('Mode of Payment:'),
            CardWithDrawer(
              isOpen: isDrawerOpen,
              onToggle: () {
                setState(() {
                  isDrawerOpen = !isDrawerOpen;
                });
              },
            ),
          ],
        ),
      )
    );
  }
}
