import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/add_book/add_book_page.dart';
import 'package:provider/provider.dart';
import 'book_list_model.dart';

class BookListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<BookListModel>(
      create: (_) => BookListModel()..fetchBooks(),
      child: Scaffold(
        appBar: AppBar(
            title: Text('本一覧')
        ),
        body: Consumer<BookListModel>(
            builder: (context,model, child) {
              final books = model.booksdayo;
              final ListTitles = books.map(
                    (booktantai) => ListTile(
                      title: Text(booktantai.title),
                    ),
              ).toList();
              return ListView(
                children: ListTitles,
              );
            }
        ),
        floatingActionButton: Consumer<BookListModel>(
            builder: (context,model, child) {
            return FloatingActionButton(
              child: Icon(Icons.add),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => AddBookPage(),
                    // 画面遷移が下からひゅっと出てくる
                    fullscreenDialog: true,
                    ),
                  );
                  model.fetchBooks();
                }
            );
          }
        ),
      ),
    );
  }
}