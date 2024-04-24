import 'package:flutter/material.dart';

class userProfile extends StatefulWidget {
  const userProfile({super.key});

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  bool _displayEditForm = false;
  final _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
              Card(
                color: Colors.greenAccent[100],
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Column(
                        children: [
                          Image.asset('assets/images/profile.png', width: 100, height: 100,)
                        ],
                      ),
                      const SizedBox(width: 10,),
                      const Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text('Name:', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text('Stephen Njoroge'),
                          Text('National ID/Passport:', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("30306701"),
                          Text('Residence:', style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("Nairobi"),
                          Text('DOB:',style: TextStyle(fontWeight: FontWeight.bold),),
                          Text("30306701"),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: (){
                    setState(() {
                      _displayEditForm = !_displayEditForm;
                    });
                  },
                  child: const Text('Edit Profile'),
                ),
              ],
            ),
            if(_displayEditForm)...[
              Card(
                color: Colors.lightBlueAccent[100],
                child: Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      const Row(
                        children: [
                          Icon(Icons.person),
                          SizedBox(width: 20,),
                          Text('Edit Profile Form'),
                        ],
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Full Name'
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                          labelText: 'National ID/Passport'
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'Residence'
                        ),
                      ),
                      TextFormField(
                        decoration: const InputDecoration(
                            labelText: 'DOB'
                        ),
                      ),
                      const SizedBox(height: 20,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          TextButton(
                            onPressed: (){},
                            child: const Text('Save'),
                          ),
                          TextButton(
                            onPressed: (){},
                            child: const Text('Cancel'),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              )
            ]

          ],
        ),
      ),
    );
  }
}
