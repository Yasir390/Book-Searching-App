import 'package:book_tracker_paulo/db/db_helper.dart';
import 'package:flutter/material.dart';

import '../models/Book.dart';

class FavoritePage extends StatefulWidget {
  static const String routeName = '/favoritesPage';

  const FavoritePage({Key? key}) : super(key: key);

  @override
  State<FavoritePage> createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
          future: DatabaseHelper.instance.getFavorites(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator(),);
            }
            else if (snapshot.hasError) {
              return Center(child: Text('Error ${snapshot.error}'),);
            } else if (snapshot.hasData && snapshot.data!.isNotEmpty) {
              List<Book> favBooks = snapshot.data!;

              return ListView.builder(
                itemCount: favBooks.length,
                itemBuilder: (context, index) {
                  Book book = favBooks[index];
                  return Card(
                    child: ListTile(
                      leading: Image.network(book.imageLinks['thumbnail'] ?? '',
                        fit: BoxFit.cover,),
                      title: Text(book.authors.join(', ')),
                      trailing: const Icon(Icons.favorite,color: Colors.red,),
                    ),
                  );
                },
              );
            }
            else{
              return Center(child: Text('No Favorite book found'),);
            }
          },
        )
    );
  }
}
