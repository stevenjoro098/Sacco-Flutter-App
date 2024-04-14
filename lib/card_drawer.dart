import 'package:flutter/material.dart';
class CardWithDrawer extends StatefulWidget {
  final bool isOpen;
  final VoidCallback onToggle;

  CardWithDrawer({required this.isOpen, required this.onToggle});

  @override
  _CardWithDrawerState createState() => _CardWithDrawerState();
}

class _CardWithDrawerState extends State<CardWithDrawer> {
  TextEditingController _textEditingController = TextEditingController();

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        GestureDetector(
          onTap: widget.onToggle,
          child: Card(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'MPESA',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8.0),
                  const Text('Enter Mobile Number to Initiate transaction'),
                  const SizedBox(height: 16.0),

                  TextFormField(
                    controller: _textEditingController,
                    decoration: const InputDecoration(
                      labelText: '+254********',
                      border: OutlineInputBorder(),
                    ),
                  ),
                SizedBox(height: 6,),
                Row(
                  //mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(onPressed: (){}, child: Text('Pay')),
                    ElevatedButton(onPressed: (){
                      _textEditingController.text = "";
                    }, child: Text('Cancel'))
                  ],
                )


                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}