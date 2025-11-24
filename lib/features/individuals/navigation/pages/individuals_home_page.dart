import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/individuals/chat/presentation/pages/chats_tab.dart';
import 'package:graduation_project/features/individuals/insights/presentation/pages/insights_tab.dart';
import 'package:graduation_project/features/individuals/navigation/cubit/navigation_cubit.dart';
import 'package:graduation_project/features/individuals/profile/presentation/pages/profile_tab.dart';

class IndividualsHomePage extends StatelessWidget {
  const IndividualsHomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: const _AppBar(),
      body: BlocBuilder<NavigationCubit, int>(
        builder: (context, tabIndex) {
          return IndexedStack(
            index: tabIndex,
            children: const [InsightsTab(), ChatsTab(), ProfileTab()],
          );
        },
      ),
      bottomNavigationBar: BlocBuilder<NavigationCubit, int>(
        builder: (context, tabIndex) {
          return Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border(top: BorderSide(color: Colors.grey.shade200)),
            ),
            child: BottomNavigationBar(
              currentIndex: tabIndex,
              onTap: (index) => context.read<NavigationCubit>().setTab(index),
              backgroundColor: Colors.white,
              elevation: 0,
              selectedItemColor: AppColors.bluePrimary,
              unselectedItemColor: AppColors.textSub,
              selectedFontSize: 12,
              unselectedFontSize: 12,
              type: .fixed,
              items: const [
                BottomNavigationBarItem(
                  icon: Icon(Icons.bar_chart),
                  label: 'Insights',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.chat_bubble_outline),
                  label: 'Chats',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.person_outline),
                  label: 'Profile',
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  const _AppBar();

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color(0XFFf1f5f9),
      elevation: 0,
      scrolledUnderElevation: 0,
      title: Row(
        mainAxisAlignment: .end,
        children: [
          CircleAvatar(
            backgroundColor: AppColors.blueLight,
            child: Icon(Icons.person, color: AppColors.bluePrimary),
          ),
        ],
      ),
    );
  }
}
