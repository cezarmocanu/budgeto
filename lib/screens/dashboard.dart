import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/dashboard-tabs/expenses-tab.dart';
import 'package:budgeto_flutter/dashboard-tabs/profile-tab.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:budgeto_flutter/dashboard-tabs/goals-tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
  static const APPBAR_HEIGHT = 64.0;
  static const TABBAR_HEIGHT = 32.0;
  static const TABBAR_PADDING = 4.0;

  @override
  Widget build(BuildContext context) {
    LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    List<Tab> _tabs = <Tab>[
      Tab(
        child: Container(
          width: 100,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              t(LabelsEnum.goals, intl),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Tab(
        child: Container(
          width: 100,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              t(LabelsEnum.expenses, intl),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
      Tab(
        child: Container(
          width: 100,
          height: 38,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
          ),
          child: Align(
            alignment: Alignment.center,
            child: Text(
              t(LabelsEnum.profile, intl),
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      )
    ];

    return Consumer<AppModel>(
      builder: (context, app, child) => DefaultTabController(
        length: _tabs.length,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            toolbarHeight: TABBAR_HEIGHT + 2 * TABBAR_PADDING + APPBAR_HEIGHT,
            // centerTitle: false,
            backgroundColor: Colors.white10,
            title: Container(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          "Current budget",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text("${app.income - app.expended} / ${app.income} \$"),
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          "For the next",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        Text("6 days"),
                      ],
                    )
                  ],
                ),
              ),
              color: Colors.pinkAccent,
              width: double.infinity,
              height: APPBAR_HEIGHT,
            ),
            titleSpacing: 0,
            bottom: PreferredSize(
              preferredSize:
                  Size(double.infinity, TABBAR_HEIGHT + 2 * TABBAR_PADDING),
              child: Container(
                // color: Colors.whi,
                height: TABBAR_HEIGHT + 2 * TABBAR_PADDING,
                width: double.infinity,
                child: Padding(
                  padding: EdgeInsets.only(
                      top: TABBAR_PADDING, bottom: TABBAR_PADDING),
                  child: TabBar(
                    isScrollable: true,
                    indicatorPadding: EdgeInsets.zero,
                    indicator: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                        border: Border.all(width: 1, color: Colors.pinkAccent)),
                    indicatorSize: TabBarIndicatorSize.label,
                    labelColor: Colors.black,
                    unselectedLabelColor: Colors.black54,
                    tabs: _tabs,
                  ),
                ),
              ),
            ),
          ),
          body: TabBarView(
            children: [
              GoalsTab(),
              ExpensesTab(),
              ProfileTab(),
            ],
          ),
        ),
      ),
    );
  }
}
