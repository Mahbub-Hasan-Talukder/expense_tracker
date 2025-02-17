import 'package:dartz/dartz.dart';
import 'package:expense_tracker/data/model/expense_details_model.dart';
import 'package:sqflite/sqflite.dart';

import '../database_controller.dart';
import 'fetch_expense_database_service.dart';

class FetchExpenseDataSource {
  Future<Either<String, List<ExpenseDetailsModel>>> readItems(
      DateTime date) async {
    try {
      Database database = await DatabaseController().getDatabase(
        tableName: 'items',
      );

      late List<Map<String, dynamic>> results;
      results = await FetchExpenseDatabaseService().readData(database, date);
      List<ExpenseDetailsModel> list = [];
      for (var data in results) {
        list.add(ExpenseDetailsModel.fromJson(data));
      }
      return Right(list);
    } on Exception catch (e) {
      return Left(e.toString());
    }
  }
}
