import 'package:budget_advisor/model/transaction.dart';
import 'package:budget_advisor/repository/repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class BudgetInputEvent {}

class BudgetInputAdd implements BudgetInputEvent {
  final double amount;

  BudgetInputAdd(this.amount);
}

class BudgetInputState {
  final double totalAmount;

  BudgetInputState(this.totalAmount);
}

class BudgetInputBloc extends Bloc<BudgetInputEvent, BudgetInputState> {
  final Repository<Transaction> _transactionRepository;

  BudgetInputBloc(super.initialState, this._transactionRepository) {
    on<BudgetInputAdd>((event, emit) {
      _transactionRepository
          .insert([Transaction(event.amount, DateTime.now())]);
      _latestState().then(emit);
    });
  }

  Future<BudgetInputState> _latestState() async {
    final transactions = await _transactionRepository.findAll();
    return BudgetInputState(transactions
        .map((e) => e.amount)
        .reduce((value, element) => value + element));
  }
}
