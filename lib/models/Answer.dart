import "package:flutter/material.dart";

class Answer extends StatelessWidget {

  final Function handler;
  final String answer;

  Answer(this.handler, this.answer);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: RaisedButton(
        child: Text(answer),
        color: Colors.pink,
        onPressed: handler,
      ),

    );
  }
}
