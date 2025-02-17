import 'package:expense_tracker/presentation/dashboard/page/dashboard.dart';
import 'package:expense_tracker/presentation/items_list/page/item_list_page.dart';
import 'package:go_router/go_router.dart';
import 'package:googleapis/gkehub/v1.dart';

import '../presentation/dashboard/bloc/graph_bloc/graph_bloc.dart';
import '../presentation/item_details/page/expense_details.dart';
import '../presentation/landing/landing.dart';
import 'error_screen.dart';

class RouteGenerator {
  static final GoRouter router = GoRouter(
    errorBuilder: (context, state) {
      return const ErrorPage();
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) {
          return const Dashboard();
        },
        routes: [
          GoRoute(
            path: ItemListPage.path,
            builder: (context, state) {
              final graphBloc = state.extra as GraphBloc;
              return ItemListPage(
                graphBloc: graphBloc,
              );
            },
            routes: [
              GoRoute(
                path: "${ExpenseDetailsPage.path}/:date",
                builder: (context, state) {
                  final dateString = state.pathParameters['date']!;
                  final date = DateTime.parse(dateString);
                  final graphBloc = state.extra as GraphBloc;
                  return ExpenseDetailsPage(
                    dateTime: date,
                    graphBloc: graphBloc,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
