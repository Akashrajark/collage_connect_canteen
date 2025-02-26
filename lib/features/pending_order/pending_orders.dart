import 'package:college_connect_canteen/common_widget/custom_action_button.dart';
import 'package:college_connect_canteen/features/pending_order/order_items.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class PendingOrders extends StatelessWidget {
  const PendingOrders({super.key});

  @override
  Widget build(BuildContext context) {
    return OrderScreen(
      title: 'Pending Orders',
      status: 'Pending',
      statusColor: Colors.yellow,
      showDeliveryColumn: true,
    );
  }
}

class OrderScreen extends StatelessWidget {
  final String title;
  final String status;
  final Color statusColor;
  final bool showDeliveryColumn;

  const OrderScreen({
    super.key,
    required this.title,
    required this.status,
    required this.statusColor,
    required this.showDeliveryColumn,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        elevation: 4,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: OrdersTable(
                  status: status,
                  statusColor: statusColor,
                  showDeliveryColumn: showDeliveryColumn,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class OrdersTable extends StatelessWidget {
  final String status;
  final Color statusColor;
  final bool showDeliveryColumn;

  const OrdersTable({
    super.key,
    required this.status,
    required this.statusColor,
    required this.showDeliveryColumn,
  });

  @override
  Widget build(BuildContext context) {
    return DataTable2(
      columnSpacing: 12,
      horizontalMargin: 12,
      minWidth: 600,
      columns: [
        const DataColumn2(label: Text('Order Id'), size: ColumnSize.L),
        const DataColumn(label: Text('Student Name')),
        const DataColumn(label: Text('Price')),
        const DataColumn(label: Text('Status')),
        const DataColumn(label: Text('Ordered Items')),
        if (showDeliveryColumn) // Conditionally show Delivery Column
          const DataColumn2(
            label: Text('Delivery'),
            size: ColumnSize.S,
            numeric: true,
          ),
      ],
      rows: [
        DataRow(cells: [
          const DataCell(Text('#4665')),
          const DataCell(Text('Abishek')),
          const DataCell(Text('545')),
          DataCell(StatusCard(color: statusColor, title: status)),
          DataCell(TextButton(
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => OrderedItems(),
                );
              },
              child: const Text('View'))),
          if (showDeliveryColumn)
            DataCell(CustomActionbutton(
              ontap: () {},
              title: 'Completed',
              icon: Icons.chevron_right,
              color: Colors.green,
            )),
        ]),
        DataRow(cells: [
          const DataCell(Text('#4501')),
          const DataCell(Text('Aromal')),
          const DataCell(Text('465')),
          DataCell(StatusCard(color: statusColor, title: status)),
          DataCell(TextButton(onPressed: () {}, child: const Text('View'))),
          if (showDeliveryColumn)
            DataCell(CustomActionbutton(
              ontap: () {},
              title: 'Completed',
              icon: Icons.chevron_right,
              color: Colors.green,
            )),
        ]),
      ],
    );
  }
}

class StatusCard extends StatelessWidget {
  final Color color;
  final String title;

  const StatusCard({
    super.key,
    required this.color,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.circular(10),
      color: color,
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Text(
          title,
          style: const TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
