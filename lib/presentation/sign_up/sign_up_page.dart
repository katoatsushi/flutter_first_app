import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/presentation/login/login_page.dart';
import 'package:flutter_app/presentation/sign_up/sign_up_model.dart';
import 'package:provider/provider.dart';

class SignUpPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final mailController = TextEditingController();
    final passwordController = TextEditingController();

    return ChangeNotifierProvider<SignUpModel>(
      create: (_) => SignUpModel(),
      child: Scaffold(
        appBar: AppBar(
          title: Text('新規登録'),
        ),
        body: Consumer<SignUpModel>(
          builder: (context, model, child) {
            return Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(children: <Widget>[
                TextField(
                  decoration: InputDecoration(hintText: "メールアドレス"),
                  controller: mailController,
                  onChanged: (text){
                    model.mail = text;
                  },
                ),
                TextField(
                  decoration: InputDecoration(hintText: "パスワード"),
                  obscureText: true,
                  controller: passwordController,
                  onChanged: (text){
                    model.password = text;
                  },
                ),
                RaisedButton(
                  child: Text("登録する"),
                  onPressed: ()  async {
                    try {
                      await model.signUp();
                      _showDialog(context, '成功しました！');
                    } catch(e) {
                      print(e.toString());
                      _showDialog(context, e.toString());
                    }
                  },
                ),
                RaisedButton(
                  child: Text("ログインする"),
                  onPressed: ()  {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => LoginPage()),
                    );
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
