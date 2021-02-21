import 'package:budget/pages/budget/BudgetPage.dart';
import 'package:budget/pages/menu/MenuPage.dart';
import 'package:budget/pages/transaction/TransactionPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

/// Hold information about our app's flows.
class AppFlow {
  const AppFlow({
    @required this.title,
    @required this.iconData,
    @required this.page,
    @required this.navigatorKey,
  })  : assert(title != null),
        assert(iconData != null),
        assert(page != null),
        assert(navigatorKey != null);

  final String title;
  final IconData iconData;
  final Widget page;
  final GlobalKey<NavigatorState> navigatorKey;
}

final List<AppFlow> appFlows = [
  AppFlow(
    title: 'Home',
    iconData: Icons.money,
    page: TransactionPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
  AppFlow(
    title: 'Budget',
    iconData: Icons.money,
    page: BudgetPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
  AppFlow(
    title: 'Menu',
    iconData: Icons.more,
    page: MenuPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
];
