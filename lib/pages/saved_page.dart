import 'package:book_tracker_paulo/db/db_helper.dart';
import 'package:book_tracker_paulo/pages/book_details.dart';
import 'package:book_tracker_paulo/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  static const String routeName = '/savedPage';

  const SavedPage({Key? key}) : super(key: key);

  @override
  State<SavedPage> createState() => _SavedPageState();
}

class _SavedPageState extends State<SavedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: FutureBuilder(
            future: DatabaseHelper.instance.readAllBooks(),
            builder: (context, snapshot) => snapshot.hasData
                ? ListView.builder(
                    itemCount: snapshot.data!.length,
                    itemBuilder: (context, index) {
                      var book = snapshot.data![index];
                      return InkWell(
                        onTap: (){
                          Navigator.pushNamed(context, BookDetails.routeName,arguments: BookDetailsArguments(itemBook: book, isFromSavedScreen: true));
                        },
                        child: Card(
                          child: ListTile(
                            title: Text(book.title),
                            leading: Image.network(
                              book.imageLinks['thumbnail'] ?? '',
                              fit: BoxFit.cover,
                            ),
                            trailing: IconButton(
                              onPressed: () {
                                DatabaseHelper.instance.deleteBook(book.id);
                                setState(() {});
                              },
                              icon: const Icon(Icons.delete),
                            ),
                            subtitle: Column(
                              children: [
                                Text(book.authors.join(', ')),
                                ElevatedButton.icon(
                                  onPressed: () async {
                                    book.isFavorite = !book.isFavorite;
                                    await DatabaseHelper.instance.
                                    toggleFavoriteStatus(book.id, book.isFavorite);
                                    setState(() {
                                    });

                                  },
                                  icon:  Icon(book.isFavorite ?Icons.favorite:Icons.favorite_outline,
                                   color:book.isFavorite?Colors.red: null ,
                                  ),
                                  label:  Text(book.isFavorite? 'Favorite':'Add to Favorites'),
                                )
                              ],
                            ),
                          ),
                        ),
                      );
                    })
                : const Center(child: CircularProgressIndicator()
            )
        )
    );
  }
}
