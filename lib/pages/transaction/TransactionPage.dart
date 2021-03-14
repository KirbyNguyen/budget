import 'package:budget/services/UserDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:budget/pages/accounts/AccountPage.dart';
import 'package:provider/provider.dart';

class TransactionPage extends StatefulWidget {
  @override
  _TransactionPageState createState() => _TransactionPageState();
}

class _TransactionPageState extends State<TransactionPage> {
// Build list of items based on their types: date items and purchase items
// based on chronological order
// 2 types of ListItem: DateItem(String date) for the date category
//                      PurchaseItem(String name, Double amount, Color color)
// also get the sum of all spending this month
  List<ListItem> items = [
    DateItem('March 9, 2021'),
    PurchaseItem(
        purchaseName: 'Making my first flutter app',
        amount: 123.00,
        colorName: Colors.cyan),
    PurchaseItem(
        purchaseName: 'No more hello world apps',
        amount: 53.00,
        colorName: Colors.amber),
    DateItem('March 7, 2021'),
    PurchaseItem(
        purchaseName: 'Good flutter app',
        amount: 81.00,
        colorName: Colors.deepOrange),
    PurchaseItem(
        purchaseName: 'Making my first flutter app',
        amount: 123.00,
        colorName: Colors.cyan),
    PurchaseItem(
        purchaseName: 'No more hello world apps',
        amount: 53.00,
        colorName: Colors.amber),
    DateItem('March 6, 2021'),
    PurchaseItem(
        purchaseName: 'Good flutter app',
        amount: 81.00,
        colorName: Colors.deepOrange),
    DateItem('March 3, 2021'),
    PurchaseItem(
        purchaseName: 'Making my first flutter app',
        amount: 123.00,
        colorName: Colors.cyan),
    PurchaseItem(
        purchaseName: 'No more hello world apps',
        amount: 53.00,
        colorName: Colors.amber),
    PurchaseItem(
        purchaseName: 'Good flutter app',
        amount: 81.00,
        colorName: Colors.deepOrange),
    DateItem('March 2, 2021'),
    PurchaseItem(
        purchaseName: 'Making my first flutter app',
        amount: 123.00,
        colorName: Colors.cyan),
    DateItem('March 1, 2021'),
    PurchaseItem(
        purchaseName: 'No more hello world apps',
        amount: 53.00,
        colorName: Colors.amber),
    PurchaseItem(
        purchaseName: 'Good flutter app',
        amount: 81.00,
        colorName: Colors.deepOrange),
  ];

  void getData() async {
    // simulate network request for a username
    String username = await Future.delayed(Duration(seconds: 3), () {
      return ('yoshi');
    });
    // simulate network request to get bio of the username
    String bio = await Future.delayed(Duration(seconds: 2), () {
      return ('vega, musician & egg collector');
    });
    print('$username - $bio');
  }

  // User services
  final UserDatabaseService _userService = UserDatabaseService();

  @override
  void initState() {
    super.initState();
    print('TransactionPage->initState() ran ');
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    print('TransactionPage->build() ran');
    getData();
    final user = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                'Month Spending Total',
                textAlign: TextAlign.left,
              ),
            ),
            Expanded(
              flex: 5,
              child: Text(
                '50000000.00',
                textAlign: TextAlign.right,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.lightBlue[900],
        child: Container(
          child: Icon(
            Icons.add,
            size: 40.0,
          ),
        ),
        onPressed: () async {
          dynamic customUserData = await _userService.getUser(user.uid);
          if (customUserData != null)
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => AccountsPage(customUserData)),
            );
        },
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: items.length,
          itemBuilder: (context, index) {
            ListItem item = items[index];
            return item.buildItem(context);
          },
        ),
      ),
    );
  }
}

/// The base class for the different types of items the list can contain.
abstract class ListItem {
  /// The title line to show in a list item.
  Widget buildItem(BuildContext context);

  /// The subtitle line, if any, to show in a list item.
  // Widget buildSubtitle(BuildContext context);
}

/// A ListItem that contains data to display a heading.
class DateItem implements ListItem {
  final String date;

  DateItem(this.date);

  Widget buildItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey[200],
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey[400],
          ),
          BoxShadow(
            color: Colors.grey[200],
            spreadRadius: -2.0,
            blurRadius: 2.0,
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              flex: 6,
              child: Text(
                date,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.values[8],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildSubtitle(BuildContext context) => null;
}

/// A ListItem that contains data to display a purchase.
class PurchaseItem implements ListItem {
  final String purchaseName;
  final double amount;
  Color colorName;

  PurchaseItem({this.purchaseName, this.amount, this.colorName});

  Widget buildItem(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1.0,
            color: Colors.grey[500],
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 15.0),
        child: Row(
          children: <Widget>[
            Expanded(
              child: Icon(
                Icons.circle,
                size: 15,
                color: colorName,
              ),
            ),
            SizedBox(
              width: 10,
            ),
            Expanded(
              flex: 8,
              child: Text(
                purchaseName,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
            Expanded(
              flex: 4,
              child: Text(
                amount.toStringAsFixed(2),
                textAlign: TextAlign.right,
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget buildSubtitle(BuildContext context) => Text(body);
}
