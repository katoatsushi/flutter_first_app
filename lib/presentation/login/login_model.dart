import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';


class LoginModel extends ChangeNotifier {
  String mail = '';
  String password = '';

  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future login()  async {
    if (mail.isEmpty) {
      throw('メールアドレスを入力してください');
    }
    if (password.isEmpty) {
      throw('パスワードを入力してください');
    }
    //TODO::サインイン
    // // ユーザーを取得するやり方
    // final FirebaseUser user = (await _auth.signInWithEmailAndPassword(
    //   email: mail,
    //   password: password,
    // )).user;

    // ユーザーを取得しないやり方
    final result = await _auth.signInWithEmailAndPassword(
      email: mail,
      password: password,
    );
    final uid = result.user.uid;
    //TODO 端末に保存する
  }
}
// ka.baseball1997@gmail.com