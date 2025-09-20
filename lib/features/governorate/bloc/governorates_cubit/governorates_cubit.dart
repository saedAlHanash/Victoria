import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';
import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/governorate/data/request/create_governorate_request.dart';
import 'package:victoria/features/governorate/data/response/governorate_response.dart';

import '../../../../core/error/error_manager.dart';
import '../../../../core/widgets/spinner_widget.dart';

part 'governorates_state.dart';

class GovernoratesCubit extends MCubit<GovernoratesInitial> {
  GovernoratesCubit() : super(GovernoratesInitial.initial());

  @override
  String get nameCache => 'governorates';

  @override
  String get filter => '';

  @override
  int get timeInterval => 300000;

  //region getData

  void getDataFromCache() => getFromCache(
        fromJson: Governorate.fromJson,
        state: state,
        onSuccess: (data) => emit(state.copyWith(result: data)),
      );

  Future<void> getData({bool newData = false}) async {
    await getDataAbstract(
      fromJson: Governorate.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Governorate>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.governorates,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Governorates.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD
  Future<void> create() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.createGovernorate,
      body: state.cRequest.toJson(),
    );

    await _updateState(response);
  }

  Future<void> update() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.updateGovernorate,
      query: {'id': state.cRequest.id},
      body: state.cRequest.toJson(),
    );
    await _updateState(response);
  }

  Future<void> delete({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteGovernorate,
      query: {'id': state.id.toString()},
    );

    await _updateState(response, isDelete: true);
  }

  Future<void> deleteNow({required String id}) async {
    final index = state.result.indexWhere((element) => element.id.toString() == id);
    final item = state.result.removeAt(index);

    emit(state.copyWith(cubitCrud: CubitCrud.delete, result: state.result, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteGovernorate,
      query: {'id': state.id.toString()},
    );

    if (response.statusCode.success) {
      await deleteGovernorateFromCache(item.id.toString());
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {bool isDelete = false}) async {
    if (response.statusCode.success) {
      final item = Governorate.fromJson(response.jsonBody);
      isDelete ? await deleteGovernorateFromCache(state.id.toString()) : await addOrUpdateGovernorateToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
      showErrorFromApi(state);
    }
  }

  //endregion

  void selectGovernorate(String id) {
    emit(state.copyWith(id: id));
  }

  Future<void> addOrUpdateGovernorateToCache(Governorate item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Governorate.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteGovernorateFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Governorate.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
