import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/domain/book.dart';
import 'package:flutter_app/presentation/book_list/book_list_page.dart';
import 'package:provider/provider.dart';
import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  AddBookPage({this.book});
  final Book book;
  @override
  Widget build(BuildContext context) {
    final bool isUpdate = book != null;
    final textEditingController = TextEditingController();

    if (isUpdate) {
      textEditingController.text = book.title;
    }

    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
            title: Text(isUpdate ? '本を編集': '本を追加'),
        ),
        body: Consumer<AddBookModel>(
            builder: (context,model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  TextField(
                    decoration: InputDecoration(
                        hintText: "本のタイトルを入力してください。"),
                    controller: textEditingController,
                    onChanged: (text){
                      model.bookTitle = text;
                    },
                  ),
                  RaisedButton(
                    child: Text(isUpdate ? "更新する":"追加する"),
                    onPressed: ()  async {
                      if (isUpdate) {
                        await updateBook(model,context);
                      } else {
                        //TODO:: Firestoreに追加
                        await addBook(model,context);
                      }
                    },
                  ),
                ],
               ),
              );
            },
        ),
      ),
    );
  }
  Future addBook(AddBookModel model, BuildContext context) async {
    try {
      // うまくいった場合
      await model.addBookToFirebase();
      // model.addBookToFirebase()が成功したら、showDialogに移行する
      // いかなかたら
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('保存しました！'),
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
      Navigator.of(context).pop();
    } catch (e) {
      // うまくいかなかっ場合
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
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
  Future updateBook(AddBookModel model, BuildContext context) async {
    try {
      // うまくいった場合
      await model.updateBook(book);
      // model.addBookToFirebase()が成功したら、showDialogに移行する
      // いかなかたら
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text('更新しました！'),
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
      Navigator.of(context).pop();
    } catch (e) {
      // うまくいかなかっ場合
      showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text(e.toString()),
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
}