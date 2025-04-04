// import 'package:flutter/material.dart';

// class BottomNavigationBarExample extends StatefulWidget {
//   final int selectedIndex;
//   final void Function(int)? onItemTapped;

//   const BottomNavigationBarExample({
//     super.key,
//     required this.selectedIndex,
//     required this.onItemTapped,
//   });

//   @override
//   State<BottomNavigationBarExample> createState() =>
//       _BottomNavigationBarExampleState();
// }

// class _BottomNavigationBarExampleState
//     extends State<BottomNavigationBarExample> {
//   @override
//   Widget build(BuildContext context) {
//     return BottomNavigationBar(
//       type: BottomNavigationBarType.fixed, // important for more than 3 items
//       items: const <BottomNavigationBarItem>[
//         BottomNavigationBarItem(
//           icon: Icon(Icons.dashboard_rounded),
//           label: 'Dashboard',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.list_alt_rounded),
//           label: 'User List',
//         ),
//         BottomNavigationBarItem(
//           icon: Icon(Icons.info_outline_rounded),
//           label: 'Student Info',
//         ),
//         BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
//       ],
//       currentIndex: widget.selectedIndex,
//       selectedItemColor: Colors.indigo[600], // matching Dashboard theme
//       unselectedItemColor: Colors.grey[600],
//       onTap: widget.onItemTapped!,
//       backgroundColor: Colors.white,
//       elevation: 8,
//       showSelectedLabels: true,
//       showUnselectedLabels: true,
//     );
//   }
// }

// lib/pages/screens/bottom_nav/bottom_navigation.dart
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
      type: BottomNavigationBarType.fixed,
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.dashboard_rounded),
          label: 'Dashboard',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.list_alt_rounded),
          label: 'Events',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info_outline_rounded),
          label: 'Students',
        ),
        BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
      ],
      currentIndex: widget.selectedIndex,
      selectedItemColor: Colors.indigo[600],
      unselectedItemColor: Colors.grey[600],
      onTap: widget.onItemTapped!,
      backgroundColor: Colors.white,
      elevation: 8,
      showSelectedLabels: true,
      showUnselectedLabels: true,
    );
  }
}
