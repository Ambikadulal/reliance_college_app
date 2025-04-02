import 'package:flutter/material.dart';

class MyStatefullpage extends StatefulWidget {
  const MyStatefullpage({super.key});

  @override
  State<MyStatefullpage> createState() => _MyStatefullpageState();
}

class _MyStatefullpageState extends State<MyStatefullpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Container ());
  }
}


class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}