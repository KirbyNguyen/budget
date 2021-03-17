import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CreateTransaction extends StatefulWidget {
  @override
  _CreateTransactionState createState() => _CreateTransactionState();
}

class _CreateTransactionState extends State<CreateTransaction> {
  String categoryName;
  String amount;
  final dateController = TextEditingController();
  final timeController = TextEditingController();
  DateTime date;
  TimeOfDay time;

  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed
    dateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Getting user's id
    final user = Provider.of<User>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Create transaction"),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            SizedBox(height: 5.0),
            Text("Category Name"),
            SizedBox(height: 5.0),
            TextFormField(
              onChanged: (value) => setState(() {
                categoryName = value;
              }),
            ),
            SizedBox(height: 5.0),
            Text("Amount"),
            SizedBox(height: 5.0),
            TextFormField(
              onChanged: (value) => setState(() {
                amount = value;
              }),
            ),
            SizedBox(height: 5.0),
            Text("Date"),
            SizedBox(height: 5.0),
            TextFormField(
              readOnly: true,
              controller: dateController,
              onTap: () async {
                var tempDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1990),
                  lastDate: DateTime(2100),
                );
                dateController.text = tempDate.toString().substring(0, 10);
                setState(() {
                  date = tempDate;
                });
              },
            ),
            SizedBox(height: 5.0),
            Text("Time"),
            SizedBox(height: 5.0),
            TextFormField(
              readOnly: true,
              controller: timeController,
              onTap: () async {
                var tempTime = await showTimePicker(
                  context: context,
                  initialTime: TimeOfDay.now(),
                );
                timeController.text = tempTime.toString().substring(10, 15);
                setState(() {
                  time = tempTime;
                });
              },
            ),
            SizedBox(height: 5.0),
            ElevatedButton(
              onPressed: () async {
                await _transactionService.setTransaction(
                  user.uid,
                  categoryName,
                  double.parse(amount),
                  date,
                  time,
                );
                Navigator.pop(context);
              },
              child: Text("Submit"),
            ),
          ],
        ),
      ),
    );
  }
}
