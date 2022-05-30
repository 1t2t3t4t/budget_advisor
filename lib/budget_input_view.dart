import 'package:budget_advisor/budget_input_bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class BudgetInputView extends StatefulWidget {
  const BudgetInputView({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _BudgetInputViewState();
  }
}

class _BudgetInputViewState extends State<BudgetInputView> {
  final TextEditingController _inputTextController = TextEditingController();

  Widget _inputWidgets(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _inputTextController,
            keyboardType: TextInputType.number,
          ),
        ),
        CupertinoButton(
            onPressed: () {
              final amount = double.parse(_inputTextController.value.text);
              context.read<BudgetInputBloc>().add(BudgetInputAdd(amount));
            },
            child: const Text("Add"))
      ],
    );
  }

  Widget _infoDisplay(BuildContext context, BudgetInputState state) {
    return Text(
      "Total Usage: ${state.totalAmount.toStringAsFixed(2)}",
      style: Theme.of(context).textTheme.headline4,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BudgetInputBloc, BudgetInputState>(
      builder: (context, state) {
        return Column(
          children: [_inputWidgets(context), _infoDisplay(context, state)],
        );
      },
    );
  }
}
