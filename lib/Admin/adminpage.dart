import 'package:flutter/material.dart';
import '../user_provider.dart';

class AdminPage extends StatelessWidget {
  const AdminPage({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = UserProvider.of(context);

    return Scaffold(
      appBar: AppBar(title: const Text("Admin Panel")),

      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            const Text(
              "Welcome Admin 👨‍💼",
              style: TextStyle(fontSize: 20),
            ),

            const SizedBox(height: 20),

            Text("Email: ${provider.user?.email}"),

            const SizedBox(height: 20),

            ElevatedButton(
              onPressed: () {
                provider.logoutUser();
                Navigator.pushReplacementNamed(context, '/login');
              },
              child: const Text("Logout"),
            ),
          ],
        ),
      ),
    );
  }
}