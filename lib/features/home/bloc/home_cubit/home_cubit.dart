import 'package:flutter/material.dart';
import 'package:m_cubit/abstraction.dart';
import 'package:victoria/core/api_manager/api_service.dart';

import '../../../../generated/l10n.dart';

part 'home_state.dart';

class HomeCubit extends MCubit<HomeInitial> {
  HomeCubit() : super(HomeInitial.initial());

  void initialController({required PageController controller}) {
    emit(state.copyWith(controller: controller));
  }

  int get getIndex {
    try {
      return state.controller.page?.toInt() ?? 0;
    } catch (e) {
      loggerObject.e('HomeCubit $e');
      return 0;
    }
  }

  bool get canPop {
    try {
      return state.controller.page?.toInt() == 0;
    } catch (e) {
      loggerObject.e('HomeCubit $e');
      return false;
    }
  }

  void jumpPage(int i) {
    state.controller.jumpToPage(i);
    emit(state.copyWith(notify: state.notify + 1));
  }

  void refresh() {
    emit(state.copyWith(notify: state.notify + 1));
  }
}
