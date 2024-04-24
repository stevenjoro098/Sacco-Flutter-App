import 'package:flutter/material.dart';

class userProfile extends StatefulWidget {
  const userProfile({super.key});

  @override
  State<userProfile> createState() => _userProfileState();
}

class _userProfileState extends State<userProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
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
              )
          ],
        ),
      ),
    );
  }
}
