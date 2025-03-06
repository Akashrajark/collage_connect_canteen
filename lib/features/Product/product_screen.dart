import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:logger/web.dart';
import 'package:pick_n_pay_shop/common_widget/custom_button.dart';
import 'package:pick_n_pay_shop/common_widget/custom_search.dart';
import 'package:pick_n_pay_shop/common_widget/text_link.dart';
import 'package:pick_n_pay_shop/features/Product/add_product.dart';
import 'package:pick_n_pay_shop/features/Product/product_bloc/product_bloc.dart';

import '../../common_widget/custom_alert_dialog.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductBloc _productBloc = ProductBloc();

  Map<String, dynamic> params = {
    'query': null,
  };

  List<Map<String, dynamic>> _products = [], _categories = [];

  @override
  void initState() {
    getProducts();
    super.initState();
  }

  void getProducts() {
    _productBloc.add(GetAllProductsEvent(params: params));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: _productBloc,
      child: BlocConsumer<ProductBloc, ProductState>(
        listener: (context, state) {
          if (state is ProductFailureState) {
            showDialog(
              context: context,
              builder: (context) => CustomAlertDialog(
                title: 'Failure',
                description: state.message,
                primaryButton: 'Try Again',
                onPrimaryPressed: () {
                  getProducts();
                  Navigator.pop(context);
                },
              ),
            );
          } else if (state is ProductGetSuccessState) {
            _products = state.products;
            _categories = state.categories ?? [];
            Logger().w(_products);
            Logger().w(_categories);
            setState(() {});
          } else if (state is ProductSuccessState) {
            getProducts();
          }
        },
        builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    Text(
                      'Products Screen',
                      style: Theme.of(context)
                          .textTheme
                          .headlineSmall!
                          .copyWith(
                              fontWeight: FontWeight.bold, color: Colors.green),
                    ),
                    const Spacer(),
                    Expanded(
                      child: CustomSearch(
                        onSearch: (value) {
                          params['query'] = value;
                          getProducts();
                        },
                      ),
                    ),
                    const SizedBox(width: 10),
                    CustomButton(
                      inverse: true,
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (context) => BlocProvider.value(
                            value: _productBloc,
                            child: AddEditProduct(
                              categories: _categories,
                            ),
                          ),
                        );
                      },
                      label: 'Add Product',
                      iconData: Icons.add,
                    )
                  ],
                ),
                const SizedBox(height: 30),
                if (state is ProductLoadingState)
                  const Center(child: CircularProgressIndicator()),
                if (state is ProductGetSuccessState && _products.isEmpty)
                  const Center(child: Text('No Products Found')),
                if (state is ProductGetSuccessState && _products.isNotEmpty)
                  Expanded(
                    child: DataTable2(
                      columnSpacing: 12,
                      horizontalMargin: 12,
                      minWidth: 1200,
                      columns: const [
                        DataColumn(label: Text('Product Name')),
                        DataColumn(label: Text('MRP')),
                        DataColumn(label: Text('Image URL')),
                        DataColumn(label: Text('Stock')),
                        DataColumn(label: Text('Unit')),
                        DataColumn(label: Text('Category')),
                        DataColumn(
                          label: Align(
                              alignment: Alignment.centerRight,
                              child: Text('Action')),
                        ),
                      ],
                      rows: List.generate(
                        _products.length,
                        (index) {
                          return DataRow(
                            cells: [
                              DataCell(Text(_products[index]['name'])),
                              DataCell(
                                  Text(_products[index]['price'].toString())),
                              DataCell(
                                TextLink(
                                  text: 'View Image',
                                  onPressed: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) => CustomAlertDialog(
                                        content: Image.network(
                                            _products[index]['image_url']),
                                        title: 'product image',
                                      ),
                                    );
                                  },
                                ),
                              ),
                              DataCell(
                                  Text(_products[index]['stock'].toString())),
                              DataCell(Text(_products[index]['unit'])),
                              DataCell(Text(
                                  _products[index]['categories']?['name'])),
                              DataCell(
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              BlocProvider.value(
                                            value: _productBloc,
                                            child: AddEditProduct(
                                              categories: _categories,
                                              productDetails: _products[index],
                                            ),
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.edit,
                                        color: Colors.blue,
                                      ),
                                    ),
                                    const SizedBox(width: 5),
                                    IconButton(
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          builder: (context) =>
                                              CustomAlertDialog(
                                            title: 'Delete Product',
                                            description:
                                                'Are you sure you want to delete this product?',
                                            primaryButton: 'Yes',
                                            onPrimaryPressed: () {
                                              _productBloc.add(
                                                DeleteProductEvent(
                                                  productId: _products[index]
                                                      ['id'],
                                                ),
                                              );
                                              Navigator.pop(context);
                                            },
                                            secondaryButton: 'No',
                                            onSecondaryPressed: () {
                                              Navigator.pop(context);
                                            },
                                          ),
                                        );
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.orange,
                                      ),
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
          );
        },
      ),
    );
  }
}
