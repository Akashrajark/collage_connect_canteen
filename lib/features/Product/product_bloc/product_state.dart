part of 'product_bloc.dart';

@immutable
sealed class ProductState {}

class ProductInitialState extends ProductState {}

class ProductLoadingState extends ProductState {}

class ProductGetSuccessState extends ProductState {
  final List<Map<String, dynamic>> products;
  final List<Map<String, dynamic>>? categories;

  ProductGetSuccessState({
    required this.products,
    this.categories,
  });
}

class ProductSuccessState extends ProductState {}

class ProductFailureState extends ProductState {
  final String message;
  ProductFailureState({this.message = apiErrorMessage});
}
