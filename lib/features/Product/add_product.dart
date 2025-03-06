import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../common_widget/custom_alert_dialog.dart';
import '../../common_widget/custom_dropdownmenu.dart';
import '../../common_widget/custom_image_picker_button.dart';
import '../../common_widget/custom_text_formfield.dart';
import '../../util/value_validator.dart';
import 'product_bloc/product_bloc.dart';

class AddEditProduct extends StatefulWidget {
  final Map? productDetails;
  final List categories;
  const AddEditProduct(
      {super.key, this.productDetails, required this.categories});

  @override
  State<AddEditProduct> createState() => _AddEditProductState();
}

class _AddEditProductState extends State<AddEditProduct> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  final TextEditingController _stockController = TextEditingController();

  PlatformFile? productImage;
  String selectedUnit = 'kg';
  int? selectedCategory;

  @override
  void initState() {
    if (widget.productDetails != null) {
      _productNameController.text = widget.productDetails!['name'];
      _priceController.text = widget.productDetails!['price'].toString();
      _stockController.text = widget.productDetails!['stock'].toString();
      selectedUnit = widget.productDetails!['unit'];
      selectedCategory = widget.productDetails!['category_id'];
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductBloc, ProductState>(
      listener: (context, state) {
        if (state is ProductSuccessState) {
          Navigator.pop(context);
        }
      },
      builder: (context, state) {
        return CustomAlertDialog(
          isLoading: state is ProductLoadingState,
          title: widget.productDetails == null ? 'Add Product' : 'Edit Product',
          content: Form(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            key: _formKey,
            child: Flexible(
              child: ListView(
                shrinkWrap: true,
                children: [
                  Text(
                    "Product Details",
                    style: TextStyle(fontSize: 15, fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 5),
                  CustomImagePickerButton(
                    width: double.infinity,
                    height: 200,
                    selectedImage: widget.productDetails?['image_url'],
                    onPick: (pick) {
                      productImage = pick;
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: notEmptyValidator,
                    controller: _productNameController,
                    isLoading: state is ProductLoadingState,
                    labelText: 'Product Name',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: numericValidator,
                    controller: _priceController,
                    isLoading: state is ProductLoadingState,
                    labelText: 'Price',
                  ),
                  SizedBox(height: 10),
                  CustomTextFormField(
                    validator: numericValidator,
                    controller: _stockController,
                    isLoading: state is ProductLoadingState,
                    labelText: 'Stock',
                  ),
                  SizedBox(height: 10),
                  CustomDropDownMenu(
                    initialSelection: selectedUnit,
                    hintText: 'Select Unit',
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: 'kg', label: 'kg'),
                      DropdownMenuEntry(value: 'ltr', label: 'ltr'),
                      DropdownMenuEntry(value: 'piece', label: 'piece'),
                    ],
                    onSelected: (String? newValue) {
                      setState(() {
                        selectedUnit = newValue!;
                      });
                    },
                  ),
                  SizedBox(height: 10),
                  CustomDropDownMenu(
                    initialSelection: selectedCategory,
                    hintText: 'Select Category',
                    dropdownMenuEntries: widget.categories
                        .map((category) => DropdownMenuEntry(
                            value: category['id'], label: category['name']))
                        .toList(),
                    onSelected: (newValue) {
                      setState(() {
                        selectedCategory = newValue!;
                      });
                    },
                  ),
                ],
              ),
            ),
          ),
          onPrimaryPressed: () {
            if (_formKey.currentState!.validate() &&
                ((productImage != null) || widget.productDetails != null)) {
              Map<String, dynamic> details = {
                'name': _productNameController.text.trim(),
                'price': double.parse(_priceController.text.trim()),
                'stock': int.parse(_stockController.text.trim()),
                'unit': selectedUnit,
                'category_id': selectedCategory,
              };

              if (productImage != null) {
                details['image'] = productImage!.bytes;
                details['image_name'] = productImage!.name;
              }

              if (widget.productDetails != null) {
                BlocProvider.of<ProductBloc>(context).add(
                  EditProductEvent(
                    productId: widget.productDetails!['id'],
                    productDetails: details,
                  ),
                );
              } else {
                BlocProvider.of<ProductBloc>(context).add(
                  AddProductEvent(
                    productDetails: details,
                  ),
                );
              }
            }
          },
          primaryButton: 'Save Changes',
        );
      },
    );
  }
}
