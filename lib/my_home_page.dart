import 'package:book_tracker_paulo/network/network.dart';
import 'package:book_tracker_paulo/pages/favorite_page.dart';
import 'package:book_tracker_paulo/pages/saved_page.dart';
import 'package:flutter/material.dart';

import 'pages/home_page.dart';

class MyHomePage extends StatefulWidget {
  static const String routeName = '/';
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;

  final List<Widget> _screens = [
   const HomePage(),
   const SavedPage(),
   const FavoritePage(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title:const Text('A. Reader'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body:_screens[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        items:const <BottomNavigationBarItem> [
        BottomNavigationBarItem( icon:Icon(Icons.home),label: 'Home'),
        BottomNavigationBarItem( icon:Icon(Icons.save),label: 'Saved'),
        BottomNavigationBarItem( icon:Icon(Icons.favorite),label: 'Favorite'),
      ],
        selectedItemColor: Theme.of(context).colorScheme.onPrimary,
        unselectedItemColor: Theme.of(context).colorScheme.onSurfaceVariant,
        currentIndex: _currentIndex,
        onTap: (value){
        setState(() {
          _currentIndex = value;
        });
        },
      ),
    );
  }
}
