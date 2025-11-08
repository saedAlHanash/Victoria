import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/address/data/request/create_address_request.dart';
import 'package:victoria/features/address/data/response/address_response.dart';
import 'package:http/http.dart';
import 'package:m_cubit/m_cubit.dart';

import '../../../../core/app/app_provider.dart';
import '../../../../core/error/error_manager.dart';
import '../../../../core/widgets/spinner_widget.dart';

part 'addresses_state.dart';

class AddressesCubit extends MCubit<AddressesInitial> {
  AddressesCubit() : super(AddressesInitial.initial());

  @override
  String get nameCache => 'addresses';

  @override
  String get filter => state.filter;

  //region getData

  void getDataFromCache() => getFromCache(
        fromJson: Address.fromJson,
        state: state,
        onSuccess: (data) {
          emit(state.copyWith(result: data));
        },
      );

  Future<void> getData({bool newData = false}) async {
    if (AppProvider.isGuest) return;
    await getDataAbstract(
      fromJson: Address.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<List<Address>?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: PostUrl.addresses,
      body: state.filterRequest?.toJson() ?? {},
    );

    if (response.statusCode.success) {
      return Pair(Addresses.fromJson(response.jsonBody).data, null);
    } else {
      return response.getPairError;
    }
  }

  //endregion

  //region CRUD

  Future<void> createOrUpdate() async {
    if (state.cRequest.id != 0) {
      await update();
    } else {
      await create();
    }
  }

  Future<void> create() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.create));

    final response = await APIService().callApi(
      type: ApiType.post,
      url: PostUrl.createAddress,
      body: state.cRequest.toJson(),
    );

    await _updateState(response);
  }

  Future<void> update() async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.update));

    final response = await APIService().callApi(
      type: ApiType.put,
      url: PutUrl.updateAddress,
      path: state.cRequest.id.toString(),
      body: state.cRequest.toJson(),
    );
    await _updateState(response);
  }

  Future<void> delete({required String id}) async {
    emit(state.copyWith(statuses: CubitStatuses.loading, cubitCrud: CubitCrud.delete, id: id));

    final response = await APIService().callApi(
      type: ApiType.delete,
      url: DeleteUrl.deleteAddress,
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
      url: DeleteUrl.deleteAddress,
      path: state.id.toString(),
    );

    if (response.statusCode.success) {
      await deleteAddressFromCache(item.id.toString());
    } else {
      showErrorFromApi(state);
      state.result.insert(index, item);
      emit(state.copyWith(statuses: CubitStatuses.error, result: state.result));
    }
  }

  Future<void> _updateState(Response response, {bool isDelete = false}) async {
    if (response.statusCode.success) {
      final item = Address.fromJson(response.jsonBody);
      isDelete ? await deleteAddressFromCache(state.id.toString()) : await addOrUpdateAddressToCache(item);
      emit(state.copyWith(statuses: CubitStatuses.done));
    } else {
      emit(state.copyWith(statuses: CubitStatuses.error, error: response.getPairError.second));
      showErrorFromApi(state);
    }
  }

  //endregion

  void setRequest(CreateAddressRequest request) {
    emit(state.copyWith(cRequest: request));
  }

  Future<void> addOrUpdateAddressToCache(Address item) async {
    final listJson = await addOrUpdateDate([item]);
    if (listJson == null) return;
    final list = listJson.map((e) => Address.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }

  Future<void> deleteAddressFromCache(String id) async {
    final listJson = await deleteDate([id]);
    if (listJson == null) return;
    final list = listJson.map((e) => Address.fromJson(e)).toList();
    emit(state.copyWith(result: list));
  }
}
