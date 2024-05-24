import 'package:edspert/src/presentation/pages/discussion_screen.dart';
import 'package:edspert/src/presentation/pages/home_screen.dart';
import 'package:edspert/src/presentation/pages/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/home_nav/home_nav_cubit.dart';

class HomeNavScreen extends StatelessWidget {
  const HomeNavScreen({super.key});

  @override
  Widget build(BuildContext context) {
    List<Widget> homeBodyWidgets = [
      const HomeScreen(),
      const DiscussionScreen(),
      ProfilePage()
    ];
    return BlocBuilder<HomeNavCubit, HomeNav>(
      builder: (context, selectedNav) {
        return Scaffold(
          body: homeBodyWidgets[selectedNav.index],
          bottomNavigationBar: BottomNavigationBar(
            onTap: (int index) {
              context.read<HomeNavCubit>().navTo(HomeNav.values[index]);
            },
            currentIndex: selectedNav.index,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                label: 'Home',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.message),
                label: 'Discussion',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          ),
        );
      },
    );
  }
}