import 'package:bloc/bloc.dart';

abstract class BudgetAdviceBlocEvent {
  factory BudgetAdviceBlocEvent.changeBudget(
          double monthlyAllocation, double weekDayAllocation) =>
      ChangeBudgetEvent(monthlyAllocation, weekDayAllocation);
}

class ChangeBudgetEvent implements BudgetAdviceBlocEvent {
  double monthlyBudget;
  double weekDayAllocation;

  ChangeBudgetEvent(this.monthlyBudget, this.weekDayAllocation);
}

class BudgetAdviceState {
  double get weekBudget => weekDayBudget + weekEndBudget;

  double monthlyBudget;
  double weekDayAllocation;

  double get weeklyBudget => monthlyBudget / 4;
  double get weekDayBudget => weeklyBudget * weekDayAllocation;
  double get weekEndBudget => weeklyBudget - weekDayBudget;

  double get weekDayDailyBudget => weekDayBudget / 5;
  double get weekEndDailyBudget => weekEndBudget / 2;

  BudgetAdviceState(this.monthlyBudget, this.weekDayAllocation);
}

class BudgetAdviceBloc extends Bloc<BudgetAdviceBlocEvent, BudgetAdviceState> {
  BudgetAdviceBloc(super.initialState) {
    on<ChangeBudgetEvent>((event, emit) {
      emit(BudgetAdviceState(event.monthlyBudget, event.weekDayAllocation));
    });
  }
}
