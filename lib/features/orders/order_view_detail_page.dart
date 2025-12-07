import 'package:flutter/material.dart';

class OrderDetailsPage extends StatelessWidget {
  final Map orderDetails;
  const OrderDetailsPage({super.key, required this.orderDetails});

  @override
  Widget build(BuildContext context) {
    // Helper to get status color based on status string
    Color getStatusColor(String? status) {
      if (status == null) return Colors.grey;
      switch (status.toLowerCase()) {
        case 'pending':
          return Colors.orange;
        case 'completed':
        case 'delivered':
          return Colors.green;
        case 'cancelled':
          return Colors.red;
        case 'cooking':
        case 'processing':
          return Colors.blue;
        default:
          return Colors.grey.shade700;
      }
    }

    final String status = orderDetails['status']?.toString() ?? 'Unknown';
    final Color statusColor = getStatusColor(status);
    final student = orderDetails['students'] ?? {};
    final String studentName = student['name'] ?? 'Unknown Student';
    final String? studentImage = student['image_url'];
    final List items = orderDetails['order_items'] ?? [];

    final primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      backgroundColor: Colors.grey[50], // Keeping neutral background for clean look
      appBar: AppBar(
        title: const Text(
          'Order Details',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        centerTitle: true,
        backgroundColor: Colors.white,
        elevation: 0,
        scrolledUnderElevation: 2,
        surfaceTintColor: Colors.transparent,
      ),
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 800),
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Header Section: Order Status & Student Info
                Container(
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(24),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.04),
                        blurRadius: 20,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(3),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: Colors.grey[100]!, width: 2),
                            ),
                            child: CircleAvatar(
                              radius: 36,
                              backgroundColor: Colors.grey[200],
                              backgroundImage:
                                  studentImage != null && studentImage.isNotEmpty ? NetworkImage(studentImage) : null,
                              child: (studentImage == null || studentImage.isEmpty)
                                  ? const Icon(Icons.person, size: 36, color: Colors.grey)
                                  : null,
                            ),
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  studentName,
                                  style: const TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black87,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                Text(
                                  'Order #${orderDetails['id']}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.grey[600],
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                            decoration: BoxDecoration(
                              color: statusColor.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(20),
                              border: Border.all(color: statusColor.withOpacity(0.3)),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: statusColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                                letterSpacing: 1.1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 32),

                // Items Section Title
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4.0),
                  child: Row(
                    children: [
                      Icon(Icons.receipt_long_rounded, color: primaryColor, size: 28),
                      const SizedBox(width: 12),
                      const Text(
                        'Ordered Items',
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                      ),
                      const Spacer(),
                      if (items.isNotEmpty)
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: primaryColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            '${items.length} Items',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 12,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Items List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: items.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    final item = items[index];
                    final product = item['canteen_products'] ?? {};
                    return Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 2),
                          ),
                        ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          children: [
                            Hero(
                              tag: 'product_${product['id'] ?? index}',
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(16),
                                child: Container(
                                  width: 90,
                                  height: 90,
                                  color: Colors.grey[100],
                                  child: Image.network(
                                    product['image_url'] ?? '',
                                    fit: BoxFit.cover,
                                    errorBuilder: (_, __, ___) => const Icon(
                                      Icons.fastfood,
                                      color: Colors.grey,
                                      size: 30,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    product['name'] ?? 'Item Name',
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                      color: Colors.black87,
                                    ),
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  // Add price details here if available in future
                                ],
                              ),
                            ),
                            Container(
                              height: 40,
                              constraints: const BoxConstraints(minWidth: 40),
                              alignment: Alignment.center,
                              padding: const EdgeInsets.symmetric(horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Text(
                                'x${item['quantity'] ?? 0}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.w800,
                                  fontSize: 16,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),

                // Bottom padding
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
