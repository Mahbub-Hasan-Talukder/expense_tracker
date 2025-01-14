import 'dart:async';
import 'package:expense_tracker/domain/use_case/generate_report_use_case.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_event.dart';
import 'package:expense_tracker/presentation/dashboard/bloc/graph_bloc/graph_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../config/service_locator.dart';
import '../../../../domain/entity/expense_details_entity.dart';
import '../../page/dashboard.dart';

class GraphBloc extends Bloc<GraphEvent, GraphState> {
  GraphBloc() : super(InitialGraph()) {
    on<GraphEvent>(_showGraph);
  }

  FutureOr<void> _showGraph(GraphEvent event, Emitter<GraphState> emit) async {
    late (List<ExpenseDetailsEntity>?, String?) res;
    if (event.graphType == GraphType.daily) {
      res = await sl<GenerateReportUseCase>().getDailyReport();
    } else if (event.graphType == GraphType.monthly) {
      res = await sl<GenerateReportUseCase>().getMonthlyReport();
    } else if (event.graphType == GraphType.yearly) {
      res = await sl<GenerateReportUseCase>().getYearlyReport();
    }
    if (res.$2 != null) {
      emit(GraphStateFailed(errorMessage: res.$2!));
    } else {
      emit(GraphStateSuccess(graphType: event.graphType, itemList: res.$1!));
    }
  }
}
