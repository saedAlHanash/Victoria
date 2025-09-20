import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/spinner_widget.dart';
import '../../../../generated/l10n.dart';
import '../../bloc/governorates_cubit/governorates_cubit.dart';

class GovernorateSpinner extends StatelessWidget {
  const GovernorateSpinner({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GovernoratesCubit, GovernoratesInitial>(
      builder: (context, state) {
        return SpinnerWidget(
          loading: state.loading,
          hintText: S.of(context).governorate,
          hintLabel: S.of(context).governorate,
          items: state.getSpinnerItems(selectedId: state.selectedId),
          onChanged: (spinnerItem) {
            context.read<GovernoratesCubit>().selectGovernorate(spinnerItem.id.toString());
          },
        );
      },
    );
  }
}
