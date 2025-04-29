import 'package:flutter/material.dart';

class BottomNavigationBarExample extends StatefulWidget {
  final int selectedIndex;
  final void Function(int)? onItemTapped;
  const BottomNavigationBarExample({
    super.key,
    required this.selectedIndex,
    required this.onItemTapped,
  });

  @override
  State<BottomNavigationBarExample> createState() =>
      _BottomNavigationBarExampleState();
}

class _BottomNavigationBarExampleState
    extends State<BottomNavigationBarExample> {
  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
       BottomNavigationBarItem(icon: Icon(Icons.list), label: 'Student List'),
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: widget.selectedIndex,
      
      selectedItemColor: const Color.fromARGB(255, 255, 158, 1),
      
      unselectedItemColor: const Color.fromARGB(255, 255, 255, 255),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
   
      onTap: widget.onItemTapped!,
    );
  }
}
