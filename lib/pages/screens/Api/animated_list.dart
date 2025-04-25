// import 'package:flutter/material.dart';

// class MyAnimatedList extends StatefulWidget {
//   const MyAnimatedList({Key? key}) : super(key: key);

//   @override
//   State<MyAnimatedList> createState() => _MyAnimatedListState();
// }

// class _MyAnimatedListState extends State<MyAnimatedList> {
//  @override
//   Widget build(BuildContext context) {
//     return SafeareaWidget();
//   }
// }

// class SafeareaWidget extends StatelessWidget {
//   const SafeareaWidget({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: SafeArea(
//         child: Container(
//           padding: const EdgeInsets.only(right: 25, left: 25, top: 10),
//           child: Column(
//             children: [
//               const SizedBox(height: 20),
//               Container(
//                 height: 200,
//                 width: double.infinity,
//                 padding: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
//                 decoration: BoxDecoration(
//                   color: Colors.black26,
//                   borderRadius: BorderRadius.circular(30),
//                 ),
//                 child: Column(
//                   children: [
//                     const Text(
//                       "User List",
//                       ),
//                       const SizedBox(height: 20,),
//                     ),
//                   ],
//                    const SizedBox(height: 20),
//                    Expanded(child: AnimatedList(
//                     initialItemCount: users,length
//                     itemBuilder: (context, index, animation){return GestureDetector(
//                     onTap(){}
//                     child: FadeTransition(opacity: animation, child: Container(
//                       padding: EdgeInsets.only(
//                         top: 15,
//                       ),
//                       child: Row(
//                         children: [
//                         SizedBox(
//                           height: 70,
//                           width: 70,
//                           child: CircleAvatar(backgroundColor: Colors.brown,),)
//                       ]),
//                     )),
//                     )},)
//                 ),
//               ),
//             ],
//          ),
//         ),
//       ),
//     );
//   }
// }
