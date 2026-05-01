import 'package:flutter/material.dart';
import '../ExpenseProvider.dart';
import '../main_screen.dart'; //IMPORT

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  String query = "";

  @override
  Widget build(BuildContext context) {
    final provider = ExpenseProvider.of(context);

    final filteredList = provider.expenses
        .where((expense) =>
        expense.title.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return MainScaffold(
      title: "Search Expenses",

      // Recommended: cleaner UX (no drawer while typing)
      // showDrawer: false,

      body: Column(
        children: [

          // 🔍 SEARCH INPUT
          Padding(
            padding: const EdgeInsets.all(12),
            child: TextField(
              onChanged: (value) {
                setState(() {
                  query = value;
                });
              },
              decoration: InputDecoration(
                hintText: "Search expenses...",
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
          ),

          //RESULTS
          Expanded(
            child: filteredList.isEmpty
                ? const Center(
              child: Text("No matching expenses found"),
            )
                : ListView.builder(
              itemCount: filteredList.length,
              itemBuilder: (context, index) {
                final expense = filteredList[index];

                return ListTile(
                  leading: const CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.money, color: Colors.white),
                  ),
                  title: Text(expense.title),
                  subtitle: Text("Rs ${expense.amount}"),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
