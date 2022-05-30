import 'dart:async';

typedef Predicate<T> = bool Function(T);
typedef Apply<T> = T Function(T);

mixin Repository<Model> {
  FutureOr<List<Model>> findAll({ Predicate<Model>? predicate });
  FutureOr<Model?> findOne(Predicate<Model> predicate);

  FutureOr<void> insert(List<Model> models);
  FutureOr<void> delete(Predicate<Model> predicate);
  FutureOr<void> update(Predicate<Model> predicate, Apply<Model> apply);
}