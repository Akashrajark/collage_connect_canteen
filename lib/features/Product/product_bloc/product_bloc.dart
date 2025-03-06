import 'package:bloc/bloc.dart';
import 'package:logger/web.dart';
import 'package:meta/meta.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../util/file_upload.dart';
import '../../../values/strings.dart';

part 'product_event.dart';
part 'product_state.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductBloc() : super(ProductInitialState()) {
    on<ProductEvent>((event, emit) async {
      try {
        emit(ProductLoadingState());
        SupabaseClient supabaseClient = Supabase.instance.client;

        SupabaseQueryBuilder table =
            Supabase.instance.client.from('shop_products');

        if (event is GetAllProductsEvent) {
          List<Map<String, dynamic>> categories = await supabaseClient
              .from('categories')
              .select()
              .order('name', ascending: true);
          PostgrestFilterBuilder<List<Map<String, dynamic>>> query =
              table.select('*,categories(name)');
          if (event.params['query'] != null) {
            query = query.ilike('name', '%${event.params['query']}%');
          }

          List<Map<String, dynamic>> products =
              await query.order('name', ascending: true);

          emit(ProductGetSuccessState(
              products: products, categories: categories));
        } else if (event is AddProductEvent) {
          event.productDetails['shop_user_id'] =
              supabaseClient.auth.currentUser!.id;
          event.productDetails['image_url'] = await uploadFile(
            'petstores/image',
            event.productDetails['image'],
            event.productDetails['image_name'],
          );
          event.productDetails.remove('image');
          event.productDetails.remove('image_name');

          await table.insert(event.productDetails);
          emit(ProductSuccessState());
        } else if (event is EditProductEvent) {
          event.productDetails.remove('email');
          event.productDetails.remove('password');
          if (event.productDetails['image'] != null) {
            event.productDetails['image_url'] = await uploadFile(
              'petstores/image',
              event.productDetails['image'],
              event.productDetails['image_name'],
            );
            event.productDetails.remove('image');
            event.productDetails.remove('image_name');
          }
          await table.update(event.productDetails).eq('id', event.productId);
          emit(ProductSuccessState());
        } else if (event is DeleteProductEvent) {
          await table.delete().eq('id', event.productId);
          emit(ProductSuccessState());
        }
      } catch (e, s) {
        Logger().e('$e\n$s');
        emit(ProductFailureState());
      }
    });
  }
}
