import 'package:victoria/core/api_manager/api_service.dart';
import 'package:victoria/core/api_manager/api_url.dart';
import 'package:victoria/core/extensions/extensions.dart';
import 'package:victoria/core/strings/enum_manager.dart';
import 'package:victoria/core/util/pair_class.dart';
import 'package:victoria/features/address/data/response/address_response.dart';
import 'package:m_cubit/abstraction.dart';

part 'address_state.dart';

class AddressCubit extends MCubit<AddressInitial> {
  AddressCubit() : super(AddressInitial.initial());

  @override
  String get nameCache => 'address';

  @override
  String get filter => state.filter;

  Future<void> getData({bool newData = false, String? addressId}) async {
    emit(state.copyWith(request: addressId));

    await getDataAbstract(
      fromJson: Address.fromJson,
      state: state,
      getDataApi: _getData,
      newData: newData,
    );
  }

  Future<Pair<Address?, String?>> _getData() async {
    final response = await APIService().callApi(
      type: ApiType.get,
      url: GetUrl.address,
      query: {'Id': state.request},
    );

    if (response.statusCode.success) {
      return Pair(Address.fromJson(response.jsonBody), null);
    } else {
      return response.getPairError;
    }
  }

  void setAddress(dynamic address) {
    if (address is! Address) return;

    emit(state.copyWith(result: address));
  }
}
