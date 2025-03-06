part of 'product_bloc.dart';

@immutable
sealed class ProductEvent {}

class GetAllProductsEvent extends ProductEvent {
  final Map<String, dynamic> params;
  GetAllProductsEvent({required this.params});
}

class AddProductEvent extends ProductEvent {
  final Map<String, dynamic> productDetails;
  AddProductEvent({required this.productDetails});
}

class EditProductEvent extends ProductEvent {
  final int productId;
  final Map<String, dynamic> productDetails;
  EditProductEvent({required this.productId, required this.productDetails});
}

class DeleteProductEvent extends ProductEvent {
  final int productId;
  DeleteProductEvent({required this.productId});
}
