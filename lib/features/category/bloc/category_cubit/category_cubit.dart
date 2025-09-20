import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/category/data/response/category_response.dart';

part 'category_state.dart';

class CategoryCubit extends MCubit<CategoryInitial> {
  CategoryCubit() : super(CategoryInitial.initial());

  @override
  String get nameCache => 'category';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? categoryId}) async {
    emit(state.copyWith(request: categoryId));

    await getDataAbstract(
      fromJson: Category.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Category?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.category,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Category.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setCategory(dynamic category) {
    if (category is! Category) return;

    emit(state.copyWith(result: category));
  }
}
