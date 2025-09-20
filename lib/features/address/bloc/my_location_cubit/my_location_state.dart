part of 'my_location_cubit.dart';

class MyLocationInitial extends AbstractState<LatLng> {
  final String name;
  final bool moveMap;

  const MyLocationInitial({
    required super.result,
    required super.statuses,
    required this.name,
    required this.moveMap,
  });

  factory MyLocationInitial.initial() {
    return const MyLocationInitial(
      result: LatLng(0, 0),
      name: '',
      moveMap: false,
      statuses: CubitStatuses.init,
    );
  }

  MyLocationInitial copyWith({
    LatLng? result,
    CubitStatuses? statuses,
    String? name,
    bool? moveMap,
  }) {
    return MyLocationInitial(
      result: result ?? this.result,
      statuses: statuses ?? this.statuses,
      name: name ?? this.name,
      moveMap: moveMap ?? this.moveMap,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        result,
        statuses,
        name,
        moveMap,
      ];
}
