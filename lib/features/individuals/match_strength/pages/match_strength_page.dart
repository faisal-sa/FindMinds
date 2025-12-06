import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/theme/theme.dart';
import 'package:graduation_project/features/individuals/match_strength/cubit/match_strength_cubit.dart';
import 'package:graduation_project/features/individuals/match_strength/cubit/match_strength_state.dart';
class MatchStrengthPage extends StatefulWidget {
  final String jobTitle;

  const MatchStrengthPage({super.key, required this.jobTitle});

  @override
  State<MatchStrengthPage> createState() => _MatchStrengthPageState();
}

class _MatchStrengthPageState extends State<MatchStrengthPage> {
  @override
  Widget build(BuildContext context) {
    // Light grey background similar to screenshot
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FA), 
      appBar: AppBar(
        backgroundColor: const Color(0xFFF5F7FA),
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Match Strength",
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20, color: Color(0xFF1E293B)),
          onPressed: () => context.pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications_none, color: Color(0xFF1E293B)),
            onPressed: () {},
          )
        ],
      ),
      body: BlocBuilder<MatchStrengthCubit, MatchStrengthState>(
        builder: (context, state) {
          if (state is MatchStrengthLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is MatchStrengthError) {
            return Center(child: Text(state.message));
          } else if (state is MatchStrengthLoaded) {
            return _buildContent(context, state);
          }
          return const Center(child: Text("Initializing..."));
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, MatchStrengthLoaded state) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
        Center(
          child: Text(
                      widget.jobTitle.isNotEmpty ? widget.jobTitle : "General Profile",
                      style:  TextStyle(
                        fontSize: 24.r,
                    
                        fontWeight: FontWeight.bold,
                      ),
                    ),
        ),
          
          const SizedBox(height: 24),

          // 2. Score Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
           decoration: BoxDecoration(
        color: AppColors.bluePrimary,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: AppColors.bluePrimary.withAlpha(77),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
        gradient: const LinearGradient(
          colors: [Color(0xFF2563EB), Color(0xFF1D4ED8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${state.score}% Match",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Icon(Icons.auto_awesome, color: Colors.white70, size: 28),
                  ],
                ),
                const SizedBox(height: 4),
                const Text(
                  "AI-Powered Analysis",
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
                const SizedBox(height: 24),
                
                // Animated Progress Bar
                Stack(
                  children: [
                    Container(
                      height: 8,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(4),
                      ),
                    ),
                    TweenAnimationBuilder<double>(
                      tween: Tween<double>(begin: 0, end: state.score / 100),
                      duration: const Duration(milliseconds: 1500),
                      curve: Curves.easeOutExpo,
                      builder: (context, value, _) {
                        return Container(
                          height: 8,
                          width: MediaQuery.of(context).size.width * value * 0.75, // Adjust width constraint
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(4),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),
          const Text(
            "Strengths",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Color(0xFF1E293B)
            ),
          ),
          const SizedBox(height: 12),

          // 3. Strengths List
          ...state.strengths.map((s) => _buildStrengthCard(s)),

          const SizedBox(height: 24),
          const Text(
            "Areas for Improvement",
            style: TextStyle(
              fontSize: 18, 
              fontWeight: FontWeight.bold, 
              color: Color(0xFF1E293B)
            ),
          ),
          const SizedBox(height: 12),

          // 4. Improvements List
          ...state.improvements.map((i) => _buildImprovementCard(i['issue']!, i['action']!)),
          
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget _buildStrengthCard(String text) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          const CircleAvatar(
            radius: 12,
            backgroundColor: Color(0xFFDCFCE7), // Light green
            child: Icon(Icons.check, size: 14, color: Color(0xFF16A34A)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(
                color: Color(0xFF334155),
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImprovementCard(String issue, String actionText) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           const Padding(
             padding: EdgeInsets.only(top: 2.0),
             child: CircleAvatar(
              radius: 12,
              backgroundColor: Color(0xFFFFEDD5), // Light Orange
              child: Icon(Icons.priority_high, size: 14, color: Color(0xFFEA580C)),
                     ),
           ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  issue,
                  style: const TextStyle(
                    color: Color(0xFF334155),
                    fontWeight: FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  actionText,
                  style: const TextStyle(
                    color: Color(0xFF2563EB), // Blue link color
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}