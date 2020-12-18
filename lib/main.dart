import 'package:flutter/material.dart';
import 'package:flutter_app/next_page.dart';
import 'package:flutter_app/main_model.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

void main() {
  debugPaintSizeEnabled = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'flutter app',
      home: ChangeNotifierProvider<MainModel>(
        create: (_) => MainModel(),
        child: Scaffold(
          appBar: AppBar(
            title: Text('コリアンダー'),
          ),
          body: Consumer<MainModel>(
            builder: (context, model, child) {
              return Center(
                child: Column(
                  children: [
                    Text(model.gonzaText),
                    RaisedButton(child: Text('ボタン'),
                        onPressed: () {
                          //TODO:: ボタンの処理内容を記載
                          model.changeGonzaText();
                        },
                    ),
                  ],
                ),
              );
            }
          ),
        ),
      ),
    );
  }
}
