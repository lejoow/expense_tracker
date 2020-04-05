import 'package:expense_tracker/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupedTransactionValues {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalAmount = 0.0;
      for (var i = 0; i < recentTransactions.length; i++) {
        var recentTxDate = recentTransactions[i].date;
        if (recentTxDate.day == weekDay.day &&
            recentTxDate.month == weekDay.month &&
            recentTxDate.year == weekDay.year) {
          totalAmount += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalAmount
      };
    });
  }

  @override
  Widget build(BuildContext context) {
    print(groupedTransactionValues);
    return Card(
        elevation: 6,
        margin: EdgeInsets.all(20),
        child: Row(
            children: groupedTransactionValues.map((e) {
          return Text(
            e['day'].toString() + ' ' + e['amount'].toString(),
          );
        }).toList()));
  }
}
