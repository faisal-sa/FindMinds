import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class CompanySearchPage extends StatefulWidget {
  const CompanySearchPage({super.key});

  @override
  State<CompanySearchPage> createState() => _CompanySearchPageState();
}

class _CompanySearchPageState extends State<CompanySearchPage> {
  final _cityController = TextEditingController();
  final _skillController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  // State Variables
  List<String> selectedTypes = [];
  bool canRelocateValue = false;
  List<String> selectedLanguages = [];
  List<String> selectedModes = [];
  String? selectedJobTitle;
  List<String> targetRolesList = [];

  // Data Sources
  final List<String> availableLanguages = [
    'Arabic',
    'English',
    'French',
    'Spanish',
  ];
  final List<String> availableWorkModes = ['Remote', 'Hybrid', 'On-Site'];
  final List<String> availableTargetRoles = [
    'Team Lead',
    'Senior',
    'Junior',
    'Intern',
  ];

  void _performSearch(BuildContext context) {
    if (_formKey.currentState!.validate()) {
      final city = _cityController.text.trim();
      final skill = _skillController.text.trim();

      context.read<CompanyBloc>().add(
        SearchCandidatesEvent(
          location: city.isNotEmpty ? city : null,
          skills: skill.isNotEmpty ? [skill] : null,
          employmentTypes: selectedTypes.isNotEmpty ? selectedTypes : null,
          canRelocate: canRelocateValue ? true : null,
          languages: selectedLanguages.isNotEmpty ? selectedLanguages : null,
          workModes: selectedModes.isNotEmpty ? selectedModes : null,
          jobTitle: (selectedJobTitle != null && selectedJobTitle!.isNotEmpty)
              ? selectedJobTitle
              : null,
          targetRoles: targetRolesList.isNotEmpty ? targetRolesList : null,
        ),
      );

      context.pushNamed(
        'company-search-results',
        extra: context.read<CompanyBloc>(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final primaryColor = Theme.of(context).primaryColor;
    const backgroundColor = Color(0xFFF8F9FD);

    return Scaffold(
      backgroundColor: backgroundColor,
      // 1. Sticky Action Button
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 20,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: SafeArea(
          child: ElevatedButton(
            onPressed: () => _performSearch(context),
            style: ElevatedButton.styleFrom(
              backgroundColor: primaryColor,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              shadowColor: primaryColor.withOpacity(0.5),
            ),
            child: const Text(
              'Search Candidates',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ),
        ),
      ),
      body: CustomScrollView(
        slivers: [
          // 2. Modern App Bar
          SliverAppBar.medium(
            backgroundColor: backgroundColor,
            surfaceTintColor: Colors.transparent,
            title: const Text(
              'Find Talent',
              style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w800,
              ),
            ),
            actions: [
              IconButton(
                icon: const Icon(
                  Icons.bookmark_border_rounded,
                  color: Colors.black87,
                ),
                onPressed: () => context.goNamed('company-bookmarks'),
              ),
              IconButton(
                icon: const Icon(
                  Icons.settings_outlined,
                  color: Colors.black87,
                ),
                onPressed: () => context.goNamed('company-settings'),
              ),
              const SizedBox(width: 8),
            ],
          ),

          // 3. Main Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildSectionHeader('Core Criteria'),

                    // --- Card 1: Search Inputs ---
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        children: [
                          _ModernSearchField(
                            controller: _skillController,
                            label: 'Skills / Keywords',
                            hint: 'e.g. Flutter, Python',
                            icon: Icons.search_rounded,
                          ),
                          const SizedBox(height: 16),
                          _ModernSearchField(
                            controller: _cityController,
                            label: 'Location',
                            hint: 'e.g. Riyadh',
                            icon: Icons.location_on_outlined,
                          ),
                          const SizedBox(height: 16),
                          _ModernDropdown(
                            value: selectedJobTitle,
                            label: 'Job Title',
                            items: const [
                              'Mobile Developer',
                              'Backend Developer',
                              'Frontend Developer',
                              'UI/UX Designer',
                              'Data Scientist',
                            ],
                            onChanged: (v) =>
                                setState(() => selectedJobTitle = v),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // --- Card 2: Relocation Toggle ---
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SwitchListTile(
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 4,
                        ),
                        activeColor: primaryColor,
                        trackOutlineColor: WidgetStateProperty.all(
                          Colors.transparent,
                        ),
                        title: const Text(
                          "Willing to relocate?",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                          ),
                        ),
                        subtitle: const Text(
                          "Show candidates ready to move",
                          style: TextStyle(fontSize: 13, color: Colors.grey),
                        ),
                        value: canRelocateValue,
                        onChanged: (v) => setState(() => canRelocateValue = v),
                      ),
                    ),

                    const SizedBox(height: 24),
                    _buildSectionHeader('Preferences'),

                    // --- Card 3: Filters ---
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.02),
                            blurRadius: 10,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _buildFilterGroup(
                            title: "Work Mode",
                            options: availableWorkModes,
                            selectedList: selectedModes,
                            primaryColor: primaryColor,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(height: 1, color: Color(0xFFF0F0F0)),
                          ),
                          _buildFilterGroup(
                            title: "Target Roles",
                            options: availableTargetRoles,
                            selectedList: targetRolesList,
                            primaryColor: primaryColor,
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 20),
                            child: Divider(height: 1, color: Color(0xFFF0F0F0)),
                          ),
                          _buildFilterGroup(
                            title: "Languages",
                            options: availableLanguages,
                            selectedList: selectedLanguages,
                            primaryColor: primaryColor,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(left: 8, bottom: 10),
      child: Text(
        title.toUpperCase(),
        style: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
          letterSpacing: 1.2,
          color: Colors.grey[600],
        ),
      ),
    );
  }

  Widget _buildFilterGroup({
    required String title,
    required List<String> options,
    required List<String> selectedList,
    required Color primaryColor,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 15,
            color: Colors.black87,
          ),
        ),
        const SizedBox(height: 12),
        Wrap(
          spacing: 8.0,
          runSpacing: 10.0,
          children: options.map((option) {
            final isSelected = selectedList.contains(option);
            return GestureDetector(
              onTap: () {
                setState(() {
                  if (isSelected) {
                    selectedList.remove(option);
                  } else {
                    selectedList.add(option);
                  }
                });
              },
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: isSelected ? primaryColor : const Color(0xFFF5F7FA),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: isSelected ? primaryColor : Colors.transparent,
                  ),
                ),
                child: Text(
                  option,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[700],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 13,
                  ),
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}

// -----------------------------------------------------------------------------

class _ModernSearchField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final String hint;
  final IconData icon;

  const _ModernSearchField({
    required this.controller,
    required this.label,
    required this.hint,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA), // Light grey fill inside the white card
        borderRadius: BorderRadius.circular(12),
      ),
      child: TextFormField(
        controller: controller,
        style: const TextStyle(fontWeight: FontWeight.w500),
        decoration: InputDecoration(
          labelText: label,
          hintText: hint,
          prefixIcon: Icon(icon, color: Colors.grey[500], size: 22),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),
          hintStyle: TextStyle(color: Colors.grey[400]),
        ),
      ),
    );
  }
}

class _ModernDropdown extends StatelessWidget {
  final String? value;
  final String label;
  final List<String> items;
  final ValueChanged<String?> onChanged;

  const _ModernDropdown({
    super.key,
    required this.value,
    required this.label,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF8F9FA),
        borderRadius: BorderRadius.circular(12),
      ),
      child: DropdownButtonFormField<String>(
        value: value,
        isExpanded: true,
        dropdownColor: Colors.white,
        borderRadius: BorderRadius.circular(16),

        // ✅ 1. Hide the default, un-clickable arrow
        icon: const SizedBox.shrink(),

        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(
            Icons.work_outline_rounded,
            color: Colors.grey[500],
            size: 22,
          ),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 14,
          ),
          labelStyle: TextStyle(color: Colors.grey[600]),

          suffixIcon: value == null
              ? const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: Colors.grey,
                )
              : IconButton(
                  icon: const Icon(
                    Icons.clear_rounded,
                    color: Colors.grey,
                    size: 20,
                  ),
                  onPressed: () {
                    onChanged(null);
                  },
                ),
        ),
        items: items
            .map(
              (s) => DropdownMenuItem(
                value: s,
                child: Text(s, overflow: TextOverflow.ellipsis),
              ),
            )
            .toList(),
        onChanged: onChanged,
      ),
    );
  }
}
