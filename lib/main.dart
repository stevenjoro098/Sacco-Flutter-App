import 'package:flutter/material.dart';

import 'register.dart';
import 'make_contribution.dart';

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

  @override
  Widget build(BuildContext context) {
   // than having to individually change instances of widgets.
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
              const SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text("Hello, Stephen",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  IconButton(
                      onPressed: (){},
                      icon: const Icon(Icons.person))
                ],
              ),
              Row(
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
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const ListTile(
                    leading: Icon(Icons.money_outlined),
                    title: Text("Ksh. 5000"),
                    subtitle: Text("Amount"),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      TextButton(
                        child: const Text('View History'),
                        onPressed:(){},
                      ),
                      const SizedBox(width: 8),
                      TextButton(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text('Recent Transactions:',
                    style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 18
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ListTile(
                          leading: Icon(Icons.money_outlined),
                          title: Text("Ksh. 5000"),
                          subtitle: Text("Amount"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('View History'),
                              onPressed:(){},
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Make Contribution'),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                  Card(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const ListTile(
                          leading: Icon(Icons.money_outlined),
                          title: Text("Ksh. 5000"),
                          subtitle: Text("Amount"),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            TextButton(
                              child: const Text('View History'),
                              onPressed:(){},
                            ),
                            const SizedBox(width: 8),
                            TextButton(
                              child: const Text('Make Contribution'),
                              onPressed: () {},
                            ),
                            const SizedBox(width: 8),
                          ],
                        ),
                        SizedBox(height: 10,)
                      ],
                    ),
                  ),
                ],
            ),
            const Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: Icon(Icons.money_outlined),
                    title: Text("Ksh. 5000"),

                  ),

                  SizedBox(height: 8,)
                ],
              ),
            ),
            Card(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                   ListTile(
                    leading: Icon(Icons.money_outlined),
                    title: Text("Ksh. 5000"),

                    trailing: IconButton(
                        onPressed: (){},
                        icon: const Icon(Icons.remove_red_eye)
                    ),
                  ),
                  
                  SizedBox(height: 10,)
                ],
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context,
            MaterialPageRoute(builder: (context) => const Register()));

        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
