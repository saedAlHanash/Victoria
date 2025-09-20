part of 'addresses_cubit.dart';

class AddressesInitial extends AbstractState<List<Address>> {
  const AddressesInitial({
    required super.result,
    super.error,
    super.request,
    super.filterRequest,
    super.cubitCrud,
    super.createUpdateRequest,
    super.statuses,
    super.id,
  });

  factory AddressesInitial.initial() {
    return AddressesInitial(
      result: [],
      createUpdateRequest: CreateAddressRequest.fromJson({}),
    );
  }

  List<SpinnerItem> getSpinnerItems({String? selectedId}) {
    return List<SpinnerItem>.from(
      result.map(
        (e) => SpinnerItem(
          id: e.id,
          isSelected: e.id.toString() == (selectedId),
          name: e.name.isBlank ? e.governorate.name : e.name,
          item: e,
        ),
      ),
    )..insert(0, SpinnerItem(name: 'إضافة عنوان جديد', id: -1));
  }

  CreateAddressRequest get cRequest => createUpdateRequest;

  String get mId => id;

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        cubitCrud,
        if (id != null) id,
        if (request != null) request,
        if (filterRequest != null) filterRequest!,
        if (createUpdateRequest != null) createUpdateRequest!,
      ];

  AddressesInitial copyWith({
    CubitStatuses? statuses,
    CubitCrud? cubitCrud,
    List<Address>? result,
    String? error,
    FilterRequest? filterRequest,
    dynamic request,
    dynamic cRequest,
    dynamic id,
  }) {
    return AddressesInitial(
      statuses: statuses ?? this.statuses,
      cubitCrud: cubitCrud ?? this.cubitCrud,
      result: result ?? this.result,
      error: error ?? this.error,
      filterRequest: filterRequest ?? this.filterRequest,
      request: request ?? this.request,
      createUpdateRequest: cRequest ?? this.cRequest,
      id: id ?? this.id,
    );
  }
}
