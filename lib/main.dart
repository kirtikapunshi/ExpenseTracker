import 'package:flutter/material.dart';
import 'package:new_project/screens/expense_detail_screen.dart';
import 'authentication/login_screen.dart';
import 'authentication/signup_screen.dart';
import 'screens/home_screen.dart';
import 'user_provider.dart';
import 'ExpenseProvider.dart';
import 'screens/add_edit_screen.dart';
import 'screens/expense_list_screen.dart';
import 'screens/search_screen.dart';
import 'screens/analytic_screen.dart';
import './Admin/adminpage.dart';
import 'screens/home_screen.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return UserStore(
      child: ExpenseStore(
        child: MaterialApp(
          debugShowCheckedModeBanner: false,

          initialRoute: '/',

          routes: {
            '/': (context) => LoginScreen(),
            '/signup': (context) => SignupScreen(),
            '/home': (context) => HomeScreen(),
            '/addExpense': (context) => const AddEditScreen(),
            '/expenses': (context) => const ExpenseListScreen(),
            '/expense-detail' : (context) => const ExpenseDetailScreen(),
            '/analytics' : (context) => const AnalyticsScreen(),
            '/search' : (context) => const SearchScreen(),
            '/admin' : (context) => const AdminPage(),

          },

          title: 'Expense App',

          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.deepPurple,
            ),
          ),
        ),
      ),
    );
  }
}