import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/book.dart';

class BookListModel extends ChangeNotifier {
  List<Book> booksdayo = [];
  Future fetchBooks() async {
    final docs = await Firestore.instance.collection('books').getDocuments();
    final books = docs.documents.map((doc) => Book(doc['title'])).toList();
    this.booksdayo = books;
    notifyListeners();
  }
}