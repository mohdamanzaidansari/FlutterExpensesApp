import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:quiz_app/models/transanction.dart';
import 'package:intl/intl.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> usertransactions;
  final Function deleteTransaction;

  TransactionList({this.usertransactions, this.deleteTransaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topCenter,
      child: usertransactions.isEmpty
          ? LayoutBuilder(builder: (context, constraints) {
              return Column(
                children: [
                  Text(
                    'No transaction added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Container(
                      height: constraints.maxHeight * 0.6,
                      child: Image.asset(
                        'assets/images/waiting.png',
                        fit: BoxFit.cover,
                      )),
                ],
              );
            })
          : ListView.builder(
              itemCount: usertransactions.length,
              itemBuilder: (ctx, index) {
                return TransactionItem(
                  usertransactions: usertransactions,
                  deleteTransaction: deleteTransaction,
                  index: index,
                );
              },
            ),
    );
  }
}

class TransactionItem extends StatelessWidget {
  const TransactionItem({
    Key key,
    @required this.usertransactions,
    @required this.deleteTransaction,
    @required this.index,
  }) : super(key: key);

  final List<Transaction> usertransactions;
  final Function deleteTransaction;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(
        horizontal: 5,
        vertical: 8,
      ),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: FittedBox(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                '\$${usertransactions[index].amount.toStringAsFixed(2)}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ),
          ),
        ),
        title: Text(usertransactions[index].title,
            style: Theme.of(context).textTheme.headline6),
        subtitle: Text(
          DateFormat('yyyy-MM-dd').format(usertransactions[index].date),
          style: TextStyle(
            color: Colors.grey,
          ),
        ),
        trailing: MediaQuery.of(context).size.width > 460
            ? FlatButton.icon(
                icon: Icon(Icons.delete),
                textColor: Theme.of(context).errorColor,
                label: Text('Delete'),
                onPressed: () => deleteTransaction(
                  usertransactions[index].id,
                ),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deleteTransaction(
                  usertransactions[index].id,
                ),
              ),
      ),
    );
  }
}
