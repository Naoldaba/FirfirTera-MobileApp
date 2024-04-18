import 'package:flutter/material.dart';
import 'package:firfir_tera/presentation/services/User.dart';
import 'package:firfir_tera/presentation/screens/user_detail_for_admin.dart';

class AdminPanel extends StatelessWidget {
  final List<User> users = [
    User(
      id: 1,
      firstName: "Naol",
      lastName: "Daba",
      email: "afaklsdj@gmail.com",
    ),
    User(
      id: 2,
      firstName: "Eyob",
      lastName: "Derese",
      email: "afaklsdj@gmail.com",
    ),
    User(
      id: 3,
      firstName: "Anatoli",
      lastName: "Derese",
      email: "afaklsdj@gmail.com",
    ),
    User(
      id: 4,
      firstName: "Aregawi",
      lastName: "Fikre",
      email: "afaklsdj@gmail.com",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: EdgeInsets.fromLTRB(16, 20, 16, 40),
            child: Text(
              "Admin Panel",
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 28.0,
                fontWeight: FontWeight.bold,
                color: Colors.deepOrangeAccent,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: users.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => UserDetails(user: users[index]),
                      ),
                    );
                  },
                  child: MouseRegion(
                    cursor: SystemMouseCursors.click,
                    child: Card(
                      elevation: 3,
                      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                      child: ListTile(
                        title: Text(
                          users[index].firstName,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        subtitle: Text(
                          users[index].email,
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                        trailing: IconButton(
                          icon: Icon(
                            Icons.check,
                            color: Colors.green,
                          ),
                          onPressed: () {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                    "User ${users[index].firstName} banned"),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Add new Admin"),
            ),
          );
        },
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.person_add),
      ),
    );
  }
}
