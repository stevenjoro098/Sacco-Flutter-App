import 'package:flutter/material.dart';

class loanDetails extends StatefulWidget {
  const loanDetails({super.key});

  @override
  State<loanDetails> createState() => _loanDetailsState();
}

class _loanDetailsState extends State<loanDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Loan Details', style: TextStyle(fontFamily: 'poppins'),),
      ),
    );
  }
}
