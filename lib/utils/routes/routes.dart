import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:otaku/presentation/auth_view/signup_view.dart';
import 'package:otaku/presentation/forum_view/forum_view.dart';
import 'package:otaku/presentation/home_view/home_detail_view.dart';
import 'package:otaku/presentation/home_view/home_view.dart';
import 'package:otaku/presentation/profile_setup_view/profile_setup_view.dart';
import 'package:otaku/presentation/social_view/social_view.dart';
import '../../data/model/anime_model.dart';
import '../../presentation/auth_view/login_view.dart';
import '../../presentation/splash_view/splash_view.dart';
import '../../presentation/widgets/cstm_bottom_nav_bar.dart';
import 'route_names.dart';

final _shellHomeNavigatorKey = GlobalKey<NavigatorState>();
final _shellSocialNavigatorKey = GlobalKey<NavigatorState>();
final _shellForumNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  navigatorKey: navigatorKey,
  routes: [
    StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            ScaffoldWithNavBar(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
              navigatorKey: _shellHomeNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.homeRoute,
                  pageBuilder: (context, state) =>
                  const MaterialPage(child: HomeView()),
                ),
              ]),
          StatefulShellBranch(
              navigatorKey: _shellSocialNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.socialRoute,
                  pageBuilder: (context, state) =>
                  const MaterialPage(child: SocialView()),
                ),
              ]),
          StatefulShellBranch(
              navigatorKey: _shellForumNavigatorKey,
              routes: <RouteBase>[
                GoRoute(
                  path: RouteNames.forumRoute,
                  pageBuilder: (context, state) =>
                  const MaterialPage(child: ForumView()),
                ),
              ]),
        ]),
    GoRoute(
      path: RouteNames.splashRoute,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      path: RouteNames.signupRoute,
      builder: (context, state) => const SignupView(),
    ),
    GoRoute(
      path: RouteNames.siginRoute,
      builder: (context, state) => const SignInView(),
    ),
    GoRoute(
      path: RouteNames.profileSetupRoute,
      builder: (context, state) => const ProfileSetupView(),
    ),
    GoRoute(
      path: RouteNames.animeDetailRoute,
      builder: (context, state) {
        final anime = state.extra as Anime;
        return AnimeDetailView(anime: anime);
      },
    ),
  ],
    initialLocation: RouteNames.splashRoute,
);