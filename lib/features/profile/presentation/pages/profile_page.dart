import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:graduation_project/core/usecasesAbstract/no_params.dart';
import 'package:graduation_project/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:graduation_project/features/profile/presentation/widgets/custom_text_field.dart';
import 'package:graduation_project/features/profile/presentation/widgets/segmented_progress_bar.dart';

class ProfilePage extends StatelessWidget {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();

  ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.white,
        title: Text("Make your Profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              await serviceLocator.get<AuthCubit>().signOut.call(NoParams());
              if (context.mounted) {
                context.go("/");
              }
            },
            icon: Icon(Icons.exit_to_app),
          ),
        ],
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: .all(16),
            child: PageView(
              reverse: false,
              physics: NeverScrollableScrollPhysics(),

              controller: context.read<ProfileCubit>().pageController,
              children: [
                FirstPage(
                  nameController: nameController,
                  locationController: locationController,
                  emailController: emailController,
                  phoneController: phoneController,
                ),
                SecondPage(),
                ThirdPage(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class FirstPage extends StatelessWidget {
  const FirstPage({
    super.key,
    required this.nameController,
    required this.locationController,
    required this.emailController,
    required this.phoneController,
  });

  final TextEditingController nameController;
  final TextEditingController locationController;
  final TextEditingController emailController;
  final TextEditingController phoneController;

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SegmentedProgressBar(progress: 0.25),
            SizedBox(height: 20.h),
            Text(
              "Let's start with the\n Basics",
              style: TextStyle(fontSize: 32.r, fontWeight: .bold),
            ),
            Text(
              "This information will be visiable to recruiters.",
              style: TextStyle(fontSize: 16.r, color: Color(0xff7b8594)),
            ),
            SizedBox(height: 20.h),

            Row(
              crossAxisAlignment: .center,
              children: [
                BlocBuilder<ProfileCubit, ProfileState>(
                  builder: (context, state) {
                    return InkWell(
                      onTap: () {
                        context.read<ProfileCubit>().pickImage();
                        print(state.toString());
                      },
                      borderRadius: BorderRadius.circular(50),
                      child: state.image == null
                          ? DottedBorder(
                              options: CircularDottedBorderOptions(
                                dashPattern: [5, 5],
                                strokeWidth: 2,
                                color: Color(0xffccd6e1),
                              ),
                              child: Container(
                                width: 70.w,
                                height: 70.h,

                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xfff1f5f9),
                                ),
                                child: Center(
                                  child: SvgPicture.asset(
                                    colorFilter: ColorFilter.mode(
                                      Color(0xff67768d),
                                      .srcIn,
                                    ),
                                    "assets/icons/camera_add.svg",
                                  ),
                                ),
                              ),
                            )
                          : Container(
                              width: 70.w,
                              height: 70.h,

                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Color(0xfff1f5f9),
                              ),
                              child: ClipOval(
                                child: Image.file(state.image!, fit: .fill),
                              ),
                            ),
                    );
                  },
                ),
                SizedBox(width: 25.w),
                Column(
                  children: [
                    Text(
                      "Upload Photo",
                      style: TextStyle(fontSize: 18.r, fontWeight: .bold),
                    ),
                    Text(
                      "Max file size: 5MB",
                      style: TextStyle(
                        fontSize: 14.r,
                        color: Color(0xff7b8594),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            CustomTextField(
              controller: nameController,
              title: "Full Name",
              hint: "Enter your full name",
            ),
            CustomTextField(
              controller: locationController,
              title: "Location",
              hint: "e.g., Riyadh, SA",
            ),
            CustomTextField(
              controller: emailController,
              title: "Email Address",
              hint: "Enter your email",
            ),
            CustomTextField(
              controller: phoneController,
              title: "Phone Number",
              hint: "(123) 456-7890",
            ),
            SizedBox(height: 20.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(1.sw, 60.h),
                backgroundColor: Color(0xff135bec),
              ),
              onPressed: () => context.read<ProfileCubit>().nextPage(),
              child: Text(
                "Continue to Experience",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SegmentedProgressBar(progress: 0.5),
            SizedBox(height: 20.h),

            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  padding: EdgeInsets.all(16.w),
                  decoration: BoxDecoration(
                    color: const Color(0xFFDBEafe),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: const Color(0xFFBFDBFE)),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                          Column(
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
                                  color: Color(0xff4d5765),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 12.h),
                      SizedBox(
                        width: double.infinity,
                        height: 40.h,
                        child: ElevatedButton(
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xff135bec),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.r),
                            ),
                          ),
                          child: const Text(
                            "Add a Video Intro",
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Work Experience",
                  style: TextStyle(fontSize: 24.r, fontWeight: .bold),
                ),

                CircleAvatar(
                  backgroundColor: Color(0xffe5e7eb),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                color: Color(0xffd1d5db),
                dashPattern: [10, 7],
                strokeWidth: 2,
                strokeCap: .round,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "Your work experiences are displayed here",
                        style: TextStyle(fontWeight: .w500),
                      ),
                      Text("add your past roles to show your expertise"),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: 24.h),
            Row(
              mainAxisAlignment: .spaceBetween,
              children: [
                Text(
                  "Education",
                  style: TextStyle(fontSize: 24.r, fontWeight: .bold),
                ),

                CircleAvatar(
                  backgroundColor: Color(0xffe5e7eb),
                  child: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.add, color: Colors.black),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10.h),
            DottedBorder(
              options: RoundedRectDottedBorderOptions(
                radius: Radius.circular(12.r),
                color: Color(0xffd1d5db),
                dashPattern: [10, 7],
                strokeWidth: 2,
                strokeCap: .round,
              ),
              child: SizedBox(
                width: 1.sw,
                height: 200.h,
                child: Center(
                  child: Column(
                    mainAxisAlignment: .center,
                    children: [
                      Text(
                        "No Education Added",
                        style: TextStyle(fontWeight: .w500),
                      ),
                      Text("add your degrees and certifications"),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(1.sw, 60.h),
                backgroundColor: Color(0xff135bec),
              ),
              onPressed: () => context.read<ProfileCubit>().nextPage(),
              child: Text(
                "Continue to Introduction",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.read<ProfileCubit>().previousPage(),

              child: Text("go back"),
            ),
          ],
        ),
      ),
    );
  }
}

class ThirdPage extends StatelessWidget {
  const ThirdPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ScrollConfiguration(
      behavior: const ScrollBehavior().copyWith(overscroll: false),

      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: .start,
          crossAxisAlignment: .start,
          children: [
            SegmentedProgressBar(progress: 1),
            SizedBox(height: 20.h),
            SkillsEditor(),

            SizedBox(height: 32.h),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                minimumSize: Size(1.sw, 60.h),
                backgroundColor: Color(0xff135bec),
              ),
              onPressed: () => context.read<ProfileCubit>().nextPage(),
              child: Text(
                "Continue to Introduction",
                style: TextStyle(color: Colors.white),
              ),
            ),
            ElevatedButton(
              onPressed: () => context.read<ProfileCubit>().previousPage(),

              child: Text("go back"),
            ),
          ],
        ),
      ),
    );
  }
}

class SkillsEditor extends StatelessWidget {
  SkillsEditor({super.key});

  final List<String> _availableSkills = [
    'Flutter',
    'Dart',
    'Java',
    'Kotlin',
    'Swift',
    'Objective-C',
    'Python',
    'JavaScript',
    'TypeScript',
    'React',
    'Node.js',
    'Git',
    'Firebase',
    'AWS',
    'Docker',
    'Kubernetes',
    'SQL',
    'NoSQL',
    'GraphQL',
    'REST API',
    'Agile',
    'Scrum',
    'Teamwork',
    'Communication',
    'Problem Solving',
    'Leadership',
    'UI/UX Design',
    'Figma',
    'Adobe XD',
    'Jira',
  ];

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ProfileCubit>();

    return Container(
      width: 1.sw,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(16.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Skills", style: TextStyle(color: Color(0xff878787))),
                CircleAvatar(
                  backgroundColor: Colors.grey[300],
                  child: IconButton(
                    icon: const Icon(Icons.add),
                    color: Colors.black,
                    onPressed: () {
                      final currentState = context.read<ProfileCubit>().state;
                      showModalBottomSheet(
                        backgroundColor: Colors.white,
                        context: context,
                        isScrollControlled: true,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(25.0.r),
                          ),
                        ),
                        builder: (context) {
                          // Pass the existing cubit to the sheet
                          return BlocProvider.value(
                            value: cubit,
                            child: SkillPickerSheet(
                              allSkills: _availableSkills,
                              initialSelectedSkills: currentState.skills,
                            ),
                          );
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),

            BlocBuilder<ProfileCubit, ProfileState>(
              builder: (context, state) {
                if (state.skills.isEmpty) {
                  return Padding(
                    padding: EdgeInsets.only(top: 4.h),
                    child: Text(
                      'No skills added yet.',
                      style: TextStyle(color: Colors.grey[600]),
                    ),
                  );
                }

                return Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: state.skills.map((skill) {
                    return Chip(
                      label: Text(skill),
                      backgroundColor: Colors.blueAccent,
                      labelStyle: TextStyle(
                        color: Colors.white,
                        fontSize: 14.sp,
                      ),
                      deleteIcon: Icon(
                        Icons.close,
                        size: 16.r,
                        color: Colors.white,
                      ),
                      onDeleted: () {
                        cubit.removeSkill(skill);
                      },
                    );
                  }).toList(),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class SkillPickerSheet extends StatefulWidget {
  final List<String> allSkills;
  final List<String> initialSelectedSkills;

  const SkillPickerSheet({
    super.key,
    required this.allSkills,
    this.initialSelectedSkills = const [],
  });

  @override
  State<SkillPickerSheet> createState() => _SkillPickerSheetState();
}

class _SkillPickerSheetState extends State<SkillPickerSheet> {
  String _searchQuery = '';
  List<String> _filteredSkills = [];
  late List<String> selectedSkills;
  late final ProfileCubit cubit;

  @override
  void initState() {
    super.initState();
    _filteredSkills = List.from(widget.allSkills);
    selectedSkills = List.from(widget.initialSelectedSkills);
    cubit = context.read<ProfileCubit>();
  }

  @override
  void dispose() {
    cubit.updateSkills(selectedSkills);
    super.dispose();
  }

  void _filterSkills(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
      _filteredSkills = widget.allSkills.where((skill) {
        return skill.toLowerCase().contains(_searchQuery);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 0.65.sh,
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 50.w,
              height: 5.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Add Skill',
              style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.h),
            TextField(
              autofocus: false,
              onChanged: _filterSkills,
              decoration: InputDecoration(
                labelText: 'Search',
                hintText: 'e.g., Flutter',
                prefixIcon: const Icon(Icons.search, color: Colors.grey),
                filled: true,
                fillColor: Colors.grey.shade100,
                contentPadding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 20.w,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Expanded(
              child: _filteredSkills.isEmpty
                  ? Center(
                      child: Text(
                        'No skills found',
                        style: TextStyle(color: Colors.grey, fontSize: 16.sp),
                      ),
                    )
                  : ListView.separated(
                      itemCount: _filteredSkills.length,
                      separatorBuilder: (context, index) =>
                          Divider(height: 1.h, color: Colors.grey.shade200),
                      itemBuilder: (context, index) {
                        final skill = _filteredSkills[index];
                        final isSelected = selectedSkills.contains(skill);

                        return ListTile(
                          tileColor: isSelected
                              ? Colors.grey.shade50
                              : Colors.white,
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 4.h,
                            horizontal: 8.w,
                          ),
                          title: Text(
                            skill,
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: isSelected ? Colors.grey : Colors.black,
                            ),
                          ),
                          trailing: IconButton(
                            onPressed: () {
                              setState(() {
                                if (isSelected) {
                                  selectedSkills.remove(skill);
                                } else {
                                  selectedSkills.add(skill);
                                }
                              });
                            },
                            icon: Icon(
                              isSelected
                                  ? Icons.check_circle
                                  : Icons.add_circle_outline,
                              color: isSelected ? Colors.green : Colors.blue,
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
