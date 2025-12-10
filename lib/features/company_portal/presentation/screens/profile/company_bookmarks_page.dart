import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:toastification/toastification.dart';
import 'package:graduation_project/core/di/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import '../../../domain/entities/candidate_entity.dart';

class CompanyBookmarksPage extends StatefulWidget {
  const CompanyBookmarksPage({super.key});

  @override
  State<CompanyBookmarksPage> createState() => _CompanyBookmarksPageState();
}

class _CompanyBookmarksPageState extends State<CompanyBookmarksPage> {
  @override
  void initState() {
    super.initState();
    _fetchBookmarks();
  }

  void _fetchBookmarks() {
    final userId = serviceLocator.get<SupabaseClient>().auth.currentUser?.id;
    if (userId != null) {
      context.read<CompanyBloc>().add(GetCompanyBookmarksEvent(userId));
    }
  }

  @override
  Widget build(BuildContext context) {
    // Theme Colors
    final primaryColor = Theme.of(context).primaryColor;
    const backgroundColor = Color(0xFFF8F9FD);

    return Scaffold(
      backgroundColor: backgroundColor,
      body: BlocConsumer<CompanyBloc, CompanyState>(
        listener: (context, state) {
          if (state is BookmarkRemovedSuccessfully) {
            // ✅ Modern Success Toast
            toastification.show(
              context: context,
              type: ToastificationType.success,
              style: ToastificationStyle.flatColored,
              title: const Text('Candidate Removed'),
              autoCloseDuration: const Duration(seconds: 3),
              alignment: Alignment.bottomCenter,
            );
            _fetchBookmarks(); // Refresh the list
          }
          if (state is CompanyError) {
            // ✅ Modern Error Toast
            toastification.show(
              context: context,
              type: ToastificationType.error,
              style: ToastificationStyle.flatColored,
              title: const Text('Error'),
              description: Text(state.message),
              autoCloseDuration: const Duration(seconds: 4),
              alignment:
                  Alignment.topCenter, // Added alignment for better visibility
            );
          }
        },
        builder: (context, state) {
          return CustomScrollView(
            slivers: [
              // 1. Modern Collapsing Header
              SliverAppBar.medium(
                backgroundColor: backgroundColor,
                surfaceTintColor: Colors.transparent,
                title: const Text(
                  'Saved Candidates',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.w800,
                  ),
                ),
                leading: IconButton(
                  icon: const Icon(Icons.arrow_back_ios_new, size: 20),
                  onPressed: () => context.pop(),
                ),
                actions: [
                  IconButton(
                    onPressed: _fetchBookmarks,
                    icon: const Icon(Icons.refresh_rounded),
                    tooltip: 'Refresh',
                  ),
                ],
              ),

              // 2. Content based on BLoC State
              if (state is CompanyLoading)
                const SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (state is CompanyBookmarksLoaded)
                if (state.bookmarks.isEmpty)
                  SliverFillRemaining(child: _buildEmptyState(primaryColor))
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate((context, index) {
                        final candidate = state.bookmarks[index];
                        return _buildDismissibleCard(
                          context,
                          candidate,
                          primaryColor,
                        );
                      }, childCount: state.bookmarks.length),
                    ),
                  )
              else
                // Fallback for initial state or unhandled error state
                SliverFillRemaining(child: _buildEmptyState(primaryColor)),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDismissibleCard(
    BuildContext context,
    CandidateEntity candidate,
    Color primaryColor,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Dismissible(
        key: Key(candidate.id),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 24),
          decoration: BoxDecoration(
            color: Colors.redAccent.withOpacity(0.9),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.delete_outline_rounded, color: Colors.white, size: 28),
              SizedBox(height: 4),
              Text(
                "Remove",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
        ),
        // Use a dialog to confirm before dismissing, preventing accidental deletion
        confirmDismiss: (direction) async {
          _showRemoveDialog(context, candidate);
          return false; // Let the dialog handle the actual removal logic
        },
        child: _buildBookmarkCard(context, candidate, primaryColor),
      ),
    );
  }

  Widget _buildBookmarkCard(
    BuildContext context,
    CandidateEntity c,
    Color primaryColor,
  ) {
    // Helper to safely parse skills from a string/list representation
    final rawSkills = c.skills?.toString() ?? '';
    final skillsList = rawSkills
        .replaceAll(RegExp(r'[\[\]"]'), '')
        .split(',')
        .where((s) => s.trim().isNotEmpty)
        .take(2)
        .toList();

    final bool hasAvatar = c.avatarUrl != null && c.avatarUrl!.isNotEmpty;

    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {
            // Placeholder: Navigate to candidate details
            // context.pushNamed('candidate-details', extra: c);
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Avatar
                Container(
                  width: 60,
                  height: 60,
                  decoration: BoxDecoration(
                    color: primaryColor.withOpacity(0.08),
                    shape: BoxShape.circle,
                    image: hasAvatar
                        ? DecorationImage(
                            image: NetworkImage(c.avatarUrl!),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child: !hasAvatar
                      ? Center(
                          child: Text(
                            _getInitials(c.fullName),
                            style: TextStyle(
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                              color: primaryColor,
                            ),
                          ),
                        )
                      : null,
                ),
                const SizedBox(width: 16),

                // Info
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        c.fullName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.black87,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        c.jobTitle ?? c.city ?? 'Available for work',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: Colors.grey[600],
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 10),
                      if (skillsList.isNotEmpty)
                        Wrap(
                          spacing: 6,
                          children: skillsList.map((skill) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: const Color(0xFFF5F7FA),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                skill.trim(),
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.grey[700],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                    ],
                  ),
                ),

                // Remove Button (IconButton)
                IconButton(
                  onPressed: () => _showRemoveDialog(context, c),
                  icon: Icon(
                    Icons.bookmark_remove_outlined,
                    color: Colors.redAccent.withOpacity(0.8),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState(Color primaryColor) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(30),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Icon(
              Icons.bookmark_border_rounded,
              size: 60,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No saved candidates',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Start searching to bookmark top talent.',
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
          const SizedBox(height: 32),
          OutlinedButton.icon(
            onPressed: () => context.pop(), // Go back to search
            icon: const Icon(Icons.search),
            label: const Text("Find Candidates"),
            style: OutlinedButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _getInitials(String name) {
    if (name.isEmpty) return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name[0].toUpperCase();
  }

  void _showRemoveDialog(BuildContext context, CandidateEntity c) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (_) {
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(height: 24),
                const Text(
                  "Remove Candidate?",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 12),
                Text(
                  "Are you sure you want to remove ${c.fullName} from your saved list?",
                  textAlign: TextAlign.center,
                  style: TextStyle(color: Colors.grey[600], height: 1.5),
                ),
                const SizedBox(height: 32),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          side: BorderSide(color: Colors.grey.shade300),
                        ),
                        child: const Text(
                          'Cancel',
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          // Dispatch the removal event
                          context.read<CompanyBloc>().add(
                            RemoveCandidateBookmarkEvent(c.id),
                          );
                          Navigator.pop(context); // Close the bottom sheet
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.redAccent,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          padding: const EdgeInsets.symmetric(vertical: 16),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                        ),
                        child: const Text('Remove'),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
