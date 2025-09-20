part of 'address_cubit.dart';

class AddressInitial extends AbstractState<Address> {
  const AddressInitial({
    required super.result,
    super.error,
    required super.request,
    super.statuses,
    super.id,
  });

  factory AddressInitial.initial() {
    return AddressInitial(
      result: Address.fromJson({}),
      request: '',
      
    );
  }

  @override
  List<Object> get props => [
        statuses,
        result,
        error,
        if (request != null) request,
        if (id != null) id,
        if (filterRequest != null) filterRequest!,
      ];
      
  AddressInitial copyWith({
    CubitStatuses? statuses,
    Address? result,
    String? error,
    dynamic id,
    String? request,
  }) {
    return AddressInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      id: id ?? this.id,
      request: request ?? this.request,
    );
  }
}

   