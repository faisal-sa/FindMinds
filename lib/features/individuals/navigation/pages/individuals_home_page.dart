import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theme/theme.dart';

class IndividualsHomePage extends StatelessWidget {
  final StatefulNavigationShell navigationShell;

  const IndividualsHomePage({super.key, required this.navigationShell});

 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bg,

      body: navigationShell,


    );
  }
}
