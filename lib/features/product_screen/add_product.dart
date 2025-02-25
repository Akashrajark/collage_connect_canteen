import 'package:college_connect_canteen/common_widget/custom_alert_dialog.dart';
import 'package:college_connect_canteen/common_widget/custom_button.dart';
import 'package:college_connect_canteen/common_widget/custom_image_picker_button.dart';
import 'package:college_connect_canteen/common_widget/custom_text_formfield.dart';
import 'package:college_connect_canteen/util/value_validator.dart';
import 'package:flutter/material.dart';

class AddProduct extends StatelessWidget {
  AddProduct({super.key});
  final _nameController = TextEditingController();
  final _desController = TextEditingController();
  final _priceController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomAlertDialog(
      title: 'Add Product',
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomImagePickerButton(
            onPick: (file) {},
            width: 200,
            height: 200,
          ),
          SizedBox(
            height: 20,
          ),
          const Text(
            'Product Name',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
              labelText: 'Enter Product Name',
              controller: _nameController,
              validator: notEmptyValidator,
              isLoading: false),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Description',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
              labelText: 'Enter description',
              controller: _desController,
              validator: notEmptyValidator,
              isLoading: false),
          const SizedBox(
            height: 8,
          ),
          const Text(
            'Price',
            style: TextStyle(
              fontWeight: FontWeight.normal,
              color: Colors.black,
              fontSize: 16.0,
            ),
            textAlign: TextAlign.left,
          ),
          const SizedBox(
            height: 8,
          ),
          CustomTextFormField(
              labelText: 'Enter price',
              controller: _priceController,
              validator: notEmptyValidator,
              isLoading: false),
          const SizedBox(
            height: 30,
          ),
          CustomButton(
            color: Colors.white,
            onPressed: () {},
            label: 'Add product',
          )
        ],
      ),
    );
  }
}
