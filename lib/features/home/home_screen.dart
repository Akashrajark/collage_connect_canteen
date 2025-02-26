import 'package:college_connect_canteen/features/delivered_orders/delivered_orders.dart';
import 'package:college_connect_canteen/features/dashboard/dashboard_screen.dart';
import 'package:college_connect_canteen/features/pending_order/pending_orders.dart';
import 'package:college_connect_canteen/features/product_screen/product_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 4, vsync: this);
    _tabController.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[100],
      body: Row(
        children: [
          Container(
              width: 235,
              color: Colors.purple,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 40,
                      ),
                      const Column(
                        children: [
                          Text(
                            'College connect',
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          Text(
                            'Canteen',
                            style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.normal,
                                color: Colors.white),
                          ),
                        ],
                      ),
                      const SizedBox(height: 90),
                      DrawerItem(
                        isActive: _tabController.index == 0,
                        iconData: Icons.dashboard_rounded,
                        label: 'Dashboard',
                        onTap: () {
                          _tabController.animateTo(0);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DrawerItem(
                        isActive: _tabController.index == 1,
                        iconData: Icons.fastfood_outlined,
                        label: 'Products',
                        onTap: () {
                          _tabController.animateTo(1);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DrawerItem(
                        isActive: _tabController.index == 2,
                        iconData: Icons.pending_actions_outlined,
                        label: 'Pending Orders',
                        onTap: () {
                          _tabController.animateTo(2);
                        },
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      DrawerItem(
                        isActive: _tabController.index == 3,
                        iconData: Icons.check_circle_outline_outlined,
                        label: 'Delivered Orders',
                        onTap: () {
                          _tabController.animateTo(3);
                        },
                      ),
                    ]),
              )),
          Expanded(
            child: TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              controller: _tabController,
              children: const [
                DashboardScreen(),
                ProductScreen(),
                PendingOrders(),
                DeliveredOrders()
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class DrawerItem extends StatelessWidget {
  final IconData iconData;
  final String label;
  final Function() onTap;
  final bool isActive;
  const DrawerItem({
    super.key,
    required this.iconData,
    required this.label,
    required this.onTap,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: isActive ? Colors.white : Colors.purpleAccent,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 10),
          child: Row(
            children: [
              Icon(iconData, color: isActive ? Colors.black : Colors.white),
              SizedBox(
                width: 10,
              ),
              Text(label.toUpperCase(),
                  style:
                      TextStyle(color: isActive ? Colors.black : Colors.white))
            ],
          ),
        ),
      ),
    );
  }
}
