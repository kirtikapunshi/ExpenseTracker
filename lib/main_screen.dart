import 'package:flutter/material.dart';
import '../authentication/login_screen.dart';

class MainScaffold extends StatelessWidget {
  final String title;
  final Widget body;

  const MainScaffold({
    super.key,
    required this.title,
    required this.body,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F6FA),

      // COMMON APP BAR
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        backgroundColor: Colors.blue,
        elevation: 0,

        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              Navigator.pushReplacementNamed(context, '/login');
            },
          ),
        ],
      ),

      // COMMON DRAWER
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [

            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: Text(
                "Expense Tracker",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

            buildDrawerItem(context, Icons.home, "Home", '/home'),
            buildDrawerItem(context, Icons.add, "Add Expense", '/addExpense'),
            buildDrawerItem(context, Icons.list, "All Expenses", '/expenses'),
            buildDrawerItem(context, Icons.search, "Search", '/search'),
            
            const Divider(),

            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text("Logout"),
              onTap: () {
                Navigator.pushReplacementNamed(context, '/login');
              },
            ),
          ],
        ),
      ),

      // SCREEN BODY
      body: body,
    );
  }

  // Drawer item builder
  Widget buildDrawerItem(
      BuildContext context,
      IconData icon,
      String title,
      String route,
      ) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // close drawer
        Navigator.pushReplacementNamed(context, route);
      },
    );
  }
}
