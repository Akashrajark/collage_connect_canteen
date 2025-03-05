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
                    inverse: true,
                    onPressed: () {
                      showDialog(
                        context: context,
                        builder: (context) => AddProduct(),
                      );
                    },
                    label: 'Add Product',
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
                    DataColumn(label: Text('Details')),
                    DataColumn(label: Text('Action'), numeric: true),
                  ],
                  rows: [
                    DataRow(cells: [
                      const DataCell(Text('Pazham pori')),
                      const DataCell(Text('15')),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              'https://i0.wp.com/annikaeats.com/wp-content/uploads/2022/09/DSC_0300.jpg?zoom=3&resize=480%2C270&ssl=1', // Replace with your image path
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const DataCell(Text('Nalla payampori')),
                      DataCell(
                        EditDeleteButton(),
                      ),
                    ]),
                    DataRow(cells: [
                      const DataCell(Text('Bonda')),
                      const DataCell(Text('12')),
                      DataCell(
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 5),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                              'https://i0.wp.com/www.splashoftaste.com/wp-content/uploads/2022/04/Bonda-aloo-11.jpg', // Replace with your image path
                              width: 80,
                              height: 80,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      const DataCell(Text('Mosham bonda')),
                      DataCell(EditDeleteButton()),
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

class EditDeleteButton extends StatelessWidget {
  const EditDeleteButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(children: [
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.edit,
            color: Colors.blue,
          )),
      SizedBox(
        width: 20,
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.delete,
            color: Colors.orange,
          ))
    ]);
  }
}
