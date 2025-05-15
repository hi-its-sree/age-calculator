import 'package:flutter/material.dart';
import 'OrderCompleted.dart';
import 'OrdersActive.dart';
import 'OrdersCancelled.dart';
class OrdersTabs extends StatefulWidget {
  const OrdersTabs({super.key});

  @override
  State<OrdersTabs> createState() => _OrdersTabsState();
}

class _OrdersTabsState extends State<OrdersTabs> with SingleTickerProviderStateMixin {

  late TabController tabController;

  @override
  void initState()
  {
    super.initState();
    tabController = TabController(length: 3,
        vsync: this,
        animationDuration: const Duration(milliseconds: 600));
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

        title:Text(
          "Ride Schedules",
          style: TextStyle(fontSize: 19, fontWeight: FontWeight.w500),
        ),
        bottom: TabBar(
            indicatorColor:Colors.black,
            indicatorAnimation: TabIndicatorAnimation.linear,
            automaticIndicatorColorAdjustment: true,
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
              Tab( text: "Active"),
              Tab( text: "Completed"),
              Tab( text: "Cancelled")
            ]),
      ),
      body: TabBarView(
          controller: tabController,
          children: [
            OrdersActive(status: 'active',),
            OrdersCompleted(),
            OrdersCancelled()

          ]),

    );
  }
}
