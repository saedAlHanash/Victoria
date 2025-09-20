part of 'home_cubit.dart';

class HomeInitial extends AbstractState<bool> {
  const HomeInitial({
    required super.result,
    super.error,
    required super.request,
    required this.controller,
    required this.notify,
    super.statuses,
  });

  final PageController controller;
  final int notify;

  String get getLabel {
    switch (getIndex) {
      case 0:
        return S().home;
      case 1:
        return S().cart;
      case 2:
        return S().fav;
      case 3:
        return S().notification;
      case 4:
        return S().profile;
    }
    return '';
  }
  factory HomeInitial.initial() {
    return HomeInitial(
      result: true,
      controller: PageController(initialPage: 0),
      notify: 0,
      error: '',
      request: '',
      statuses: CubitStatuses.init,
    );
  }
  int get getIndex {
    try {
      return controller.page?.toInt() ?? 0;
    } catch (e) {
      return 0;
    }
  }
  @override
  List<Object> get props => [
        statuses,
        result,
        controller,
        error,
        notify,
        if (request != null) request,
        if (filterRequest != null) filterRequest!
      ];

  HomeInitial copyWith({
    CubitStatuses? statuses,
    bool? result,
    String? error,
    int? notify,
    String? request,
    PageController? controller,
  }) {
    return HomeInitial(
      statuses: statuses ?? this.statuses,
      result: result ?? this.result,
      error: error ?? this.error,
      request: request ?? this.request,
      notify: notify ?? this.notify,
      controller: controller ?? this.controller,
    );
  }
}
