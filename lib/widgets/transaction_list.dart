import 'package:flutter/material.dart';
import 'package:flutter_personal_expenses/models/transaction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> _transactions;
  final Function deleteTx;

  const TransactionList(this._transactions, this.deleteTx);

  @override
  Widget build(BuildContext context) {
    return _transactions.isEmpty
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Text(
                "No transactions added yet!!",
                style: Theme.of(context).textTheme.title,
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                  height: 200,
                  child: Image.asset(
                    "assets/images/waiting.png",
                    fit: BoxFit.fill,
                  )),
            ],
          )
        : ListView.builder(
            itemBuilder: (ctx, index) {
              var tx = _transactions[index];
              return Card(
                elevation: 5,
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                child: ListTile(
                  leading: Container(
                    // ili CircleAvatar
                    height: 60,
                    width: 60,
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      shape: BoxShape.circle,
                      backgroundBlendMode: BlendMode.saturation,
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(6),
                      child: FittedBox(
                        child: Text(
                          "\$${tx.amount}",
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  title: Text(
                    tx.title,
                    style: Theme.of(context).textTheme.title,
                  ),
                  subtitle: Text(DateFormat.yMMMMd().format(tx.date)),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () => deleteTx(tx.id),
                  ),
                ),
              );
            },
            itemCount: _transactions.length,
          );
  }
}
/**
    Card(
    child: Row(
    children: <Widget>[
    Container(
    child: Text(
    "${transaction.amount.toStringAsFixed(2)} kn",
    style: TextStyle(
    fontWeight: FontWeight.bold,
    fontSize: 20,
    color: Theme.of(context).primaryColor,
    ),
    ),
    margin: EdgeInsets.all(10),
    decoration: BoxDecoration(
    border: Border.all(
    color: Theme.of(context).primaryColor,
    width: 2,
    style: BorderStyle.solid),
    ),
    padding: EdgeInsets.all(10),
    ),
    Column(
    children: <Widget>[
    Text(
    transaction.title,
    style: Theme.of(context).textTheme.title,
    ),
    Text(
    DateFormat.yMMMMd().format(transaction.date),
    style: TextStyle(
    color: Theme.of(context).primaryColorLight,
    fontSize: 15,
    ),
    ),
    ],
    crossAxisAlignment: CrossAxisAlignment.start,
    )
    ],
    ),
    );
 */
