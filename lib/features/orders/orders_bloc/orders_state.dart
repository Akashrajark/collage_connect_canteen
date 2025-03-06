part of 'orders_bloc.dart';

@immutable
sealed class OrdersState {}

class OrdersInitialState extends OrdersState {}

class OrdersLoadingState extends OrdersState {}

class OrdersGetSuccessState extends OrdersState {
  final List<Map<String, dynamic>> orders;
  OrdersGetSuccessState({required this.orders});
}

class OrdersSuccessState extends OrdersState {}

class OrdersFailureState extends OrdersState {
  final String message;
  OrdersFailureState({this.message = apiErrorMessage});
}
