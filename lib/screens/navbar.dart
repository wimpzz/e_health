import 'package:flutter/material.dart';
import 'home_screen.dart';
import 'activity_screen.dart';
import 'more_screen.dart';

class NavBar extends StatefulWidget {
  final int currentIndex;
  final String email;
  final String userName;
  final String firstName;
  final String lastName;

  NavBar({
    required this.currentIndex,
    required this.email,
    required this.userName,
    required this.firstName,
    required this.lastName,
  });

  @override
  _NavBarState createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  late int _currentIndex;

  @override
  void initState() {
    super.initState();
    _currentIndex = widget.currentIndex;
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      items: const <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.note),
          label: 'Activity',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.more_horiz),
          label: 'More',
        ),
      ],
      currentIndex: _currentIndex,
      selectedItemColor: Colors.lightBlue,
      onTap: (index) {
        setState(() {
          _currentIndex = index;
        });
        switch (index) {
          case 0:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => HomeScreen(
                  email: widget.email,
                  userName: widget.userName,
                  firstName: widget.firstName,
                  lastName: widget.lastName, phoneNumber: '', birthdate: '', sex: '',
                ),
              ),
            );
            break;
          case 1:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => ActivityScreen()),
            );
            break;
          case 2:
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => MoreScreen()),
            );
            break;
        }
      },
    );
  }
}
