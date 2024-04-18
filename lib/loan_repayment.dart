import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class loanRepayment extends StatefulWidget {
  const loanRepayment({super.key});

  @override
  State<loanRepayment> createState() => _loanRepaymentState();
}

class _loanRepaymentState extends State<loanRepayment> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 2,
        title: const Text('Loan Repayment', style: TextStyle(fontFamily: 'poppins'),),
      ),
      body: Padding(
        padding: EdgeInsets.all(8.0),
        child: Column(
          children: [
            const SizedBox(height: 20,),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Enter Amount',
                  labelText: 'Amount',
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20))
                  )
                ),
              ),
            ),
            const SizedBox(height: 20,),
            Card(
              color: Colors.green[300],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset('assets/images/mpesa.png', width: 130,),
                    const SizedBox(height: 8.0),
                    const Text('Enter Mobile Number to Initiate transaction'),
                    const SizedBox(height: 16.0),

                    TextFormField(
                      //controller: _textEditingController,
                      decoration: const InputDecoration(
                        labelText: '+254**********',
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(20))
                        ),
                      ),
                    ),
                    SizedBox(height: 6,),
                    Row(
                      //mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                            onPressed: (){

                            },
                            child: const Text('Pay')
                        ),
                        ElevatedButton(onPressed: (){
                          //_textEditingController.text = "";
                        },
                            child: Text('Cancel'))
                      ],
                    )


                  ],
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
