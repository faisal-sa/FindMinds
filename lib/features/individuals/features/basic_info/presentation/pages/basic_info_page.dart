import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/individuals/features/basic_info/presentation/cubit/basic_info_cubit.dart';
import 'package:graduation_project/features/individuals/features/basic_info/presentation/widgets/custom_text_field.dart';

class BasicInfoPage extends StatelessWidget {
  const BasicInfoPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF1E293B)),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: const Text(
          'Basic Information',
          style: TextStyle(
            color: Color(0xFF1E293B),
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
      ),
      body: BlocListener<BasicInfoCubit, BasicInfoState>(
        listener: (context, state) {
          if (state.status == FormStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Profile Saved Successfully!'),
                backgroundColor: Colors.green,
              ),
            );
          } else if (state.status == FormStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed to save profile'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: CustomTextField(
                      label: 'First Name',
                      hint: 'John',
                      onChanged: (val) =>
                          context.read<BasicInfoCubit>().firstNameChanged(val),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomTextField(
                      label: 'Last Name',
                      hint: 'Doe',
                      onChanged: (val) =>
                          context.read<BasicInfoCubit>().lastNameChanged(val),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Job Title',
                hint: 'e.g. Software Engineer',
                onChanged: (val) =>
                    context.read<BasicInfoCubit>().jobTitleChanged(val),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Phone Number',
                hint: '(123) 456-7890',
                keyboardType: TextInputType.phone,
                onChanged: (val) =>
                    context.read<BasicInfoCubit>().phoneChanged(val),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Email',
                hint: 'john.doe@email.com',
                keyboardType: TextInputType.emailAddress,
                onChanged: (val) =>
                    context.read<BasicInfoCubit>().emailChanged(val),
              ),
              const SizedBox(height: 24),

              CustomTextField(
                label: 'Location',
                hint: 'e.g. San Francisco, CA',
                onChanged: (val) =>
                    context.read<BasicInfoCubit>().locationChanged(val),
              ),

              const SizedBox(height: 48),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(24.0),
        child: BlocBuilder<BasicInfoCubit, BasicInfoState>(
          builder: (context, state) {
            return SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: state.status == FormStatus.loading
                    ? null
                    : () => context.read<BasicInfoCubit>().saveForm(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF3B82F6),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  elevation: 0,
                ),
                child: state.status == FormStatus.loading
                    ? const SizedBox(
                        height: 24,
                        width: 24,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      )
                    : const Text(
                        'Save',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
              ),
            );
          },
        ),
      ),
    );
  }
}
