import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/book_list/book_list_page.dart';
import 'package:provider/provider.dart';
import 'add_book_model.dart';

class AddBookPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddBookModel>(
      create: (_) => AddBookModel(),
      child: Scaffold(
        appBar: AppBar(
            title: Text('本を追加')
        ),
        body: Consumer<AddBookModel>(
            builder: (context,model, child) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(children: <Widget>[
                  TextField(
                    onChanged: (text){
                      model.bookTitle = text;
                    },
                  ),
                  RaisedButton(
                    child: Text("追加する"),
                    onPressed: ()  async {
                      //TODO:: Firestoreに追加

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
                                  FlatButton( child: Text('OK!'),
                                    onPressed: (){
                                      // Navigator.of(context).pop();
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(builder: (context) => BookListPage(),
                                          // 画面遷移が下からひゅっと出てくる
                                          fullscreenDialog: true,
                                        ),
                                      );
                                    },)
                                ],
                              );
                            }
                        );
                      } catch(e) {
                        // うまくいかなかっ場合
                        showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return AlertDialog(
                                content: Text(e.toString()),
                                actions: <Widget>[
                                  FlatButton( child: Text('OK!'),
                                    onPressed: (){
                                      // Navigator.of(context).pop();
                                      Navigator.of(context).pop();
                                    },)
                                ],
                              );
                            }
                        );
                      }
                    },
                  ),
                ],),
              );
            }
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () {
            //TODO
          },
        ),
      ),
    );
  }
}