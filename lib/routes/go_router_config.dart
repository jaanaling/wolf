import 'package:wolf_survival/src/feature/main/model/actions.dart';
import 'package:wolf_survival/src/feature/main/model/articles.dart';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:wolf_survival/src/feature/main/presentation/action_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/article_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/calculator_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/diary_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/main_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/notes_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/resourse_screen.dart';
import 'package:wolf_survival/src/feature/main/presentation/trip_screen.dart';

import '../src/feature/splash/presentation/screens/splash_screen.dart';
import 'root_navigation_screen.dart';
import 'route_value.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final _homeNavigatorKey = GlobalKey<NavigatorState>();

GoRouter buildGoRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RouteValue.splash.path,
  routes: <RouteBase>[
    StatefulShellRoute.indexedStack(
      pageBuilder: (context, state, navigationShell) {
        return NoTransitionPage(
          child: RootNavigationScreen(navigationShell: navigationShell),
        );
      },
      branches: [
        StatefulShellBranch(
          navigatorKey: _homeNavigatorKey,
          routes: <RouteBase>[
            GoRoute(
              path: RouteValue.home.path,
              builder: (context, state) => MainScreen(key: UniqueKey()),
              routes: [
                GoRoute(
                  path: RouteValue.trip.path,
                  pageBuilder:
                      (context, state) =>
                          NoTransitionPage(child: TripScreen(key: UniqueKey())),
                  routes: [
                    GoRoute(
                      path: RouteValue.action.path,
                      pageBuilder:
                          (context, state) => NoTransitionPage(
                            child: ActionScreen(
                              key: UniqueKey(),
                              action: state.extra as UActions,
                            ),
                          ),
                    ),
                    GoRoute(
                      path: RouteValue.resourse.path,
                      pageBuilder:
                          (context, state) => NoTransitionPage(
                            child: ResourseScreen(key: UniqueKey()),
                          ),
                    ),
                    GoRoute(
                      path: RouteValue.notes.path,
                      pageBuilder:
                          (context, state) => NoTransitionPage(
                            child: NotesScreen(key: UniqueKey()),
                          ),
                    ),
                  ],
                ),
                GoRoute(
                  path: RouteValue.resourse.path,
                  pageBuilder:
                      (context, state) => NoTransitionPage(
                        child: ResourseScreen(key: UniqueKey()),
                      ),
                ),
                GoRoute(
                  path: RouteValue.calculator.path,
                  pageBuilder:
                      (context, state) => NoTransitionPage(
                        child: CalculatorScreen(key: UniqueKey()),
                      ),
                ),
                GoRoute(
                  path: RouteValue.diary.path,
                  pageBuilder:
                      (context, state) => NoTransitionPage(
                        child: DiaryScreen(key: UniqueKey()),
                      ),
                  routes: [
                    GoRoute(
                      path: RouteValue.article.path,
                      pageBuilder:
                          (context, state) => NoTransitionPage(
                            child: ArticleScreen(
                              key: UniqueKey(),
                              article: state.extra as Articles,
                            ),
                          ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      pageBuilder: (context, state, child) {
        return NoTransitionPage(
          child: CupertinoPageScaffold(
            backgroundColor: CupertinoColors.black,
            child: child,
          ),
        );
      },
      routes: <RouteBase>[
        GoRoute(
          path: RouteValue.splash.path,
          builder: (BuildContext context, GoRouterState state) {
            return const SplashScreen();
          },
        ),
      ],
    ),
  ],
);
