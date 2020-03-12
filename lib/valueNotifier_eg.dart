import 'package:flutter/material.dart';
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Creating a value Notifier
    ValueNotifier valueNotifier = ValueNotifier("First Title");

    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: ValueListenableBuilder(
            valueListenable: valueNotifier,
            builder: (context, value, child) {
              return Text(value);
            },
          ),
        ),
        body: Stack(
          children: [
            // pass it to the class with text field and button
            ChangeTitle(valueNotifier),
          ],
        ),
      ),
    );
  }
}

class ChangeTitle extends StatelessWidget {
  ValueNotifier valueNotifier;
  ChangeTitle(this.valueNotifier);
  @override
  Widget build(BuildContext context) {
    var newTitle = TextEditingController();
    return Padding(
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          TextFormField(
            controller: newTitle,
          ),
          FlatButton(
            child: Text("Change Title"),
            onPressed: () {
              valueNotifier.value = newTitle.text;
              newTitle.clear();
            },
            color: Colors.amber,
          )
        ],
      ),
    );
  }
}
