import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/product/data/response/product_response.dart';

part 'product_state.dart';

class ProductCubit extends MCubit<ProductInitial> {
  ProductCubit() : super(ProductInitial.initial());

  @override
  String get nameCache => 'product';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? productId}) async {
    emit(state.copyWith(request: productId));

    await getDataAbstract(
      fromJson: Product.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Product?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.product,
      path: state.request.toString(),
    );

    if (response.statusCode.success) {
      final product = response.jsonBody['product'];
      final suggested = response.jsonBody['suggested_products'];
      final map = product..addAll({'suggested_products': suggested});
      final model = Product.fromJson(map);
      return Pair(model, null);
    } else {
      return response.getPairError;
    }
  }

  void setProduct(dynamic product) {
    if (product is! Product) return;

    emit(state.copyWith(result: product));
  }
}
