import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;



class HomePage extends StatelessWidget {
  final Map<String, dynamic>? user;

  HomePage({required this.user});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Page'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (user != null)
              ...[
                Text('Name: ${user!['COL 2']}'),
                Text('Staff ID: ${user!['COL 1']}'),
                Text('Job Title: ${user!['COL 3']}'),
                Text('Country: ${user!['COL 12']}'),
              ]
            else
              Text('User details not available.'),
          ],
        ),
      ),
    );
  }
}
