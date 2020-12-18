import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_app/domain/book.dart';

class AddBookModel extends ChangeNotifier {
 String bookTitle = '';

 Future addBookToFirebase() async {
   if (bookTitle.isEmpty) {
     throw('タイトルを入力してください');
   }

   Firestore.instance.collection('books').add(
       {
        'title': bookTitle,
         'createdAt': Timestamp.now(),
       });
 }
}