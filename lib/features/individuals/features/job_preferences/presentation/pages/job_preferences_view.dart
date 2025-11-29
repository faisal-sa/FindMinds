import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import '../../domain/entities/job_preferences_entity.dart';
import '../cubit/job_preferences_cubit.dart';

class JobPreferencesView extends StatefulWidget {
  const JobPreferencesView({super.key});

  @override
  State<JobPreferencesView> createState() => _JobPreferencesViewState();
}

class _JobPreferencesViewState extends State<JobPreferencesView> {
  final _formKey = GlobalKey<FormState>();

  // Form Controllers
  final TextEditingController _roleController = TextEditingController();
  final TextEditingController _minSalaryController = TextEditingController();
  final TextEditingController _maxSalaryController = TextEditingController();
  final TextEditingController _noticePeriodController = TextEditingController();

  // Local State
  List<String> _targetRoles = [];
  List<String> _employmentTypes = [];
  List<String> _workModes = [];

  // Hardcoded to SAR as requested
  final String _salaryCurrency = 'SAR';

  bool _canRelocate = false;
  bool _canStartImmediately = false; // "On" in screenshot

  // Constants
  final List<String> _availableWorkModes = ['Remote', 'On-site', 'Hybrid'];
  final List<String> _availableEmpTypes = [
    'Full-time',
    'Part-time',
    'Contract',
    'Freelance',
    'Co-op',
  ];

  @override
  void dispose() {
    _roleController.dispose();
    _minSalaryController.dispose();
    _maxSalaryController.dispose();
    _noticePeriodController.dispose();
    super.dispose();
  }

  void _initializeValues(JobPreferencesEntity prefs) {
    _targetRoles = List.from(prefs.targetRoles);
    _employmentTypes = List.from(prefs.employmentTypes);
    _workModes = List.from(prefs.workModes);
    _minSalaryController.text = prefs.minSalary?.toString() ?? '';
    _maxSalaryController.text = prefs.maxSalary?.toString() ?? '';
    _canRelocate = prefs.canRelocate;
    _canStartImmediately = prefs.canStartImmediately;
    _noticePeriodController.text = prefs.noticePeriodDays?.toString() ?? '';
  }

  void _onSave() {
    if (_formKey.currentState!.validate()) {
      final entity = JobPreferencesEntity(
        targetRoles: _targetRoles,
        minSalary: int.tryParse(_minSalaryController.text),
        maxSalary: int.tryParse(_maxSalaryController.text),
        salaryCurrency: _salaryCurrency,
        employmentTypes: _employmentTypes,
        workModes: _workModes,
        canRelocate: _canRelocate,
        canStartImmediately: _canStartImmediately,
        // Only save notice period if the toggle is ON (since it's hidden otherwise)
        noticePeriodDays: _canStartImmediately
            ? int.tryParse(_noticePeriodController.text)
            : null,
      );

      context.read<JobPreferencesCubit>().savePreferences(entity);
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobPreferencesCubit, JobPreferencesState>(
      listener: (context, state) {
        if (state is JobPreferencesSaved) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Preferences saved successfully!'),
              backgroundColor: Colors.green,
            ),
          );
        } else if (state is JobPreferencesLoaded) {
          setState(() {
            _initializeValues(state.preferences);
          });
        }
      },
      builder: (context, state) {
        if (state is JobPreferencesLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Target Role'),
                _buildRoleInput(),

                // Chips for added roles
                if (_targetRoles.isNotEmpty) ...[
                  const Gap(8),
                  Wrap(
                    spacing: 8,
                    children: _targetRoles.map((role) {
                      return Chip(
                        label: Text(role),
                        backgroundColor: Colors.blue.shade50,
                        deleteIcon: const Icon(Icons.close, size: 18),
                        onDeleted: () =>
                            setState(() => _targetRoles.remove(role)),
                      );
                    }).toList(),
                  ),
                ],

                const Gap(24),
                _buildLabel('Salary Expectations'),
                _buildSalaryRow(),

                const Gap(24),
                _buildLabel('Work Environment'),
                _buildSelectionChips(
                  options: _availableWorkModes,
                  selectedValues: _workModes,
                  onSelect: (val) {
                    setState(() {
                      if (_workModes.contains(val)) {
                        _workModes.remove(val);
                      } else {
                        _workModes.add(val);
                      }
                    });
                  },
                ),

                const Gap(24),
                _buildLabel('Employment Type'),
                _buildSelectionChips(
                  options: _availableEmpTypes,
                  selectedValues: _employmentTypes,
                  onSelect: (val) {
                    setState(() {
                      if (_employmentTypes.contains(val)) {
                        _employmentTypes.remove(val);
                      } else {
                        _employmentTypes.add(val);
                      }
                    });
                  },
                ),

                const Gap(24),
                // Custom Switch Tile for Relocation
                _buildSwitchTile(
                  title: 'Open to relocation',
                  value: _canRelocate,
                  onChanged: (val) => setState(() => _canRelocate = val),
                ),

                const Gap(16),
                // Custom Switch Tile for Start Immediately
                _buildSwitchTile(
                  title: 'Can start immediately',
                  value: _canStartImmediately,
                  onChanged: (val) =>
                      setState(() => _canStartImmediately = val),
                ),

                // Logic: Hidden if Can Start Immediately is OFF
                if (_canStartImmediately) ...[
                  const Gap(24),
                  _buildLabel('Notice Period'),
                  TextFormField(
                    controller: _noticePeriodController,
                    decoration: _inputDecoration(hint: 'e.g., 2 weeks'),
                  ),
                ],

                const Gap(40),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: _onSave,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(
                        0xFF4285F4,
                      ), // Google Blue style from screenshot
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      elevation: 0,
                    ),
                    child: const Text(
                      'Save Preferences',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const Gap(24),
              ],
            ),
          ),
        );
      },
    );
  }

  // --- Helper Widgets ---

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Color(0xFF5F6368), // Dark grey
        ),
      ),
    );
  }

  Widget _buildRoleInput() {
    return TextField(
      controller: _roleController,
      decoration: _inputDecoration(hint: 'e.g., Software Engineer'),
      onSubmitted: (_) => _addRole(),
      textInputAction: TextInputAction.done,
    );
  }

  void _addRole() {
    final text = _roleController.text.trim();
    if (text.isNotEmpty && !_targetRoles.contains(text)) {
      setState(() {
        _targetRoles.add(text);
        _roleController.clear();
      });
    }
  }

  Widget _buildSalaryRow() {
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Minimum Salary",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Gap(4),
              TextFormField(
                controller: _minSalaryController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  hint: 'e.g., 5,000',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '\$',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  suffixText: '/mo', // Per month request
                ),
              ),
            ],
          ),
        ),
        const Gap(16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                "Maximum Salary",
                style: TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const Gap(4),
              TextFormField(
                controller: _maxSalaryController,
                keyboardType: TextInputType.number,
                decoration: _inputDecoration(
                  hint: 'e.g., 8,000',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(14.0),
                    child: Text(
                      '\$',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                  ),
                  suffixText: '/mo', // Per month request
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSelectionChips({
    required List<String> options,
    required List<String> selectedValues,
    required Function(String) onSelect,
  }) {
    return Wrap(
      spacing: 12,
      runSpacing: 12,
      children: options.map((option) {
        final isSelected = selectedValues.contains(option);
        return InkWell(
          onTap: () => onSelect(option),
          borderRadius: BorderRadius.circular(20),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              border: Border.all(
                color: isSelected
                    ? const Color(0xFF4285F4)
                    : Colors.grey.shade300,
                width: isSelected ? 1.5 : 1,
              ),
            ),
            child: Text(
              option,
              style: TextStyle(
                color: isSelected
                    ? const Color(0xFF4285F4)
                    : Colors.grey.shade700,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  Widget _buildSwitchTile({
    required String title,
    required bool value,
    required Function(bool) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        // Simulating the card look from the screenshot
        border: Border.all(color: Colors.white),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              color: Color(0xFF3C4043),
              fontWeight: FontWeight.w500,
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: Colors.white,
            activeTrackColor: const Color(0xFF4285F4),
            inactiveThumbColor: Colors.white,
            inactiveTrackColor: Colors.grey.shade300,
          ),
        ],
      ),
    );
  }

  InputDecoration _inputDecoration({
    String? hint,
    Widget? prefixIcon,
    String? suffixText,
  }) {
    return InputDecoration(
      hintText: hint,
      hintStyle: TextStyle(color: Colors.grey.shade400),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      prefixIcon: prefixIcon,
      suffixText: suffixText,
      suffixStyle: const TextStyle(color: Colors.grey),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(color: Colors.grey.shade300),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: const BorderSide(color: Color(0xFF4285F4), width: 1.5),
      ),
      filled: true,
      fillColor: Colors.white,
    );
  }
}
