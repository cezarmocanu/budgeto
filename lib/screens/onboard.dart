import 'package:budgeto_flutter/change-notifiers/app-model.dart';
import 'package:budgeto_flutter/constants/routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Onboard extends StatefulWidget {
  @override
  _OnboardState createState() => _OnboardState();
}

class _OnboardState extends State<Onboard> with TickerProviderStateMixin {
  late final TabController _tabController = TabController(
    length: 3,
    vsync: this,
  );

  late final List<_OnboardTab> _tabs;
  late int currentTabIndex;

  @override
  void initState() {
    super.initState();
    _tabs = [
      _OnboardTab(
        content: "Welcome to Budgeto",
        color: Colors.pinkAccent,
      ),
      _OnboardTab(
        content: "Learn to manage your money in a SMART way",
        color: Colors.blueAccent,
      ),
      _OnboardTab(
        content: "Track your goals and update your strategies",
        color: Colors.amberAccent,
      ),
    ];

    setState(() {
      currentTabIndex = 0;
    });

    _tabController.addListener(() {
      setState(() {
        currentTabIndex = _tabController.index;
      });
    });
  }

  @override
  void dispose() {
    super.dispose();
    _tabController.dispose();
  }

  void _handleNext() {
    switch (_tabController.index) {
      case 0:
        _tabController.animateTo(_tabController.index + 1);
        return;
      case 1:
        _tabController.animateTo(_tabController.index + 1);
        return;
      case 2:
        goTo(context, RoutesEnum.Dashboard);
        return;
      default:
        break;
    }
  }

  void _handlePrev() {
    switch (_tabController.index) {
      case 1:
        _tabController.animateTo(_tabController.index - 1);
        return;
      case 2:
        _tabController.animateTo(_tabController.index - 1);
        return;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    // LanguageEnum intl = Provider.of<AppModel>(context, listen: true).intl;
    return Consumer<AppModel>(
      builder: (context, app, child) => Scaffold(
        body: Column(
          children: [
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: _tabs,
              ),
            ),
            _OnboardNavigationBar(
              handleNext: _handleNext,
              handlePrev: _handlePrev,
              tabsCount: _tabs.length,
              currentIndex: currentTabIndex,
            ),
          ],
        ),
      ),
    );
  }
}

class _OnboardTab extends StatelessWidget {
  const _OnboardTab({
    Key? key,
    required this.content,
    required this.color,
  }) : super(key: key);

  final String content;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          Expanded(
            child: Container(
              width: double.infinity,
              color: color,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Text(
                      content,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _OnboardNavigationBar extends StatelessWidget {
  _OnboardNavigationBar({
    Key? key,
    this.handlePrev,
    this.handleNext,
    required this.tabsCount,
    required this.currentIndex,
  }) : super(key: key);

  final Function()? handlePrev;
  final Function()? handleNext;
  final int tabsCount;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.white10,
      height: 64,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          if (handlePrev != null)
            ElevatedButton(
              onPressed: handlePrev,
              child: Text(
                "Previous",
              ),
            ),
          Container(
            height: 25,
            width: 25.0 * tabsCount,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                for (int i = 0; i < tabsCount; i++)
                  Container(
                      width: 10,
                      height: 10,
                      child: null,
                      decoration: BoxDecoration(
                        color: currentIndex == i
                            ? Colors.pinkAccent
                            : Colors.black12,
                        shape: BoxShape.circle,
                      ))
              ],
            ),
          ),
          if (handleNext != null)
            ElevatedButton(
              onPressed: handleNext,
              child: Text(
                "Next",
              ),
              style: ElevatedButton.styleFrom(
                primary: Colors.pinkAccent,
              ),
            ),
        ],
      ),
    );
  }
}
