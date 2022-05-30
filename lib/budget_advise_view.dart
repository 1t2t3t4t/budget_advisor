import 'package:budget_advisor/budget_advice_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetAdviceView extends StatelessWidget {
  const BudgetAdviceView({Key? key}) : super(key: key);

  Widget input(BuildContext context, BudgetAdviceState state) {
    final bloc = context.read<BudgetAdviceBloc>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
            keyboardType: TextInputType.number,
            decoration: InputDecoration(hintText: "${state.monthlyBudget}"),
            onChanged: (changes) {
              if (changes.isNotEmpty) {
                bloc.add(BudgetAdviceBlocEvent.changeBudget(
                    double.parse(changes), state.weekDayAllocation));
              }
            }),
        Slider(
          value: state.weekDayAllocation,
          onChanged: (changes) => bloc.add(BudgetAdviceBlocEvent.changeBudget(
              state.monthlyBudget, (changes * 100).floorToDouble() / 100.0)),
          min: 0.0,
          max: 1.0,
        ),
        Text(
          "Workday Allocation Rate ${(state.weekDayAllocation * 100).toStringAsFixed(2)}%",
          style: const TextStyle(fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetAdviceBloc, BudgetAdviceState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            input(context, state),
            const SizedBox(height: 16),
            Text("Weekday Budget: ${state.weekDayBudget.toStringAsFixed(2)}"),
            Text("Weekend Budget: ${state.weekEndBudget.toStringAsFixed(2)}"),
            Text(
                "Weekday Daily Budget: ${state.weekDayDailyBudget.toStringAsFixed(2)}"),
            Text(
                "Weekend Daily Budget: ${state.weekEndDailyBudget.toStringAsFixed(2)}")
          ],
        );
      },
    );
  }
}
