import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/book.dart';

class BookListModel extends ChangeNotifier {
  List<Book> books = [];

  // TODO::画面更新をする
  Future fetchBooks() async {
    final docs = await Firestore.instance.collection('books').getDocuments();
    // final books = docs.documents.map((doc) => Book(doc['title'])).toList();
    final books = docs.documents.map((doc) => Book(doc)).toList();
    this.books = books;
    notifyListeners();
  }
  Future deleteBook(Book book) async {
    await Firestore.instance.collection('books')
          .document(book.documentID).delete();
  }
}