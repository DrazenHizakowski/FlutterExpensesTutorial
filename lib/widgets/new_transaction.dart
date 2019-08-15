import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  State<StatefulWidget> createState() => NewTransactionState();
}

class NewTransactionState extends State<NewTransaction> {
  DateTime _selectedDate;

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransactionState();

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              autofocus: true,
              cursorColor: Colors.blue,
              decoration: InputDecoration(labelText: "Please name your task"),
              controller: titleController,
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              decoration: InputDecoration(labelText: "Please input amount"),
              controller: amountController,
              onSubmitted: (_) => _submitData(),
            ),
            Container(
              height: 70,
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text(_selectedDate == null
                        ? "No Date Chosen!"
                        : "Picked Date: " +
                            DateFormat.yMMMMd().format(_selectedDate)),
                  ),
                  FlatButton(
                    child: Text(
                      "Choose Date!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    textColor: Theme.of(context).primaryColor,
                    onPressed: _presentDatePicker,
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text(
                "Add transaction",
              ),
              textColor: Theme.of(context).textTheme.button.color,
              color: Theme.of(context).primaryColor,
              onPressed: () => _submitData(),
            )
          ],
        ),
      ),
    );
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then((date) {
      if (date == null) return;
      setState(() {
        _selectedDate = date;
      });
    });
  }

  void _submitData() {
    if (amountController.text.isEmpty) {
      return;
    }

    try {
      double.parse(amountController.text);
    } catch (e) {
      return;
    }

    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null)
      return;

    widget.addTransaction(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    _selectedDate = null;
    Navigator.of(context).pop();
  }
}
