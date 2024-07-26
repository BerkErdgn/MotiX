import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:motix_app/pages/coachPage/coach_page.dart';
import 'package:motix_app/pages/notes_page/notes_page.dart';
import 'package:motix_app/pages/profilePage/profile.dart';
import 'package:motix_app/pages/social_media_page/social_media_page.dart';
import 'package:motix_app/pages/toDo/todo_page.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 2;
  final List<Widget> _pages = [
    const NotesPage(),
    const CoachPage(),
    const TodoPage(),
     SocialMediaPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_currentIndex],
      bottomNavigationBar: _shouldShowNavBar()
          ? CurvedNavigationBar(
              height: 60,
              index: _currentIndex,
              backgroundColor: Colors.transparent,
              color: Color(0xFFED7D31),
              animationDuration: Duration(milliseconds: 300),
              items: const [
                Icon(Icons.notes_sharp),
                Icon(Icons.support_agent),
                Icon(Icons.checklist),
                Icon(Icons.comment_rounded),
                Icon(Icons.account_circle),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
            )
          : null,
    );
  }

  bool _shouldShowNavBar() {
    return _currentIndex == 0 ||
        _currentIndex == 1 ||
        _currentIndex == 2 ||
        _currentIndex == 3 ||
        _currentIndex == 4;
  }
}
