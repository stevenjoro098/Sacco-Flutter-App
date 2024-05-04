import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'register.dart';
import 'main.dart';
class loginPage extends StatefulWidget {
  const loginPage({super.key});

  @override
  State<loginPage> createState() => _loginPageState();
}

class _loginPageState extends State<loginPage> {
  TextEditingController username = TextEditingController();
  TextEditingController password = TextEditingController();

  Future<void> login(Map<String, dynamic> loginCred) async {
    final headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': "application/json"
    };
    try{
      final response = await http.post(
        Uri.parse('http://127.0.0.1:9000/api/login/'),
        headers: headers,
        body: jsonEncode(loginCred)
      );
      if(response.statusCode == 200){
        var resp = jsonDecode(response.body);
        String idNo = resp['user_idNo'];
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(
              content: Text("Welcome, ${resp["username"]}"),
            )
        );
        Navigator.push(context,
            MaterialPageRoute(builder: (context) => MyHomePage(id_no: idNo, title: '',)));
        //
      }
      else if(response.statusCode == 404){
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("User Unavailable"),
            )
        );
      }

    } catch (e) {

    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
                const SizedBox(height: 50,),
                const Text("Login",
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 35
                  ),
                ),
              SizedBox(height: 50),
              TextFormField(
                controller: username,
                decoration: const InputDecoration(
                 // hintText: "Username",
                  labelText: 'National ID/Passport',
                  prefixIcon: Icon(Icons.account_circle_outlined)
                ),
              ),
              TextFormField(
                controller: password,
                decoration: const InputDecoration(
                  //hintText: 'Password',
                  prefixIcon: Icon(Icons.lock),
                  labelText: 'Password'
                ),
              ),
              SizedBox(height: 20,),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                    TextButton(
                        onPressed: (){},
                        child: Text('Forgot Password?')
                    )
                ],
              ),
              const SizedBox(height: 10,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                          final loginCred = {
                            'username':username.text,
                            'password':password.text
                          };
                          login(loginCred);
                        },
                        child: const Text("Login"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.cyan, // Text color
                        elevation: 4, // Elevation
                        // padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0), // Button padding
                        textStyle: TextStyle(
                          fontSize: 15.0, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20,),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                        onPressed: (){},
                        child: const Text("Cancel"),
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.redAccent, // Text color
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0), // Rounded corners
                        ),
                        elevation: 4, // Elevation
                        padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0), // Button padding
                        textStyle: const TextStyle(
                          fontSize: 14.0, // Text size
                          fontWeight: FontWeight.bold, // Text weight
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 30,),
              Text("or"),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                    IconButton(
                        onPressed: (){}, 
                        icon: Image.asset('assets/images/facebook.png', width: 40,)
                    ),
                  SizedBox(width: 20,),
                  IconButton(
                      onPressed: (){},
                      icon: Image.asset('assets/images/twitter.png', width: 40,)
                  ),
                  SizedBox(width: 20,),
                  IconButton(
                      onPressed: (){},
                      icon: Image.asset('assets/images/google-symbol.png', width: 40,)
                  )
                ],
              ),
              SizedBox(height: 20,),
              Text("Or"),
              SizedBox(height: 20,),
              ElevatedButton(
                  onPressed: (){
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Register()));
                    //
                  },

                  child: Text("Register"),
                style: ElevatedButton.styleFrom(
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.blue, // Text color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0), // Rounded corners
                  ),
                  elevation: 4, // Elevation
                  padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 16.0), // Button padding
                  textStyle: TextStyle(
                    fontSize: 16.0, // Text size
                    fontWeight: FontWeight.bold, // Text weight
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
