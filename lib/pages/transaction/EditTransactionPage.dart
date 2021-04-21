import 'package:budget/models/Account.dart';
import 'package:budget/models/Transaction.dart';
import 'package:budget/services/AccountDatabaseServices.dart';
import 'package:budget/services/TransactionDatabaseServices.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'NewTransactionPage.dart';

class EditTransactionPage extends StatefulWidget {
  final String transactionId;
  final String accountId;
  final String userId;
  final DateTime existingTime;
  final int type;

  EditTransactionPage(
      {this.transactionId,
      this.accountId,
      this.userId,
      this.existingTime,
      this.type});

  @override
  _EditTransactionPageState createState() => _EditTransactionPageState();
}

class _EditTransactionPageState extends State<EditTransactionPage> {
  final TransactionDatabaseServices _transactionService =
      TransactionDatabaseServices();
  final AccountDatabaseSerivces _accountService = AccountDatabaseSerivces();
  TextEditingController _dateEditingController;
  TextEditingController _timeEditingController;

  Account currentAccount;
  UserTransaction currentTransaction;
  List<Account> _accountList;

  TransactionType _type;
  int currentCategory = 0;
  DateTime _selectedDate;
  TimeOfDay _time;
  double _amount;

  final _formKey = GlobalKey<FormState>();

  Map<int, List> categories = {
    0: ['Groceries', Colors.red],
    1: ['Gas', Colors.purple],
    2: ['Work Lunches', Colors.blue],
    3: ['Take Outs', Colors.yellow],
  };

  // Find account from the list
  Account findAccount() {
    for (int i = 0; i < _accountList.length; i++) {
      if (_accountList[i].id == widget.accountId) {
        return _accountList[i];
      }
    }
    return null;
  }

  // Retrieve the accounts related to the user
  void getAccounts() async {
    dynamic result = await _accountService.getAccounts(widget.userId);
    if (result != null) {
      setState(() {
        _accountList = result;
        // Get the current account
        currentAccount = findAccount();
      });
    }
  }

  // Retrieve the current transaction
  void getTransaction() async {
    dynamic result =
        await _transactionService.getTransaction(widget.transactionId);
    if (result != null) {
      setState(() {
        currentTransaction = result;
      });
    }
  }

  // Category Dropdown Menu
  Container categoryDropdown() {
    // DropdownButton<int> dropdown() {
    DropdownButton<int> button = DropdownButton<int>(
      isExpanded: true,
      value: currentCategory,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(
        // color: Colors.red,
        // color: Colors.deepPurple,
        color: Colors.black,
      ),
      underline: SizedBox(), //(
      //   height: 1,
      //   color: Colors.grey[400],
      // ),
      onChanged: (int newValue) {
        setState(() {
          currentCategory = newValue;
        });
      },
      items: categories.keys.toList().map<DropdownMenuItem<int>>((int value) {
        return DropdownMenuItem<int>(
          value: value,
          child: Row(
            children: [
              SizedBox(
                width: 19.0,
              ),
              Icon(
                Icons.circle,
                size: 15.0,
                color: categories[value][1],
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(categories[value][0]),
            ],
          ),
        );
      }).toList(),
    );
    Container c = Container(
        child: button,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500],
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
    return c;
  }

  // Account Dropdown Menu
  Container accountDropdown() {
    // DropdownButton<int> dropdown() {
    DropdownButton<Account> button = DropdownButton<Account>(
      isExpanded: true,
      value: currentAccount,
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      style: const TextStyle(
        // color: Colors.red,
        // color: Colors.deepPurple,
        color: Colors.black,
      ),
      underline: SizedBox(), //(
      //   height: 1,
      //   color: Colors.grey[400],
      // ),
      onChanged: (Account newValue) {
        setState(() {
          currentAccount = newValue;
        });
      },
      items:
          _accountList.toList().map<DropdownMenuItem<Account>>((Account value) {
        return DropdownMenuItem<Account>(
          value: value,
          child: Row(
            children: [
              SizedBox(
                width: 19.0,
              ),
              Icon(
                Icons.circle,
                size: 15.0,
                color: Color(value.color),
              ),
              SizedBox(
                width: 10.0,
              ),
              Text(value.name),
            ],
          ),
        );
      }).toList(),
    );
    Container c = Container(
        child: button,
        height: 50.0,
        decoration: BoxDecoration(
          border: Border.all(
            color: Colors.grey[500],
            width: 1.0,
          ),
          borderRadius: BorderRadius.all(Radius.circular(5)),
        ));
    return c;
  }

  // Date selecter
  _selectDate(BuildContext context) async {
    DateTime newSelectedDate = await showDatePicker(
        context: context,
        initialDate: widget.existingTime,
        firstDate: DateTime(2000),
        lastDate: DateTime(2040),
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.light().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.lightBlue[900],
                onPrimary: Colors.lightBlue[400],
                surface: Colors.red,
                onSurface: Colors.lightBlue[900],
              ),
              dialogBackgroundColor: Colors.white,
            ),
            child: child,
          );
        });

    if (newSelectedDate != null) {
      _selectedDate = newSelectedDate;
      _dateEditingController
        ..text = DateFormat.yMMMd().format(_selectedDate)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _dateEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  // Time selecter

  _selectTime(BuildContext context) async {
    final TimeOfDay newTime = await showTimePicker(
        context: context,
        initialTime: _time,
        initialEntryMode: TimePickerEntryMode.input,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
              colorScheme: ColorScheme.light(
                primary: Colors.lightBlue[900],
                onPrimary: Colors.white,
                surface: Colors.white,
                onSurface: Colors.lightBlue[900],
              ),
              dialogBackgroundColor: Colors.blue[500],
            ),
            child: child,
          );
        });
    if (newTime != null) {
      _time = newTime;
      _timeEditingController
        ..text = formatTimeOfDay(_time)
        ..selection = TextSelection.fromPosition(TextPosition(
            offset: _timeEditingController.text.length,
            affinity: TextAffinity.upstream));
    }
  }

  String formatTimeOfDay(TimeOfDay tod) {
    final now = new DateTime.now();
    final dt = DateTime(now.year, now.month, now.day, tod.hour, tod.minute);
    final format = DateFormat.jm(); //"6:00 AM"
    return format.format(dt);
  }

  // Combine Date and Time
  setupDatetime() {
    _dateEditingController = TextEditingController();
    _selectedDate = widget.existingTime;
    _dateEditingController
      ..text = DateFormat.yMMMd().format(_selectedDate)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: _dateEditingController.text.length,
          affinity: TextAffinity.upstream));

    _timeEditingController = TextEditingController();
    _time = TimeOfDay(
        hour: widget.existingTime.hour, minute: widget.existingTime.minute);

    _timeEditingController
      ..text = formatTimeOfDay(_time)
      ..selection = TextSelection.fromPosition(TextPosition(
          offset: _timeEditingController.text.length,
          affinity: TextAffinity.upstream));
  }

  validate(String value) {
    if (value.isEmpty) {
      return 'Please enter some thing';
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback((_) => getAccounts());
    SchedulerBinding.instance.addPostFrameCallback((_) => getTransaction());
    setupDatetime();
    setState(() {
      _type =
          widget.type == 0 ? TransactionType.expense : TransactionType.income;
    });
    // currentAccount = findAccount();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Row(
          children: [
            Expanded(
              flex: 16,
              child: Text(
                'Edit Transaction',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              flex: 3,
              child: Container(),
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SizedBox(height: 10.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      // Radio button for expense
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Radio<TransactionType>(
                                value: TransactionType.expense,
                                groupValue: _type,
                                onChanged: (TransactionType value) {
                                  setState(() {
                                    _type = value;
                                  });
                                },
                              ),
                              Text("Expense")
                            ],
                          ),
                        ),
                      ),
                      // Radio button for income
                      Expanded(
                        flex: 1,
                        child: Container(
                          child: Row(
                            children: <Widget>[
                              Radio<TransactionType>(
                                value: TransactionType.income,
                                groupValue: _type,
                                onChanged: (TransactionType value) {
                                  setState(() {
                                    _type = value;
                                  });
                                },
                              ),
                              Text("Income")
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: categoryDropdown(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          flex: 7,
                          child: accountDropdown(),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                      height: 80.0,
                      child: TextFormField(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.shopping_bag_outlined),
                            // hintText: 'Purchase',
                            border: OutlineInputBorder(),
                            labelText: 'Note',
                          ),
                          initialValue: currentTransaction.note,
                          textInputAction: TextInputAction.next,
                          validator: (value) => validate(value),
                          onChanged: (value) {
                            setState(() {
                              currentTransaction.note = value;
                            });
                          }),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                      height: 80.0,
                      child: TextFormField(
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.attach_money,
                          ),
                          border: OutlineInputBorder(),
                          labelText: 'Amount',
                        ),
                        initialValue: currentTransaction.amount.toString(),
                        validator: (value) {
                          try {
                            double val = double.parse(value);
                            assert(val is double);
                            setState(() {
                              _amount = val;
                            });
                          } on FormatException catch (e) {
                            print(e);
                            return "Must enter a number";
                          }
                          return null;
                        },
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: _dateEditingController,
                            decoration: InputDecoration(
                              // hintText: DateFormat('MM-dd-yyyy')
                              //     .format(_selectedDate),
                              border: OutlineInputBorder(),
                              labelText: 'Date',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            readOnly: true,
                            onTap: () {
                              _selectDate(context);
                            },
                          ),
                        ),
                        SizedBox(width: 10.0),
                        Expanded(
                          child: TextField(
                            controller: _timeEditingController,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(),
                              labelText: 'Time',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            readOnly: true,
                            onTap: () {
                              _selectTime(context);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: Text('Cancel'),
                        ),
                        SizedBox(
                          width: 30.0,
                        ),
                        ElevatedButton(
                          onPressed: () async {
                            // Validate returns true if the form is valid, or false
                            // otherwise.
                            if (_formKey.currentState.validate()) {
                              // If the form is valid, display a Snackbar.
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(content: Text('Processing Data')));

                              // If the current transaction was an expense,
                              // add money to it
                              // If it is an income, take money out of the account
                              // *DOING OPPOSITE
                              await _accountService.editAccount(
                                  widget.accountId,
                                  currentTransaction.amount,
                                  currentTransaction.type == 0
                                      ? TransactionType.income
                                      : TransactionType.expense);

                              await _transactionService.editTransaction(
                                widget.transactionId,
                                _type,
                                categories[currentCategory][0],
                                currentTransaction.note,
                                _amount,
                                _selectedDate,
                                _time,
                              );

                              // Make sure the account do correctly
                              await _accountService.editAccount(
                                  widget.accountId, _amount, _type);

                              Navigator.pop(context);
                            }
                          },
                          child: Text('Submit'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
