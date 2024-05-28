import 'package:firfir_tera/providers/users_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class AdminPanel extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersListAsync = ref.watch(allUsersProvider);

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
            child: usersListAsync.when(
                data: (users) => Container(
                  child: ListView.builder(
                    itemCount: users.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () => context.go('/home/admin/user_details',
                            extra: users[index]),
                        child: Card(
                          elevation: 3,
                          margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                          child: MouseRegion(
                            cursor: SystemMouseCursors.click,
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
                                  onPressed: () {}),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                loading: () => Center(child: CircularProgressIndicator()),
                error: (err, stack) => Center(
                    child: Text(
                  'Ops... unable to fetch users.',
                )),
              )
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.deepOrangeAccent,
        child: Icon(Icons.person_add),
      ),
    );
  }
}
