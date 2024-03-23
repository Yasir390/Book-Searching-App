import 'package:book_tracker_paulo/my_home_page.dart';
import 'package:book_tracker_paulo/pages/book_details.dart';
import 'package:book_tracker_paulo/pages/favorite_page.dart';
import 'package:book_tracker_paulo/pages/home_page.dart';
import 'package:book_tracker_paulo/pages/saved_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Book Tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orangeAccent),
        useMaterial3: true,
      ),
      initialRoute: MyHomePage.routeName,
      routes: {
        MyHomePage.routeName : (context) =>const MyHomePage(),
        HomePage.routeName : (context) =>const HomePage(),
        SavedPage.routeName : (context) =>const SavedPage(),
        FavoritePage.routeName : (context) =>const FavoritePage(),
        BookDetails.routeName : (context) =>const BookDetails(),
      },
    );
  }
}
