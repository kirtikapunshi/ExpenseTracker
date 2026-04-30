import 'package:flutter/material.dart';

PreferredSizeWidget myAppBar() {
  return AppBar(
    title: Text("Expense Tracker",
      style: TextStyle(fontWeight: .bold),),
    backgroundColor: Colors.blue,
    automaticallyImplyLeading: false,
    centerTitle: true,
  );
}