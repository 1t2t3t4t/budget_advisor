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

class _BudgetInputViewState extends State<BudgetInputView> with WidgetsBindingObserver {
  final TextEditingController _inputTextController = TextEditingController();
  final FocusNode _inputFocusNode = FocusNode();


  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    switch (state) {
      case AppLifecycleState.resumed:
        Future.delayed(const Duration(milliseconds: 100)).then((value) {
          if (_inputFocusNode.hasFocus) {
            _inputFocusNode.unfocus();
          }
          _inputFocusNode.requestFocus();
        });
        break;
      case AppLifecycleState.inactive:
        break;
      case AppLifecycleState.paused:
        if (_inputFocusNode.hasFocus) {
          _inputFocusNode.unfocus();
        }
        break;
      case AppLifecycleState.detached:
        break;
    }
  }

  Widget _inputWidgets(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextField(
            controller: _inputTextController,
            keyboardType: TextInputType.number,
            autofocus: true,
            focusNode: _inputFocusNode,
            onSubmitted: (text) {
              if (text.isNotEmpty) {
                final amount = double.parse(text);
                context.read<BudgetInputBloc>().add(BudgetInputAdd(amount));
              }
            },
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
