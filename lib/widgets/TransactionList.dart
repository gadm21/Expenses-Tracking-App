import "package:flutter/material.dart";

import "../widgets/TransactionCard.dart";
import "../models/Transaction.dart";

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function delete_tx;

  TransactionList({Key key, this.transactions,this. delete_tx}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
        ? Column(
            children: <Widget>[
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 50,
                child: Text(
                  "No transactions added yet !",
                  style: Theme.of(context).textTheme.title,
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                width: double.infinity,
                height: 200,
                child: Image.asset("assets/images/waiting.png"),
              ),
            ],
          )
        : (Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: transactions.map((tx) {
              return TransactionCard(
                tx: tx,
                delete_tx: delete_tx,
              );
            }).toList(),
          ));
  }
}
