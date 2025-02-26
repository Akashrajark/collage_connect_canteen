import 'package:college_connect_canteen/features/pending_order/pending_orders.dart';
import 'package:flutter/material.dart';

class DeliveredOrders extends StatelessWidget {
  const DeliveredOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderScreen(
      title: 'Delivered Orders',
      status: 'Delivered',
      statusColor: Colors.green,
      showDeliveryColumn: false,
    );
  }
}
