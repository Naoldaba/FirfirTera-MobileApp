import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/services/User.dart';

class UserDetails extends StatefulWidget {
  final User user;

  UserDetails({required this.user});

  @override
  State<UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  bool isBanned = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "User Details",
        ),
        backgroundColor: Colors.black,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/images/log_reg_background.jpg'),
              fit: BoxFit.cover),
          // gradient: LinearGradient(
          //   colors: [Colors.orange.shade300, Colors.orange.shade600],
          //   begin: Alignment.topCenter,
          //   end: Alignment.bottomCenter,
          // ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'Name: ${widget.user.firstName} ${widget.user.lastName}',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 10),
              Text(
                'Email: ${widget.user.email}',
                style: TextStyle(fontSize: 18, color: Colors.white),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 40),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isBanned = !isBanned;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(isBanned
                          ? "User ${widget.user.firstName} banned"
                          : "User ${widget.user.firstName} unbanned"),
                    ),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isBanned ? Colors.red : Colors.green,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  isBanned ? 'Unban User' : 'Ban User',
                  style: TextStyle(fontSize: 18),
                ),
              ),
              SizedBox(height: 15.0),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    isBanned = !isBanned;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text("User Deleted"),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  elevation: 5,
                  padding: EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  "Delete User",
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
