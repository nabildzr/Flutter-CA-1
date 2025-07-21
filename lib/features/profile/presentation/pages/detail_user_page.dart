import 'package:flutter/material.dart';

class DetailUserPage extends StatelessWidget {
  final int userId;

  const DetailUserPage(this.userId, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail User $userId")),
      body: Card(
        margin: EdgeInsets.all(20),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(radius: 50),
              SizedBox(height: 20),
              Text("ID: .."),
              Text("Full Name: ..."),
              Text("Email: ..."),
            ],
          ),
        ),
      ),
    );
  }
}
