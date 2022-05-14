import 'package:flutter/material.dart';
import 'package:shop_app/services/firebase_servies.dart';
import 'package:shop_app/tabs/home_tab.dart';
import 'package:shop_app/tabs/liked_tab.dart';
import 'package:shop_app/tabs/search_tab.dart';
import 'package:shop_app/widgets/bottom_tabs.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  FirebaseServices _firebaseServices = FirebaseServices();
  PageController _tabsPageController;
  int _selectedTab = 0;
  @override
  void initState() {
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: PageView(
              controller: _tabsPageController,
              onPageChanged: (num) {
                setState(() {
                  _selectedTab = num;
                });
              },
              children: [
                HomeTab(),
                SearchTab(),
                LikedTab(),
              ],
            ),
          ),
          BottomTabs(
            selectedTab: _selectedTab,
            tabPressed: (num) {
              setState(
                () {
                  _tabsPageController.animateToPage(
                    num,
                    duration: Duration(milliseconds: 300),
                    curve: Curves.easeOutCubic,
                  );
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
