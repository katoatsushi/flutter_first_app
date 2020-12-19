import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/book.dart';
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
              final books = model.books;
              final ListTitles = books.map(
                    (book) => ListTile(
                      title: Text(book.title),
                      trailing: IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            //TODO::編集画面へ
                            MaterialPageRoute(builder: (context) => AddBookPage(
                              book: book,
                            ),
                              fullscreenDialog: true,
                            ),
                          );
                          model.fetchBooks();
                        },
                      ),
                      onLongPress: () async {
                        //TODO::削除
                        await showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text('${book.title}を削除しますか？'),
                                actions: <Widget>[
                                  FlatButton(
                                    child: Text('OK!'),
                                    onPressed: () async {
                                      Navigator.of(context).pop();
                                      //TODO: 削除のAPIを叩く
                                      await deleteBook(context, model, book);
                                    },
                                  ),
                                ],
                              );
                            }
                        );
                      },
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
                onPressed: () async {
                 await Navigator.push(
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
  Future deleteBook(BuildContext context, BookListModel model, Book book) async {
    try {
      // うまくいった場合
      await model.deleteBook(book);
      await model.fetchBooks();
      // await _showDialog(context, "削除しました!");
    } catch (e) {
      // await _showDialog(context, e.toString());
      print(e.toString());
    }
  }

  Future _showDialog(BuildContext context, String title, ) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text(title),
            actions: <Widget>[
              FlatButton(child: Text('OK!'),
                onPressed: () {
                  // Navigator.of(context).pop();
                  Navigator.of(context).pop();
                },)
            ],
          );
        }
    );
  }
}