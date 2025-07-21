import 'package:flutter_clean_architecture_1/features/profile/presentation/pages/all_users_page.dart';
import 'package:flutter_clean_architecture_1/features/profile/presentation/pages/detail_user_page.dart';
import 'package:go_router/go_router.dart';

class MyRouter {
  get router => GoRouter(
    initialLocation: "/",
    routes: [
      GoRoute(
        path: "/",
        name: "all_users",
        pageBuilder:
            (context, state) => NoTransitionPage(child: const AllUsersPage()),
        routes: [
          GoRoute(
            path: "detail-user",
            name: "detail_user",
            pageBuilder:
                (context, state) => NoTransitionPage(child:  DetailUserPage(
                  state.extra as int
                )),
          ),
        ],
      ),
    ],
  );
}
