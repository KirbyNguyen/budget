import 'package:budget/services/CategoryServices.dart';
import 'package:flutter/material.dart';
// import '../transaction/list_item.dart';

class AddNewCategoryPage extends StatefulWidget {
  @override
  _AddNewCategoryPageState createState() => _AddNewCategoryPageState();
}

class _AddNewCategoryPageState extends State<AddNewCategoryPage> {
  CategoryServices _category = CategoryServices();
  String catName;
  double catBudget = 0;
  Color catColor;
  final _formKey = GlobalKey<FormState>();
  final List<Color> _defaultColors = [
    Colors.red,
    Colors.pink,
    Colors.purple,
    Colors.deepPurple,
    Colors.indigo,
    Colors.blue,
    Colors.lightBlue,
    Colors.cyan,
    Colors.teal,
    Colors.green,
    // Colors.lightGreen,
    // Colors.lime,
    // Colors.yellow,
    // Colors.amber,
    // Colors.orange,
    // Colors.deepOrange,
    // Colors.brown,
    // Colors.grey,
    // Colors.blueGrey,
    // Colors.black,
  ];
  Color _color;

  validate(String value) {
    if (value.isEmpty) {
      return 'Please enter some thing';
    }
    return null;
  }

  AlertDialog getColorPicker(BuildContext _) {
    return AlertDialog(
      title: Text('hello'),
    );
  }

  Future<void> _openDialog() async {
    Color newColor = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: const Text("Select a Color"),
            children: _defaultColors
                .map(
                  (color) => SimpleDialogOption(
                    child: Icon(
                      Icons.circle,
                      color: color,
                    ),
                    onPressed: () {
                      Navigator.pop(context, color);
                      catColor = color;
                    },
                  ),
                )
                .toList(),
          );
        });
    setState(() {
      _color = newColor;
    });
  }

  @override
  void initState() {
    super.initState();
    _color = _defaultColors[0];
    print('NewTransactionPage->initState() ran ');
  }

  @override
  Widget build(BuildContext context) {
    print('AddNewCategoryPage->build() ran');
    // getData();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.lightBlue[900],
        title: Row(
          children: [
            Expanded(
              flex: 8,
              child: Text(
                'Add New Category',
                textAlign: TextAlign.center,
              ),
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 20.0),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 16.0,
                    ),
                    child: SizedBox(
                      height: 80.0,
                      child: TextFormField(
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.category),
                          // hintText: 'Purchase',
                          border: OutlineInputBorder(),
                          labelText: 'New Category',
                        ),
                        onChanged: (value) {
                          setState(() {
                            catName = value;
                          });
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) => validate(value),
                      ),
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
                          labelText: 'Budget Amount',
                        ),
                        onChanged: (value) {
                          setState(() {
                            catBudget = double.parse(value);
                          });
                        },
                        textInputAction: TextInputAction.next,
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
                          flex: 8,
                          child: Container(),
                        ),
                        Expanded(
                          flex: 3,
                          child: TextField(
                            // controller: _dateEditingController,
                            decoration: InputDecoration(
                              // hintText: DateFormat('MM-dd-yyyy')
                              //     .format(_selectedDate),
                              prefixIcon: Icon(
                                Icons.circle,
                                color: _color,
                              ),
                              border: OutlineInputBorder(),
                              labelText: 'Color',
                              suffixIcon: Icon(
                                Icons.arrow_drop_down,
                              ),
                            ),
                            textInputAction: TextInputAction.next,
                            readOnly: true,
                            onTap: () {
                              print("working");
                              _openDialog();
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
                            // Navigator.pop(context);
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
                              await _category.addCategory(
                                  catName, catBudget, catColor.value);
                              print("working");
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

class ColorPicker extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text('hello'),
    );
  }
}
