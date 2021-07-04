// import 'package:flutter/material.dart';

// class ScrollController extends StatefulWidget {
//   @override
//   _ScrollControllerState createState() => _ScrollControllerState();
// }

// class _ScrollControllerState extends State<ScrollController> {
//     late AnimationController controller;
//   final ScrollController _scrollController = ScrollController();

//           //   _scrollController.animateTo(
//           //   _scrollController.position.minScrollExtent,
//           //   duration: Duration(milliseconds: 500),
//           //   curve: Curves.fastOutSlowIn,
//           // );
//   @override
//   void initState() {
//     super.initState();
//     controller = AnimationController(
//       vsync: this,
//       duration: const Duration(seconds: 2),
//     )..addListener(() {
//         setState(() {});
//       });
//     controller.repeat(reverse: true);
//   }

//   @override
//   void dispose() {
//     controller.dispose();
//     _scrollController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container();
//   }
// }

//     if (categoryList?.length == 0 && menuList?.length == 0) {
//       return Scaffold(
//         body: SafeArea(
//           child: Container(
//             child: Center(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CircularProgressIndicator(
//                     value: controller.value,
//                     semanticsLabel: 'Linear progress indicator',
//                   ),
//                   SizedBox(height: 10.0),
//                   Text(
//                     'Loading...',
//                     style: TextStyle(
//                       color: Colors.black,
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       );
//     } else {}