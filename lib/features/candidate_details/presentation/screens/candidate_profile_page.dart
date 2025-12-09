import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:get_it/get_it.dart';
import 'package:graduation_project/features/ai_analysis/presentation/screens/ai_analysis_screen.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/contact_section_widget.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/profile_header.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/profile_history_widget.dart';
import 'package:graduation_project/features/candidate_details/presentation/screens/components/profile_summary_widget.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../cubit/candidate_details_cubit.dart';
import '../cubit/candidate_details_state.dart';
import '../../domain/entities/candidate_profile_entity.dart';

class CandidateProfilePage extends StatelessWidget {
  final String candidateId;

  const CandidateProfilePage({super.key, required this.candidateId});

  @override
  Widget build(BuildContext context) {
    final companyId = Supabase.instance.client.auth.currentUser?.id;

    if (companyId == null) {
      return const Scaffold(
        body: Center(child: Text("Please login as company")),
      );
    }

    return BlocProvider(
      create: (context) =>
          GetIt.I<CandidateProfileCubit>()..loadProfile(candidateId, companyId),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Candidate Profile"),
          actions: [
            // زر المفضلة يبقى هنا لأنه يتفاعل مباشرة مع الـ AppBar
            BlocBuilder<CandidateProfileCubit, CandidateProfileState>(
              builder: (context, state) {
                return state.maybeWhen(
                  loaded: (profile) {
                    return IconButton(
                      icon: Icon(
                        profile.isBookmarked
                            ? Icons.bookmark
                            : Icons.bookmark_border,
                        color: profile.isBookmarked ? Colors.grey : Colors.blue,
                      ),
                      onPressed: () {
                        context.read<CandidateProfileCubit>().toggleBookmark(
                          profile.id,
                          companyId,
                        );
                      },
                    );
                  },
                  orElse: () => const SizedBox(),
                );
              },
            ),
          ],
        ),
        body: BlocConsumer<CandidateProfileCubit, CandidateProfileState>(
          listener: (context, state) {
            state.whenOrNull(
              error: (msg) => ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(msg), backgroundColor: Colors.red),
              ),
            );
          },
          builder: (context, state) {
            return state.maybeWhen(
              loading: () => const Center(child: CircularProgressIndicator()),
              unlocking: () => const Center(
                child: CircularProgressIndicator(color: Colors.green),
              ),
              loaded: (profile) =>
                  _buildMainContent(context, profile, companyId),
              orElse: () => const SizedBox(),
            );
          },
        ),
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    CandidateProfileEntity profile,
    String companyId,
  ) {
    // 1. تجهيز البيانات للكارد
    final fullName = "${profile.firstName} ${profile.lastName}";

    // تحويل القائمة ["Dart", "Flutter"] إلى نص "Dart, Flutter"
    final skillsString = profile.skills.isNotEmpty
        ? profile.skills.join(", ")
        : "No skills listed";

    return SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 1. الرأس
          ProfileHeaderr(profile: profile),
          Gap(20.h),

          // ✅✅ AI Matching Score Card ✅✅
          AiScoreCard(
            candidateName: fullName,
            skills: skillsString,
            currentJobTitle: profile.jobTitle,

            // ملاحظة: هنا تحدد المسمى الوظيفي الذي تقارن المرشح به.
            // يمكنك تغييره حسب ما تبحث عنه الشركة، أو جعله ثابتاً للتجربة.
            targetJobTitle: "Software Engineer",
          ),

          Gap(20.h),

          // 2. قسم الاتصال والقفل
          ContactSectionWidget(profile: profile, companyId: companyId),
          Gap(20.h),

          // 3. الملخص
          ProfileSummaryWidget(profile: profile),
          Gap(20.h),

          // 4. السجل
          ProfileHistoryWidget(profile: profile),

          Gap(40.h),
        ],
      ),
    );
  }
}
