import 'package:book_tracker_paulo/db/db_helper.dart';
import 'package:book_tracker_paulo/models/Book.dart';
import 'package:book_tracker_paulo/utils/book_details_arguments.dart';
import 'package:flutter/material.dart';


class BookDetails extends StatefulWidget {
  static const String routeName = '/bookDetails';

  const BookDetails({Key? key}) : super(key: key);

  @override
  State<BookDetails> createState() => _BookDetailsState();
}

class _BookDetailsState extends State<BookDetails> {
  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as BookDetailsArguments;
    final bool isFromSavedScreen = args.isFromSavedScreen;
    final Book book = args.itemBook;
    final theme = Theme.of(context).textTheme;
    return Scaffold(
      appBar: AppBar(
        title: Text(book.title),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(13.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Image.network(
                    book.imageLinks['thumbnail'] ?? '',
                  ),
                ),
                Column(
                  children: [
                    Text(
                      book.title,
                      style: theme.headlineSmall,
                    ),
                    Text(
                      book.authors.join(', '),
                      style: theme.labelLarge,
                    ),
                    Text(
                      'Published: ${book.publishedDate}',
                      style: theme.bodySmall,
                    ),
                    Text(
                      'Page count: ${book.pageCount}',
                      style: theme.bodySmall,
                    ),
                    Text(
                      'Language: ${book.language}',
                      style: theme.bodySmall,
                    ),
                    SizedBox(height: 10 ,)
,                    SizedBox(

                      child: !isFromSavedScreen ? ElevatedButton(
                          onPressed: () async {
                            try{
                              int savedInt =await DatabaseHelper.instance.insert(book);
                              SnackBar snackBar = SnackBar(content: Text('Book Saved : $savedInt'));
                              ScaffoldMessenger.of(context).showSnackBar(snackBar);
                            }catch(e){
                              print('Error: $e');
                            }
                          },
                          child: const Text('Save'),
                        ) :
                        ElevatedButton.icon(
                          onPressed: () async {
                          },
                          icon:const Icon(Icons.favorite),
                          label: const Text('Favorite'),
                        )
                    ),
                  const  SizedBox(
                      height: 10,
                    ),
                    Text(
                      'Description',
                      style: theme.titleSmall,
                    ),
                    const  SizedBox(
                      height: 5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        padding:const EdgeInsets.all(10) ,
                      //  margin:const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Theme.of(context).colorScheme.secondary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.orange,width: 1,)
                        ),
                        child: Text(book.description,textAlign: TextAlign.justify,),
                      ),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
