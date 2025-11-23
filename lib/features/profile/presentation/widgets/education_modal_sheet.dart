import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:graduation_project/features/profile/domain/entities/education.dart';
import 'package:graduation_project/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:intl/intl.dart';
import 'package:file_picker/file_picker.dart';

class EducationModalSheet extends StatefulWidget {
  const EducationModalSheet({super.key});

  @override
  State<EducationModalSheet> createState() => _EducationModalSheetState();
}

class _EducationModalSheetState extends State<EducationModalSheet> {
  final TextEditingController _institutionController = TextEditingController();
  final TextEditingController _degreeController = TextEditingController();
  final TextEditingController _fieldOfStudyController = TextEditingController();
  final TextEditingController _gpaController = TextEditingController();
  final TextEditingController _activityItemController = TextEditingController();

  final List<String> _activitiesList = [];

  DateTime? _startDate;
  DateTime? _endDate;
  File? _graduationCertificate;
  File? _academicRecord;

  void _addActivity() {
    if (_activityItemController.text.trim().isNotEmpty) {
      setState(() {
        _activitiesList.add(_activityItemController.text.trim());
        _activityItemController.clear();
      });
    }
  }

  void _removeActivity(int index) {
    setState(() {
      _activitiesList.removeAt(index);
    });
  }

  Future<void> _pickFile(bool isCertificate) async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf', 'jpg', 'png', 'doc'],
    );

    if (result != null) {
      setState(() {
        if (isCertificate) {
          _graduationCertificate = File(result.files.single.path!);
        } else {
          _academicRecord = File(result.files.single.path!);
        }
      });
    }
  }

  void _onSave() {
    if (_institutionController.text.isEmpty ||
        _degreeController.text.isEmpty ||
        _fieldOfStudyController.text.isEmpty ||
        _startDate == null ||
        _endDate == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please fill in required fields")),
      );
      return;
    }

    final newEducation = Education(
      id: DateTime.now().toString(),
      institutionName: _institutionController.text,
      degreeType: _degreeController.text,
      fieldOfStudy: _fieldOfStudyController.text,
      startDate: _startDate!,
      endDate: _endDate!,
      gpa: _gpaController.text.isNotEmpty ? _gpaController.text : null,
      activities: _activitiesList,
      graduationCertificate: _graduationCertificate,
      academicRecord: _academicRecord,
    );

    context.read<ProfileCubit>().addEducation(newEducation);
    Navigator.pop(context);
  }

  @override
  void dispose() {
    _institutionController.dispose();
    _degreeController.dispose();
    _fieldOfStudyController.dispose();
    _gpaController.dispose();
    _activityItemController.dispose();
    super.dispose();
  }

  Future<void> _pickDate(bool isStart) async {
    DateTime initial = isStart
        ? (_startDate ?? DateTime.now())
        : (_endDate ?? DateTime.now());

    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      builder: (BuildContext builder) {
        return SizedBox(
          height: 250.h,
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  CupertinoButton(
                    child: const Text('Cancel'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  CupertinoButton(
                    child: const Text('Done'),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Expanded(
                child: CupertinoDatePicker(
                  initialDateTime: initial,
                  mode: CupertinoDatePickerMode.monthYear,
                  minimumDate: DateTime(1980),
                  maximumDate: DateTime.now().add(
                    const Duration(days: 365 * 5),
                  ),
                  onDateTimeChanged: (DateTime newDate) {
                    setState(() {
                      if (isStart) {
                        _startDate = newDate;
                      } else {
                        _endDate = newDate;
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormat = DateFormat('MMM yyyy');

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        height: 0.9.sh,
        width: 1.sw,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        ),
        child: Column(
          children: [
            SizedBox(height: 12.h),
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Add Education',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            SizedBox(height: 4.h),
            Text(
              'Add details about your academic background.',
              style: TextStyle(fontSize: 12.sp, color: Colors.grey[600]),
            ),
            SizedBox(height: 20.h),

            Expanded(
              child: ListView(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                children: [
                  _buildLabel("Institution Name"),
                  _buildTextField(
                    controller: _institutionController,
                    hint: "e.g. Stanford University",
                    icon: Icons.school_outlined,
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel("Degree"),
                  _buildTextField(
                    controller: _degreeController,
                    hint: "e.g. Bachelor's, Master's",
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel("Field of Study"),
                  _buildTextField(
                    controller: _fieldOfStudyController,
                    hint: "e.g. Computer Science, Design",
                  ),
                  SizedBox(height: 16.h),

                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("Start Date"),
                            GestureDetector(
                              onTap: () => _pickDate(true),
                              child: _buildDateDisplay(
                                _startDate,
                                dateFormat,
                                "Start Date",
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 12.w),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            _buildLabel("End Date (or Expected)"),
                            GestureDetector(
                              onTap: () => _pickDate(false),
                              child: _buildDateDisplay(
                                _endDate,
                                dateFormat,
                                "End Date",
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel("GPA (Optional)"),
                  _buildTextField(
                    controller: _gpaController,
                    hint: "e.g. 3.8/4.0",
                  ),
                  SizedBox(height: 16.h),

                  _buildLabel("Activities & Achievements (Optional)"),
                  Row(
                    children: [
                      Expanded(
                        child: _buildTextField(
                          controller: _activityItemController,
                          hint: "Add society, award, etc...",
                          onSubmitted: (_) => _addActivity(),
                        ),
                      ),
                      SizedBox(width: 8.w),
                      IconButton(
                        onPressed: _addActivity,
                        style: IconButton.styleFrom(
                          backgroundColor: Colors.black87,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                        ),
                        icon: const Icon(Icons.add, color: Colors.white),
                      ),
                    ],
                  ),
                  SizedBox(height: 12.h),

                  if (_activitiesList.isNotEmpty)
                    Container(
                      padding: EdgeInsets.all(12.w),
                      decoration: BoxDecoration(
                        color: Colors.grey[50],
                        borderRadius: BorderRadius.circular(12.r),
                        border: Border.all(color: Colors.grey[200]!),
                      ),
                      child: Column(
                        children: _activitiesList.asMap().entries.map((entry) {
                          int idx = entry.key;
                          String val = entry.value;
                          return Padding(
                            padding: EdgeInsets.only(bottom: 8.h),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: EdgeInsets.only(top: 6.h),
                                  child: Icon(
                                    Icons.circle,
                                    size: 6.sp,
                                    color: Colors.black54,
                                  ),
                                ),
                                SizedBox(width: 8.w),
                                Expanded(
                                  child: Text(
                                    val,
                                    style: TextStyle(
                                      fontSize: 13.sp,
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () => _removeActivity(idx),
                                  child: Padding(
                                    padding: EdgeInsets.all(4.w),
                                    child: Icon(
                                      Icons.close,
                                      size: 16.sp,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),

                  SizedBox(height: 16.h),

                  _buildLabel("Attachments"),
                  _buildFileUpload(
                    "Graduation Certificate",
                    _graduationCertificate,
                    () => _pickFile(true),
                    () => setState(() => _graduationCertificate = null),
                  ),
                  SizedBox(height: 12.h),
                  _buildFileUpload(
                    "Academic Record / Transcript",
                    _academicRecord,
                    () => _pickFile(false),
                    () => setState(() => _academicRecord = null),
                  ),

                  SizedBox(height: 40.h),
                ],
              ),
            ),

            Padding(
              padding: EdgeInsets.all(24.w),
              child: SizedBox(
                width: double.infinity,
                height: 50.h,
                child: ElevatedButton(
                  onPressed: _onSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    "Save Education",
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDateDisplay(DateTime? date, DateFormat fmt, String placeholder) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 14.h),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            date == null ? placeholder : fmt.format(date),
            style: TextStyle(
              color: date == null ? Colors.grey[500] : Colors.black87,
              fontSize: 14.sp,
            ),
          ),
          Icon(Icons.calendar_today, size: 16.sp, color: Colors.grey[600]),
        ],
      ),
    );
  }

  Widget _buildFileUpload(
    String title,
    File? file,
    VoidCallback onUpload,
    VoidCallback onRemove,
  ) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12.r),
        color: Colors.white,
      ),
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.w),
            decoration: BoxDecoration(
              color: Colors.grey[100],
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(Icons.attach_file, color: Colors.grey[700]),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 12.sp,
                    color: Colors.grey[600],
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 4.h),
                Text(
                  file != null ? file.path.split('/').last : "No file selected",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: file != null ? Colors.black87 : Colors.grey[400],
                    fontWeight: file != null
                        ? FontWeight.w600
                        : FontWeight.normal,
                  ),
                ),
              ],
            ),
          ),
          if (file == null)
            TextButton(onPressed: onUpload, child: const Text("Upload"))
          else
            IconButton(
              onPressed: onRemove,
              icon: const Icon(Icons.close, color: Colors.red),
            ),
        ],
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: EdgeInsets.only(bottom: 6.h),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          color: Colors.grey[800],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    IconData? icon,
    Function(String)? onSubmitted,
  }) {
    return TextField(
      controller: controller,
      onSubmitted: onSubmitted,
      style: TextStyle(fontSize: 14.sp),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14.sp),
        contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
        prefixIcon: icon != null
            ? Icon(icon, size: 20.sp, color: Colors.grey[500])
            : null,
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: BorderSide(color: Colors.grey[300]!),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12.r),
          borderSide: const BorderSide(color: Colors.black87, width: 1.5),
        ),
      ),
    );
  }
}
