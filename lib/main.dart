import './widgets/NewTransaction.dart';
import './widgets/TransactionList.dart';

import "package:flutter/material.dart";

import "./widgets/Chart.dart";
import "./models/Transaction.dart";

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  const App({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.purple,
        accentColor: Colors.amber,
        fontFamily: "Quicksand",
        textTheme: ThemeData.light().textTheme.copyWith(
            title: TextStyle(
              fontFamily: "OpenSans",
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            button: TextStyle(color: Colors.white)),
      ),
      title: "flutter app",
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage();

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<HomePage> {
  final List<Transaction> transactions = [];

  void addNewTrans(String title, double amount, DateTime selected_date) {
    final newTx = Transaction(
      title: title,
      amount: amount,
      date:selected_date,
      id: DateTime.now().toString(),
    );
    setState(() {
      transactions.add(newTx);
    });
  }

  void delete_tx(String id){
    setState(() {
     transactions.removeWhere((transaction){
       return transaction.id== id;
     }); 
    });
  }

  void deleteTransaction() {
    setState(() {
      transactions.removeLast();
    });
  }

  void show_sheet(BuildContext ctx) {
    showModalBottomSheet(
      context: ctx,
      builder: (n_ctx) {
        return NewTransaction(addNewTrans, deleteTransaction);
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(" Expenses Tracking"),
        // actions: <Widget>[
        //   IconButton(
        //     icon: Icon(Icons.add),
        //     onPressed: () {},
        //   ),
        // ],
      ),
      body: SingleChildScrollView(
          child: Column(children: <Widget>[
        Chart(transactions),
        TransactionList(
          transactions: transactions,
          delete_tx: delete_tx,
        ),
      ])),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          show_sheet(context);
        },
      ),
    );
  }
}
