import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction({this.addTransaction});

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate;

  void submitForm() {
    final enteredTitle = titleController.text;
    final enteredAmout = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmout <= 0 || selectedDate == null) {
      return;
    }

    widget.addTransaction(
      enteredTitle,
      double.parse(amountController.text),
      selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() async {
    DateTime pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    );

    if (pickedDate == null) {
      return;
    } else {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        child: Padding(
          padding: EdgeInsets.only(
            top: 8,
            left: 8,
            right: 8,
            bottom: MediaQuery.of(context).viewInsets.bottom + 8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: titleController,
                onSubmitted: (_) => submitForm(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: amountController,
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitForm(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        selectedDate == null
                            ? 'No Date Chosen!'
                            : DateFormat.yMd().format(selectedDate),
                      ),
                    ),
                    Platform.isIOS
                        ? CupertinoButton(
                            onPressed: _presentDatePicker,
                            child: const Text(
                              'Choose Date',
                            ),
                          )
                        : FlatButton(
                            onPressed: _presentDatePicker,
                            textColor: Theme.of(context).primaryColor,
                            child: const Text('Choose Date'),
                          ),
                  ],
                ),
              ),
              FlatButton(
                onPressed: submitForm,
                child: Text('Add Transaction'),
                textColor: Theme.of(context).buttonColor,
                color: Theme.of(context).primaryColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
