import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../values/strings.dart';

part 'orders_event.dart';
part 'orders_state.dart';

class OrdersBloc extends Bloc<OrdersEvent, OrdersState> {
  OrdersBloc() : super(OrdersInitialState()) {
    on<OrdersEvent>((event, emit) async {
      try {
        emit(OrdersLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;

        SupabaseQueryBuilder table = supabaseClient.from('orders');

        if (event is GetAllOrdersEvent) {
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*, students(*),order_items(*,canteen_products(*))').eq('status', event.params['status']);
          if (event.params['query'] != null) {
            query = query.ilike('students.name', '%${event.params['query']}%');
          }
          table.select('*');

          List<Map<String, dynamic>> orders = await query.order('created_at', ascending: true);

          emit(OrdersGetSuccessState(orders: orders));
        } else if (event is AddOrderEvent) {
          await table.insert(event.orderDetails);
          emit(OrdersSuccessState());
        } else if (event is EditOrderEvent) {
          await table.update(event.orderDetails).eq('id', event.orderId);
          emit(OrdersSuccessState());
        } else if (event is DeleteOrderEvent) {
          await table.delete().eq('id', event.orderId);
          emit(OrdersSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(OrdersFailureState());
      }
    });
  }
}
