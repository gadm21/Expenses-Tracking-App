import "package:flutter/material.dart";
import 'package:flutter/semantics.dart';
import "package:intl/intl.dart";

import "../models/Transaction.dart";

class TransactionCard extends StatelessWidget {
  final Transaction tx;
  final Function delete_tx;

  const TransactionCard({this.tx, Key key, this.delete_tx}) : super(key: key);

  void delete_callback(){
    delete_tx(tx.id);
  }
  @override
  Widget build(BuildContext context) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
        child: ListTile(
          leading: CircleAvatar(
            radius: 40,
            child: Padding(
              padding: const EdgeInsets.all(2.0),
              child: FittedBox(
                  child: Text(
                "\$${tx.amount}",
              )),
            ),
          ),
          title: Text(
            tx.title,
            style: Theme.of(context).textTheme.title,
          ),
          subtitle: Text(
            DateFormat.yMMMd().format(tx.date),
          ),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            color: Theme.of(context).errorColor,
            onPressed: delete_callback,
          ),
        ));
  }
}
