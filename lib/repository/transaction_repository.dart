import 'dart:async';

import 'package:budget_advisor/model/transaction.dart';
import 'package:budget_advisor/repository/repository.dart';

class TransactionRepository implements Repository<Transaction> {
  final List<Transaction> _collections = [];

  @override
  FutureOr<void> delete(Predicate<Transaction> predicate) {
    _collections.removeWhere(predicate);
  }

  @override
  FutureOr<List<Transaction>> findAll({Predicate<Transaction>? predicate}) {
    return _collections
        .where((element) => predicate != null ? predicate(element) : true)
        .toList();
  }

  @override
  FutureOr<Transaction?> findOne(Predicate<Transaction> predicate) {
    return _collections.firstWhere(predicate);
  }

  @override
  FutureOr<void> insert(List<Transaction> models) {
    _collections.addAll(models);
  }

  @override
  FutureOr<void> update(
      Predicate<Transaction> predicate, Apply<Transaction> apply) {
    for (final model in _collections) {
      if (predicate(model)) {
        apply(model);
      }
    }
  }
}
