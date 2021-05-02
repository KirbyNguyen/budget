import 'package:budget/pages/transaction/TransactionDetailPage.dart';
import 'package:flutter/material.dart';

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildItem(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  // Widget buildSubtitle(BuildContext context);
}

class DetailedItem implements ListItem {
  final String categoryName;
  final double amount;
  Color catColor;
  Color accountColor;
  final int type;
  final DateTime date;
  final String id;

  DetailedItem({
    this.categoryName,
    this.amount,
    this.catColor,
    this.accountColor,
    this.type,
    this.date,
    this.id,
  });

  Widget buildItem(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TransactionDetailPage(
              transactionId: id
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              width: 1.0,
              color: Colors.grey[500],
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              15.0, 5.0, 15.0, 5.0), // vertical: 5.0, horizontal: 15.0),
          child: Row(
            children: <Widget>[
              Expanded(
                child: Icon(
                  Icons.circle,
                  size: 15,
                  color: accountColor,
                ),
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                flex: 8,
                child: Column(
                  // mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      categoryName,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: catColor,
                      ),
                    ),
                    SizedBox(
                      height: 3,
                    ),
                    Text(
                      date.toString().substring(0, 10),
                      style: TextStyle(
                        color: Colors.grey[600],
                        fontSize: 13.0,
                      ),
                      textAlign: TextAlign.left,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 4,
                child: Text(
                  amount.toStringAsFixed(2),
                  textAlign: TextAlign.right,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 1.3,
                    color: type == 0 ? Colors.red : Colors.green,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
