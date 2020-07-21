import 'package:flutter/material.dart';

class DebugPage extends StatelessWidget {
  const DebugPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Debug page'),
      ),
      body: ListView(
        children: <Widget>[
          RaisedButton(
            child: Text('Action 1'),
            onPressed: () {},
          )
        ],
      ),
    );
  }
}
