import 'package:credit_card_app/screens/countries_removal_widget.dart';
import 'package:credit_card_app/screens/countries_restoration_widget.dart';
import 'package:credit_card_app/screens/credit_card_widget.dart';
import 'package:credit_card_app/utilities.dart';
import 'package:flutter/material.dart';

class HomeWidget extends StatefulWidget {
  HomeWidget();

  @override
  State<StatefulWidget> createState() => HomeWidgetState();
}

class HomeWidgetState extends State<HomeWidget>
    with SingleTickerProviderStateMixin {
  List<String> titles = [
    'Admin',
    'Country In',
    'Country Out',
  ];
  int currentIndex = 0;

  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void updateCurrentIndex(int index) {
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Utilities.backgroundColor,
          title: Text(
            titles[currentIndex],
            style: TextStyle(
              fontSize: 14,
              color: Utilities.color3,
              fontWeight: FontWeight.bold,
            ),
          ),
          elevation: 0,
          centerTitle: true,
          bottom: TabBar(
            onTap: updateCurrentIndex,
            labelColor: Utilities.color3,
            controller: _tabController,
            indicatorColor: Utilities.color3,
            indicatorWeight: 5,
            //dividerHeight: 0,
            indicatorPadding: const EdgeInsets.only(bottom: 8),
            tabs: [
              Tab(
                icon: Icon(Icons.home, color: Utilities.color1),
                text: 'Home',
              ),
              Tab(
                icon: Icon(Icons.delete, color: Utilities.color1),
                text: 'Recycle',
              ),
              Tab(
                icon: Icon(Icons.restore, color: Utilities.color1),
                text: 'Restore',
              ),
            ],
          ),
        ),
        body: SafeArea(
          child: Container(
            decoration: BoxDecoration(
              color: Utilities.backgroundColor,
            ),
            child: TabBarView(controller: _tabController, children: [
              CreditCardWidget(),
              CountriesRemovalWidget(),
              CountriesRestorationWidget()
            ]),
          ),
        ),
      );
}
