import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/Book.dart';
class Network{
  static const String _baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  Future<List<Book>> searchBook(String query)async{
    var url = Uri.parse('$_baseUrl?q=$query');
    var response =await http.get(url);

    if(response.statusCode == 200){
      var data = json.decode(response.body);
      if(data['items'] != null && data['items'] is List){
        List<Book> books = (data['items'] as List<dynamic>).map((e) => Book.fromJson(e as Map<String,dynamic>)).toList();
       return books;
      }else{
        return [];
      }

    }else{
      throw Exception('Failed to load books');
    }
  }
}