import 'package:book_tracker_paulo/pages/book_details.dart';
import 'package:book_tracker_paulo/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

import '../components/grid_view_widget.dart';
import '../models/Book.dart';
import '../network/network.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/homePage';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Network network = Network();
  List<Book> _books = [];

  Future<void> _searchBooks(String query) async {
    try {
      List<Book> books = await network.searchBook(query);
      setState(() {
        _books = books;
      });
    } catch (e) {
      print('catch block');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                  hintText: 'Search for a book',
                  suffixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10))),
              onSubmitted: (value) => _searchBooks(value),
            ),
          ),
           GridViewWidget(books: _books)
        ],
      ),
    ));
  }
}

