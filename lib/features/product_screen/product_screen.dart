import 'package:college_connect_canteen/common_widget/custom_button.dart';
import 'package:college_connect_canteen/common_widget/custom_search.dart';
import 'package:college_connect_canteen/features/product_screen/add_product.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

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
              Row(
                children: [
                  const Text(
                    'Students',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Spacer(),
                  SizedBox(
                    width: 300,
                    child: CustomSearch(
                      onSearch: (p0) {},
                    ),
                  ),
                  const SizedBox(width: 20),
                  CustomButton(
                    color: Colors.white,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddProduct(),
                      );
                    },
                    label: 'Add student',
                    iconData: Icons.add,
                  )
                ],
              ),
              const SizedBox(height: 16),
              SizedBox(
                height: 500,
                child: DataTable2(
                  columnSpacing: 12,
                  horizontalMargin: 12,
                  minWidth: 600,
                  columns: const [
                    DataColumn2(
                        label: Text('Product Name'), size: ColumnSize.L),
                    DataColumn(label: Text('Price')),
                    DataColumn(label: Text('Image')),
                    DataColumn(label: Text('Details'), numeric: true),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('Pazham pori')),
                      const DataCell(Text('15')),
                      DataCell(
                        Image.network(
                          'https://i0.wp.com/annikaeats.com/wp-content/uploads/2022/09/DSC_0300.jpg?zoom=3&resize=480%2C270&ssl=1', // Replace with your image path
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const DataCell(Text('Nalla payampori')),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Bonda')),
                      const DataCell(Text('12')),
                      DataCell(
                        Image.network(
                          'https://i0.wp.com/www.splashoftaste.com/wp-content/uploads/2022/04/Bonda-aloo-11.jpg', // Replace with your image path
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                        ),
                      ),
                      const DataCell(Text('Mosham bonda')),
                    ]),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
