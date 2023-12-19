import 'dart:convert';
import 'package:auth/home.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Future<void> login() async {
    final String apiUrl = 'http://127.0.0.1/demo/login.php';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        body: {
          'Webmail_id': usernameController.text,
          'staff_id': passwordController.text,
        },
      );

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data is List && data.isNotEmpty) {
          Map<String, dynamic>? loggedInUser;

          for (var entry in data) {
            if (entry['COL 2'] == usernameController.text &&
                entry['COL 1'] == passwordController.text) {
              loggedInUser = entry;
              break;
            }
          }

          if (loggedInUser != null) {
            print('Login Successful');
           Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomePage(user: loggedInUser),
            ),
          );
          } else {
            print('Login Failed: Invalid username or password');
          }
        } else {
          print('Login Failed: Invalid data structure');
        }
      } else {
        print('Login Failed: Status code ${response.statusCode}');
      }
    } catch (error) {
      print('Login Failed: $error');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              controller: usernameController,
              decoration: InputDecoration(labelText: 'Username'),
            ),
            SizedBox(height: 16.0),
            TextField(
              controller: passwordController,
              decoration: InputDecoration(labelText: 'Password'),
              obscureText: true,
            ),
            SizedBox(height: 24.0),
            ElevatedButton(
              onPressed: () {
                login();
              },
              child: Text('Login'),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> main() async {
  runApp(MaterialApp(
    initialRoute: '/login', // Set the initial route
    routes: {
      '/login': (context) => LoginPage(),
      // '/home': (context) => HomePage(),
    },
  ));
}
