import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_search.dart';
import '../../theme/app_theme.dart';
import '../../util/format_function.dart';
import 'custom_action_button.dart';
import 'order_view_detail_page.dart';
import 'orders_bloc/orders_bloc.dart';

class OrdersScreen extends StatefulWidget {
  final String status;
  const OrdersScreen({super.key, required this.status});

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  final OrdersBloc _ordersBloc = OrdersBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map<String, dynamic>> _orders = [];

  @override
  void initState() {
    params['status'] = widget.status;
    getOrders();
    super.initState();
  }

  void getOrders() {
    _ordersBloc.add(GetAllOrdersEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _ordersBloc,
      child: BlocConsumer<OrdersBloc, OrdersState>(
        listener: (context, state) {
          if (state is OrdersFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getOrders();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is OrdersGetSuccessState) {
            _orders = state.orders;
            Logger().w(_orders);
            setState(() {});
          } else if (state is OrdersSuccessState) {
            getOrders();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Card(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Text(
                          'Orders Screen',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontWeight: FontWeight.bold, color: Colors.green),
                        ),
                        const Spacer(),
                        Expanded(
                          child: CustomSearch(
                            onSearch: (value) {
                              params['query'] = value;
                              getOrders();
                            },
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    if (state is OrdersLoadingState) const Center(child: CircularProgressIndicator()),
                    if (state is OrdersGetSuccessState && _orders.isEmpty) const Center(child: Text('No Orders Found')),
                    if (state is OrdersGetSuccessState && _orders.isNotEmpty)
                      Expanded(
                        child: DataTable2(
                          columnSpacing: 12,
                          horizontalMargin: 12,
                          minWidth: 1200,
                          columns: const [
                            DataColumn(label: Text('Order ID')),
                            DataColumn(label: Text('Customer Name')),
                            DataColumn(label: Text('Created At')),
                            DataColumn(label: Text('Status')),
                            DataColumn(
                              label: Align(alignment: Alignment.centerRight, child: Text('Action')),
                            ),
                          ],
                          rows: List.generate(
                            _orders.length,
                            (index) {
                              return DataRow(
                                cells: [
                                  DataCell(Text(_orders[index]['id'].toString())),
                                  DataCell(Text(formatValue(_orders[index]['customers']['name']))),
                                  DataCell(Text(formatDate(_orders[index]['created_at']))),
                                  DataCell(Text(_orders[index]['status'])),
                                  DataCell(
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      spacing: 10,
                                      children: [
                                        if (widget.status == "pending")
                                          CustomActionbutton(
                                              ontap: () {
                                                showDialog(
                                                  context: context,
                                                  builder: (context) => CustomAlertDialog(
                                                    title: 'Change Status to Complete?',
                                                    description:
                                                        'Are you sure you want to change the status to Complete?',
                                                    primaryButton: 'Confirm',
                                                    onPrimaryPressed: () {
                                                      _ordersBloc.add(
                                                        EditOrderEvent(
                                                          orderDetails: {'status': 'Complete'},
                                                          orderId: _orders[index]['id'],
                                                        ),
                                                      );
                                                      Navigator.pop(context);
                                                    },
                                                    secondaryButton: 'Cancel',
                                                  ),
                                                );
                                              },
                                              title: "Ready",
                                              icon: Icons.chevron_right_outlined,
                                              color: Colors.green),
                                        CustomViewButton(
                                          ontap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => OrderDetailsPage(
                                                  orderDetails: _orders[index],
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class CustomViewButton extends StatelessWidget {
  const CustomViewButton({
    super.key,
    required this.ontap,
  });
  final Function()? ontap;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Material(
        borderRadius: BorderRadiusDirectional.circular(20),
        color: primaryColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Text(
            'View details',
            style: Theme.of(context).textTheme.bodySmall!.copyWith(fontWeight: FontWeight.normal, color: Colors.white),
          ),
        ),
      ),
    );
  }
}
