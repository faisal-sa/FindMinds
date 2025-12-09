import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/blocs/bloc/bookmarks_bloc.dart';
import 'package:graduation_project/features/shared/data/domain/entities/candidate_entity.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../../core/di/service_locator.dart';

class CandidateRichCard extends StatelessWidget {
  final CandidateEntity candidate;
  final Color primaryColor;
  final bool isBookmarked;

  const CandidateRichCard({
    super.key,
    required this.candidate,
    required this.primaryColor,
    required this.isBookmarked,
  });

  @override
  Widget build(BuildContext context) {
    final bool hasAvatar =
        candidate.avatarUrl != null && candidate.avatarUrl!.isNotEmpty;

    // معالجة المهارات
    final rawSkills = candidate.skills?.toString() ?? '';
    final skillsList = rawSkills
        // Regex لتنظيف السلسلة النصية
        .replaceAll(RegExp(r'[\[\]"]'), '')
        .split(',')
        .where((s) => s.trim().isNotEmpty)
        .map((s) => s.trim())
        .take(3)
        .toList();

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
            // الانتقال لصفحة التفاصيل
            context.pushNamed(
              'candidate-details',
              pathParameters: {'id': candidate.id},
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Avatar (الصورة الشخصية)
                    Container(
                      width: 56,
                      height: 56,
                      decoration: BoxDecoration(
                        color: primaryColor.withOpacity(0.08),
                        shape: BoxShape.circle,
                        image: hasAvatar
                            ? DecorationImage(
                                image: NetworkImage(candidate.avatarUrl!),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: !hasAvatar
                          ? Center(
                              child: Text(
                                _getInitials(candidate.fullName),
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                  color: primaryColor,
                                ),
                              ),
                            )
                          : null,
                    ),
                    const SizedBox(width: 16),

                    // Main Info (البيانات الرئيسية)
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            candidate.fullName.isNotEmpty
                                ? candidate.fullName
                                : 'Unnamed Candidate',
                            style: const TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w700,
                              color: Colors.black87,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            candidate.jobTitle ?? 'Open to work',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: primaryColor,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 6),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on_outlined,
                                size: 14,
                                color: Colors.grey[500],
                              ),
                              const SizedBox(width: 4),
                              Expanded(
                                child: Text(
                                  candidate.city ?? 'Remote / Flexible',
                                  style: TextStyle(
                                    color: Colors.grey[600],
                                    fontSize: 13,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // --- زر المفضلة (تم نقله إلى نهاية الـ Row) ---
                    IconButton(
                      onPressed: () => _toggleBookmark(context),
                      icon: Icon(
                        isBookmarked
                            ? Icons.bookmark_rounded
                            : Icons.bookmark_border_rounded,
                      ),
                      color: isBookmarked ? primaryColor : Colors.grey[400],
                      tooltip: isBookmarked
                          ? 'Remove from saved'
                          : 'Save Candidate',
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const Divider(height: 1, color: Color(0xFFF0F0F0)),
                const SizedBox(height: 12),

                // Skills Chips
                if (skillsList.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: skillsList.map((skill) {
                      return Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F7FA),
                          borderRadius: BorderRadius.circular(8),
                          border: Border.all(color: Colors.transparent),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w500,
                            color: Colors.grey[700],
                          ),
                        ),
                      );
                    }).toList(),
                  )
                else
                  Text(
                    "No specific skills listed",
                    style: TextStyle(
                      color: Colors.grey[400],
                      fontSize: 12,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// دالة التعامل مع ضغط زر المفضلة وإرسال حدث الـ BLoC المناسب.
  void _toggleBookmark(BuildContext context) {
    // استخدام SupabaseClient من Service Locator للحصول على معرف الشركة
    final companyId = serviceLocator.get<SupabaseClient>().auth.currentUser?.id;

    if (companyId == null) {
      // يمكنك عرض رسالة خطأ أو توجيه المستخدم لصفحة تسجيل الدخول
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please log in to save candidates.')),
      );
      return;
    }

    try {
      final bookmarksBloc = context.read<BookmarksBloc>();

      if (isBookmarked) {
        // إرسال حدث الحذف
        bookmarksBloc.add(
          RemoveBookmarkEvent(candidateId: candidate.id, companyId: companyId),
        );
      } else {
        // إرسال حدث الإضافة
        bookmarksBloc.add(
          AddBookmarkEvent(candidateId: candidate.id, companyId: companyId),
        );
      }
    } catch (e) {
      // التعامل مع حالة عدم توفر BookmarksBloc في الشجرة
      debugPrint('Error accessing BookmarksBloc: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Error saving candidate. Missing BLoC provider.'),
        ),
      );
    }
  }

  String _getInitials(String name) {
    if (name.isEmpty || name == 'Unnamed Candidate') return "?";
    List<String> parts = name.trim().split(" ");
    if (parts.length > 1 && parts[1].isNotEmpty) {
      return "${parts[0][0]}${parts[1][0]}".toUpperCase();
    }
    return name[0].toUpperCase();
  }
}
