import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:graduation_project/features/candidate_details/domain/entities/candidate_profile_entity.dart';

class ProfileHeaderr extends StatelessWidget {
  final CandidateProfileEntity profile;

  const ProfileHeaderr({super.key, required this.profile});

  @override
  Widget build(BuildContext context) {
    String salaryText = "";
    if (profile.minSalary != null) {
      salaryText = "${profile.minSalary}";
      if (profile.maxSalary != null) {
        salaryText += " - ${profile.maxSalary}";
      }
      salaryText += " ${profile.salaryCurrency ?? 'USD'}";
    }

    return Row(
      children: [
        CircleAvatar(
          radius: 40.r,
          backgroundImage: profile.avatarUrl != null
              ? NetworkImage(profile.avatarUrl!)
              : null,
          child: profile.avatarUrl == null
              ? const Icon(Icons.person, size: 40)
              : null,
        ),
        Gap(16.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${profile.firstName} ${profile.lastName}",
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
              ),
              Text(profile.jobTitle, style: TextStyle(color: Colors.grey[700])),
              if (profile.location != null)
                Text(
                  profile.location!,
                  style: TextStyle(color: Colors.grey[600], fontSize: 12.sp),
                ),
              if (salaryText.isNotEmpty) ...[
                Gap(4.h),
                Text(
                  salaryText,
                  style: const TextStyle(
                    color: Colors.green,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}
