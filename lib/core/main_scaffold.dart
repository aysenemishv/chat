import 'package:flutter/material.dart';

class MainScaffold extends StatefulWidget {
  final child;
  const MainScaffold({super.key, required this.child});

  @override
  State<MainScaffold> createState() => _MainScaffoldState();
}

class _MainScaffoldState extends State<MainScaffold> {
  int _currentIndex = 0;

  // final List<String> _pages = const [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: widget.child,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.chat)),
          BottomNavigationBarItem(icon: Icon(Icons.person)),
          BottomNavigationBarItem(icon: Icon(Icons.search)),
        ],
      ),
    );
  }
}
