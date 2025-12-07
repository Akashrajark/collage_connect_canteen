import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final supabaseClient = Supabase.instance.client;
    final userId = supabaseClient.auth.currentUser!.id;

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Wrap(
            spacing: 20,
            runSpacing: 20,
            children: [
              FutureBuilder(
                  future: supabaseClient.from('canteen_products').count().eq('shop_user_id', userId),
                  builder: (context, asyncSnapshot) {
                    return DashboardItem(
                      isLoading: asyncSnapshot.connectionState == ConnectionState.waiting,
                      count: asyncSnapshot.hasData ? asyncSnapshot.data!.toString() : '0',
                      label: 'Products',
                      color: const Color(0xFFFFE4BC),
                    );
                  }),
              FutureBuilder(
                  future: supabaseClient.from('orders').count().eq('shop_user_id', userId).eq('status', 'pending'),
                  builder: (context, asyncSnapshot) {
                    return DashboardItem(
                      isLoading: asyncSnapshot.connectionState == ConnectionState.waiting,
                      count: asyncSnapshot.hasData ? asyncSnapshot.data!.toString() : '0',
                      label: 'Pending Orders',
                      color: const Color(0xFFF8BAB9),
                    );
                  }),
              FutureBuilder(
                  future: supabaseClient.from('orders').count().eq('shop_user_id', userId).eq('status', 'complete'),
                  builder: (context, asyncSnapshot) {
                    return DashboardItem(
                      isLoading: asyncSnapshot.connectionState == ConnectionState.waiting,
                      count: asyncSnapshot.hasData ? asyncSnapshot.data!.toString() : '0',
                      label: 'Completed Orders',
                      color: const Color(0xFFC9E4FF),
                    );
                  }),
            ],
          )
        ],
      ),
    );
  }
}

class DashboardItem extends StatelessWidget {
  final String count;
  final String label;
  final Color color;
  final bool isLoading;
  const DashboardItem({
    super.key,
    required this.count,
    required this.label,
    required this.color,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.white, // Background color
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            radius: 20,
            backgroundColor: color,
            child: isLoading
                ? const CircularProgressIndicator()
                : Text(
                    count,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                      color: Colors.black, // Black text inside circle
                    ),
                  ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black, // White text
            ),
          ),
        ],
      ),
    );
  }
}
