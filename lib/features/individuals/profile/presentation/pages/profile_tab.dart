import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/temp/dashboard.dart';

class ProfileTab extends StatelessWidget {
  const ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserCubit, UserProfile>(
      builder: (context, user) {
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey.shade200,
                child: user.name != null
                    ? Text(
                        user.name![0],
                        style: const TextStyle(
                          fontSize: 40,
                          color: AppColors.textSub,
                        ),
                      )
                    : const Icon(Icons.person, size: 50, color: Colors.grey),
              ),
              const SizedBox(height: 16),
              Text(
                user.name ?? "New User",
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                user.name != null ? "Product Designer" : "No Title Yet",
                style: const TextStyle(color: AppColors.textSub),
              ),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () {},
                child: const Text("Edit Profile"),
              ),
            ],
          ),
        );
      },
    );
  }
}
