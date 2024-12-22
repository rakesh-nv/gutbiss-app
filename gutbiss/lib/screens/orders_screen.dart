import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ordersScreen extends StatefulWidget {
  const ordersScreen({super.key});

  @override
  State<ordersScreen> createState() => _ordersScreenState();
}

class _ordersScreenState extends State<ordersScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Orders'),
      ),
    );
  }
}
