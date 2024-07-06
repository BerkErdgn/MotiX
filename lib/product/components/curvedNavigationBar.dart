import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

CurvedNavigationBar genericCurvedNavigationBar() {
  const Color backgroundColor = Colors.transparent;
  Color navigationBarColor = Color(0xFFED7D31);

  const int animationDuration = 300;

  return CurvedNavigationBar(
      height: 57,
      index: 2,
      backgroundColor: backgroundColor,
      color: navigationBarColor,
      animationDuration: const Duration(milliseconds: animationDuration),
      items: const [
        Icon(Icons.notes_sharp),
        Icon(Icons.support_agent),
        Icon(Icons.checklist),
        Icon(Icons.comment_rounded),
        Icon(Icons.account_circle),
      ]);
}
