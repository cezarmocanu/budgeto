import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/dashboard-tabs/profile-tab.dart';
import 'package:budgeto_flutter/strings/strings.dart';
import 'package:budgeto_flutter/dashboard-tabs/goals-tab.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Dashboard extends StatelessWidget {
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

    return DefaultTabController(
      length: _tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 58,
          backgroundColor: Colors.white10,
          bottom: PreferredSize(
            preferredSize: Size(0, 0),
            child: Container(
              height: 38,
              child: Padding(
                padding: EdgeInsets.all(2),
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
        body: TabBarView(children: [
          GoalsTab(),
          Text("Welcome to expenses page"),
          ProfileTab(),
        ]),
      ),
    );
  }
}
