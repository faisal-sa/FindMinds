import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/widgets/segmented_progress_bar.dart';

class AboutMePage extends StatelessWidget {
  const AboutMePage({super.key});

  final List<String> _employmentOptions = const [
    "Full-time",
    "Part-time",
    "Remote",
    "CO-OP Training",
    "Internship",
    "Freelance",
  ];

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileCubit, ProfileState>(
      builder: (context, state) {
        final cubit = context.read<ProfileCubit>();

        return ScrollConfiguration(
          behavior: const ScrollBehavior().copyWith(overscroll: false),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SegmentedProgressBar(progress: 1),
                SizedBox(height: 20.h),

                Text(
                  "About Me",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),
                TextFormField(
                  initialValue: state.aboutMe,
                  maxLines: 4,
                  onChanged: cubit.updateAboutMe,
                  decoration: InputDecoration(
                    hintText: "Write a short professional summary...",
                    hintStyle: TextStyle(fontSize: 14.sp, color: Colors.grey),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFFBFDBFE)),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xFFBFDBFE)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                      borderSide: const BorderSide(color: Color(0xff135bec)),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                  ),
                ),
                SizedBox(height: 24.h),

                Text(
                  "Job Preferences",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                    color: Colors.black87,
                  ),
                ),
                SizedBox(height: 8.h),

                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: _employmentOptions.map((type) {
                    final isSelected = state.selectedEmploymentTypes.contains(
                      type,
                    );
                    return FilterChip(
                      label: Text(type),
                      selected: isSelected,
                      onSelected: (_) => cubit.toggleEmploymentType(type),

                      selectedColor: const Color(0xFFDBEafe),
                      checkmarkColor: const Color(0xff135bec),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.r),
                        side: BorderSide(
                          color: isSelected
                              ? const Color(0xff135bec)
                              : Colors.grey.shade300,
                        ),
                      ),
                      labelStyle: TextStyle(
                        color: isSelected
                            ? const Color(0xff135bec)
                            : Colors.black87,
                        fontSize: 12.sp,
                        fontWeight: isSelected
                            ? FontWeight.w600
                            : FontWeight.normal,
                      ),
                    );
                  }).toList(),
                ),

                SizedBox(height: 16.h),

                _buildCheckboxOption(
                  label: "I am willing to relocate",
                  value: state.canRelocate,
                  onChanged: (val) => cubit.updateRelocation(val ?? false),
                ),
                _buildCheckboxOption(
                  label: "I can start immediately",
                  value: state.canStartImmediately,
                  onChanged: (val) =>
                      cubit.updateStartImmediately(val ?? false),
                ),

                SizedBox(height: 24.h),

                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEafe),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: EdgeInsets.all(8.w),
                            decoration: const BoxDecoration(
                              color: Color(0xff135bec),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.videocam,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(width: 12.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "Stand Out to Employers",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                Text(
                                  "Record a 30-second video intro.",
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: const Color(0xff4d5765),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 16.h),
                      if (state.video == null)
                        SizedBox(
                          width: double.infinity,
                          height: 40.h,
                          child: ElevatedButton(
                            onPressed: () => cubit.pickVideo(),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xff135bec),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: const Text(
                              "Add a Video Intro",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        )
                      else
                        _buildVideoSelectedWidget(context, state.video!),
                    ],
                  ),
                ),

                SizedBox(height: 32.h),

                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size(1.sw, 60.h),
                    backgroundColor: const Color(0xff135bec),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                  ),
                  onPressed: () => cubit.nextPage(),
                  child: const Text(
                    "Continue to Introduction",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                SizedBox(height: 12.h),
                Center(
                  child: TextButton(
                    onPressed: () => cubit.previousPage(),
                    child: const Text("Go Back"),
                  ),
                ),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildCheckboxOption({
    required String label,
    required bool value,
    required Function(bool?) onChanged,
  }) {
    return InkWell(
      onTap: () => onChanged(!value),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 6.h),
        child: Row(
          children: [
            SizedBox(
              height: 24.h,
              width: 24.w,
              child: Checkbox(
                value: value,
                activeColor: const Color(0xff135bec),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(4.r),
                ),
                onChanged: onChanged,
              ),
            ),
            SizedBox(width: 12.w),
            Text(
              label,
              style: TextStyle(fontSize: 14.sp, color: Colors.black87),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildVideoSelectedWidget(BuildContext context, File videoFile) {
    String fileName = videoFile.path.split('/').last;
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Row(
        children: [
          const Icon(Icons.check_circle, color: Colors.green),
          SizedBox(width: 10.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Video Selected",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 13.sp,
                  ),
                ),
                Text(
                  fileName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 11.sp, color: Colors.grey),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () => context.read<ProfileCubit>().removeVideo(),
          ),
        ],
      ),
    );
  }
}
