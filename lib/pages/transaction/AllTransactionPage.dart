import 'package:flutter/material.dart';
import 'list_item.dart';
import 'package:budget/pages/accounts/AccountPage.dart';

class AllTransactionPage extends StatefulWidget {
  @override
  _AllTransactionPageState createState() => _AllTransactionPageState();
}

class _AllTransactionPageState extends State<AllTransactionPage> {
  // Build list of items based on their types: date items and purchase items
// based on chronological order
// 2 types of ListItem: DateItem(String date) for the date category
//                      PurchaseItem(String name, Double amount, Color color)
// also get the sum of all spending this month
  List<ListItem> items = [
    DatedPurchaseItem(
      purchaseName: 'All Transaction Page',
      amount: 123.00,
      colorName: Colors.cyan,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'There should be no dates here',
      amount: 53.00,
      colorName: Colors.amber,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'Good flutter app',
      amount: 81.00,
      colorName: Colors.deepOrange,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'All Transaction Page',
      amount: 123.00,
      colorName: Colors.cyan,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'There should be no dates here',
      amount: 53.00,
      colorName: Colors.amber,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'Good flutter app',
      amount: 81.00,
      colorName: Colors.deepOrange,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'All Transaction Page',
      amount: 123.00,
      colorName: Colors.cyan,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'There should be no dates here',
      amount: 53.00,
      colorName: Colors.amber,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'Good flutter app',
      amount: 81.00,
      colorName: Colors.deepOrange,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'All Transaction Page',
      amount: 123.00,
      colorName: Colors.cyan,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'There should be no dates here',
      amount: 53.00,
      colorName: Colors.amber,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'Good flutter app',
      amount: 81.00,
      colorName: Colors.deepOrange,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'All Transaction Page',
      amount: 123.00,
      colorName: Colors.cyan,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'There should be no dates here',
      amount: 53.00,
      colorName: Colors.amber,
      date: 'March 9, 2021',
    ),
    DatedPurchaseItem(
      purchaseName: 'Good flutter app',
      amount: 81.00,
      colorName: Colors.deepOrange,
      date: 'March 9, 2021',
    ),
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

  @override
  void initState() {
    super.initState();
    print('AllTransactionPage->initState() ran ');
    // getData();
  }

  @override
  Widget build(BuildContext context) {
    print('TransactionPage->build() ran');
    getData();
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
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AccountsPage()),
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
