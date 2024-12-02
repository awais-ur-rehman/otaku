import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:otaku/logic/home_cubit/home_cubit.dart';

import '../../utils/colors/color.dart';

class ScaffoldWithNavBar extends StatelessWidget {
  /// Constructs an [ScaffoldWithNavBar].
  const ScaffoldWithNavBar({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('ScaffoldWithNavBar'));

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.sizeOf(context).height;
    return PopScope(
      canPop: false,
      // ignore: deprecated_member_use
      onPopInvoked: ((didPop) {
        _onTap(context, 0);
      }),
      child: Scaffold(
        backgroundColor: AppColors.black,
        body: navigationShell,
        bottomNavigationBar: Container(
          decoration: const BoxDecoration(
            color: AppColors.black,
            border: Border(
              top: BorderSide(
                color: AppColors.black,
                width: 1.5,
              ),
            ),
          ),
          child: NavigationBarTheme(
            data: NavigationBarThemeData(
              height: height * 0.07,
              labelTextStyle: WidgetStateProperty.resolveWith((states) {
                if (states.contains(WidgetState.selected)) {
                  return TextStyle(
                    fontFamily: 'MontserratMedium',
                    color: AppColors.lightPurple,
                    fontSize: MediaQuery.sizeOf(context).width * 0.028,
                    fontWeight: FontWeight.w700,
                  );
                }
                return TextStyle(
                  fontFamily: 'MontserratMedium',
                  color: AppColors.textPrimary,
                  fontSize: MediaQuery.sizeOf(context).width * 0.025,
                  fontWeight: FontWeight.w700,
                );
              }),
              indicatorColor: AppColors.primaryPurple.withOpacity(0.1),
              backgroundColor: AppColors.black,
              elevation: 0, // Removing the default elevation
            ),
            child: NavigationBar(
              onDestinationSelected: (index) => _onTap(context, index),
              selectedIndex: navigationShell.currentIndex,
              destinations: [
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/svgs/home.svg',
                    // ignore: deprecated_member_use
                    color: navigationShell.currentIndex == 0
                        ? AppColors.primaryPurple
                        : AppColors.textPrimary,
                    height: height * 0.025,
                  ),
                  label: 'Home',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/svgs/social.svg',
                    // ignore: deprecated_member_use
                    color: navigationShell.currentIndex == 1
                        ? AppColors.primaryPurple
                        : AppColors.textPrimary,
                    height: height * 0.025,
                  ),
                  label: 'Social',
                ),
                NavigationDestination(
                  icon: SvgPicture.asset(
                    'assets/svgs/forum.svg',
                    // ignore: deprecated_member_use
                    color: navigationShell.currentIndex == 2
                        ? AppColors.primaryPurple
                        : AppColors.textPrimary,
                    height: height * 0.025,
                  ),
                  label: 'Forum',
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }

  void _onTap(BuildContext context, int index) {
    if (index == 0) {
      context.read<HomeCubit>().loadAnime();
    }
    else if (index == 1) {
    }
    else if (index == 2) {

    }
    navigationShell.goBranch(
      index,
      initialLocation: true,
    );
  }
}
