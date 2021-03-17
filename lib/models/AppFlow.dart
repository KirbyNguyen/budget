import 'package:budget/pages/budget/BudgetPage.dart';
import 'package:budget/pages/menu/MenuPage.dart';
import 'package:budget/pages/transaction/TransactionPage.dart';
import 'package:budget/pages/category/AddNewCategoryPage.dart';
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
    iconData: Icons.account_balance,
    page: TransactionPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
  AppFlow(
    title: 'Budget',
    iconData: Icons.assessment,
    page: BudgetPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
  AppFlow(
    title: 'Add Category',
    iconData: Icons.category,
    page: AddNewCategoryPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
  AppFlow(
    title: 'Menu',
    iconData: Icons.settings,
    page: MenuPage(),
    navigatorKey: GlobalKey<NavigatorState>(),
  ),
];
