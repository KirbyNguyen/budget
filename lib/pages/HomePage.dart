import 'package:flutter/material.dart';
import 'package:budget/models/AppFlow.dart';

Widget buildPage(AppFlow appFlow) => Navigator(
      key: appFlow.navigatorKey,
      onGenerateRoute: (settings) => MaterialPageRoute(
        settings: settings,
        builder: (context) => appFlow.page,
      ),
    );

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // Current index for the pages
  int _currentBarIndex = 0;
  @override
  Widget build(BuildContext context) {
    final currentFlow = appFlows[_currentBarIndex];
    // We're preventing the root navigator from popping and closing the app
    // when the back button is pressed and the inner navigator can handle it.
    // That occurs when the inner has more than one page on its stack.
    // You can comment the onWillPop callback and watch "the bug".
    return WillPopScope(
      onWillPop: () async =>
          !await currentFlow.navigatorKey.currentState.maybePop(),
      child: Scaffold(
        // Remebering the state of each page
        body: IndexedStack(
          index: _currentBarIndex,
          children: appFlows.map(buildPage).toList(),
        ),
        // A bottom tab bar with orange background, white icon, and black icon
        bottomNavigationBar: BottomNavigationBar(
          // Colors changed based on choice
          currentIndex: _currentBarIndex,
          // Mapp the pages to the bottom bar
          items: appFlows
              .map(
                (flow) => BottomNavigationBarItem(
                  label: flow.title,
                  icon: Icon(flow.iconData),
                ),
              )
              .toList(),
          // Navigate to a new page
          onTap: (newIndex) => setState(
            () {
              if (_currentBarIndex != newIndex) {
                _currentBarIndex = newIndex;
              } else {
                // If the user is re-selecting the tab, the common
                // behavior is to empty the stack.
                currentFlow.navigatorKey.currentState
                    .popUntil((route) => route.isFirst);
              }
            },
          ),
        ),
      ),
    );
  }
}
