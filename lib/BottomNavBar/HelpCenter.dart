import 'package:flutter/material.dart';
import 'package:rentzy/BottomNavBar/ContactUs.dart';
import 'package:rentzy/BottomNavBar/Languages.dart';

import 'FAQ.dart';
class HelpCenterPage extends StatefulWidget {
  const HelpCenterPage({super.key});

  @override
  State<HelpCenterPage> createState() => _HelpCenterPageState();
}

class _HelpCenterPageState extends State<HelpCenterPage> with SingleTickerProviderStateMixin {

  late TabController tabController;
  @override
  void initState() {
    super.initState();
    tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {

    var mediaQueryData = MediaQuery.of(context);
    var screenHeight = mediaQueryData.size.height;
    var screenWidth = mediaQueryData.size.width;

    return Scaffold(
      backgroundColor: Colors.grey.shade300,

      appBar: AppBar(
        leading:GestureDetector(
          onTap: ()
          {
            Navigator.pop(context);
          },
          child: Icon(
            Icons.arrow_back,
            size: 23,
            color: Colors.black,
          ),
        ),
        title:Text(
          "Help Center",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
        bottom: TabBar(
            indicatorColor:Colors.black,
            indicatorAnimation: TabIndicatorAnimation.elastic,
            indicatorSize: TabBarIndicatorSize.tab,
            indicatorWeight:2.5,
            labelColor: Colors.black,
            splashFactory: InkSparkle.splashFactory,
            labelStyle: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 16.5,
              color: Colors.black
            ),
            unselectedLabelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: 15,
                color: Colors.grey
            ),
            unselectedLabelColor: Colors.grey,
            controller: tabController,
            tabs: [
              Tab( text: "FAQ"),
              Tab( text: "Contact Us")
            ]),
      ),
      body: TabBarView(
        controller: tabController,
          children: [
            FAQPage(),
            ContactUs(),
          ]),





    );
  }
}
