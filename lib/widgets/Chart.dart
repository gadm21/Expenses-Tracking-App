import 'package:first_app/models/Transaction.dart';
import "package:flutter/material.dart";
import "package:intl/intl.dart";

import "../models/Transaction.dart";
import "./Chart_bar.dart";

class Chart extends StatelessWidget {
  final List<Transaction> recent_transactions;

  Chart(this.recent_transactions);

  List<Map<String, Object>> get trans_values {
    return List.generate(7, (index) {
      final Date = DateTime.now().subtract(Duration(days: index),);

      double sum = 0;
      for (int i = 0; i < recent_transactions.length; i++) {
        if (recent_transactions[i].date.day == Date.day &&
            recent_transactions[i].date.month == Date.month) {
          sum += recent_transactions[i].amount;
        }
      }

      return {
        "day": DateFormat.E().format(Date),
        "amount": sum,
      };
    }).reversed.toList();
  }

  double get total_spending {
    return trans_values.fold(0.0, (sum, item) {
      return sum + item["amount"];
    });
  }

  @override
  Widget build(BuildContext context) {

    return Container(
      width: double.infinity,
      height: 150,
      child: Card(
          elevation: 6,
          margin: EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(
                height: 7,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: trans_values.map((data) {
                  return ChartBar(
                    data["day"].toString(),
                    data["amount"],
                    total_spending == 0.0
                        ? 0.0
                        : (data["amount"] as double) / total_spending,
                  );
                }).toList(),
              ),
            ],
          )),
    );
  }
}
