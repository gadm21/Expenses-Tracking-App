import 'package:flutter/cupertino.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class NewTransaction extends StatefulWidget {
  final Function addTx, deleteTx;

  NewTransaction(this.addTx, this.deleteTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  String itemInput;
  String amountInput;

  final itemController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selected_date;

  void present_date_picker() {
    showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2019),
        lastDate: DateTime.now()).then((date){
          if(date== null) return;
          setState(() {
            selected_date= date;
          });
          
        });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: <Widget>[
          TextField(
            decoration: InputDecoration(labelText: "Item"),
            onChanged: (value) => itemInput = value,
            controller: itemController,
            onSubmitted: (value) => submitTransaction(),
          ),
          TextField(
            decoration: InputDecoration(labelText: "amount"),
            keyboardType: TextInputType.number,
            onChanged: (value) => amountInput = value,
            controller: amountController,
            onSubmitted: (value) => submitTransaction(),
          ),
          Row(
            children: <Widget>[
              Text( (selected_date==null ? "no date ? " : DateFormat.yMd().format(selected_date))),
              FlatButton(
                child: Text(
                  " choose date",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.purple,
                  ),
                ),
                onPressed: present_date_picker,
              )
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
            child: FlatButton(
              color: Colors.purple[400],
              textColor: Theme.of(context).textTheme.button.color,
              child: Text(
                "Add Transaction",
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
              onPressed: submitTransaction,
            ),
          ),
        ],
      ),
    );
  }

  submitTransaction() {
    final enteredItem = itemController.text;
    final enteredAmount = amountController.text;
    if(selected_date==null) selected_date= DateTime.now();
    if (enteredItem.isEmpty || enteredAmount.isEmpty) return;

    widget.addTx(enteredItem, double.parse(enteredAmount), selected_date);

    Navigator.of(context).pop();
  }
}
