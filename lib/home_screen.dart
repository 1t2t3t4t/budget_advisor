import 'package:budget_advisor/budget_advice_bloc.dart';
import 'package:budget_advisor/budget_advise_view.dart';
import 'package:budget_advisor/budget_input_bloc.dart';
import 'package:budget_advisor/budget_input_view.dart';
import 'package:budget_advisor/model/transaction.dart';
import 'package:budget_advisor/repository/repository.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<BudgetAdviceBloc>(
            create: (context) =>
                BudgetAdviceBloc(BudgetAdviceState(15000, 0.5)),
          ),
          BlocProvider<BudgetInputBloc>(
              create: (context) => BudgetInputBloc(
                  BudgetInputState(0), context.read<Repository<Transaction>>()))
        ],
        child: Scaffold(
            appBar: const CupertinoNavigationBar(
              middle: Text("Budget Advisor"),
            ),
            body: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: const [
                  BudgetAdviceView(),
                  BudgetInputView(),
                  Spacer()
                ],
              ),
            )));
  }
}
