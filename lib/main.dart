import 'package:budget_advisor/home_screen.dart';
import 'package:budget_advisor/model/transaction.dart';
import 'package:budget_advisor/repository/repository.dart';
import 'package:budget_advisor/repository/transaction_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  Widget app() {
    return MultiRepositoryProvider(
        providers: [
          RepositoryProvider<Repository<Transaction>>.value(value: TransactionRepository())
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          home: const HomeScreen(),
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return app();
  }
}