import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:graduation_project/features/company_bookmarks/presentation/blocs/bloc/bookmarks_bloc.dart';
import 'package:graduation_project/features/company_search/presentation/blocs/bloc/search_bloc.dart';
import 'package:toastification/toastification.dart';

import 'widgets/candidate_rich_card.dart';

class CandidateResultsPage extends StatelessWidget {
  const CandidateResultsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final primaryColor = Theme.of(context).primaryColor;
    const backgroundColor = Color(0xFFF8F9FD);

    return Scaffold(
      backgroundColor: backgroundColor,
      // 1. استخدام MultiBlocListener للاستماع للأحداث من كلا الـ Blocين
      body: MultiBlocListener(
        listeners: [
          // أ) الاستماع لنجاح عملية الحفظ/الإزالة (من BookmarksBloc)
          BlocListener<BookmarksBloc, BookmarksState>(
            listener: (context, state) {
              if (state is BookmarkOperationSuccess) {
                toastification.show(
                  context: context,
                  type: ToastificationType.success,
                  style: ToastificationStyle.flatColored,
                  title: Text(
                    state.message,
                  ), // "Removed successfully" or "Saved"
                  autoCloseDuration: const Duration(seconds: 3),
                  alignment: Alignment.bottomCenter,
                );
              }
            },
          ),
          // ب) الاستماع لأخطاء البحث (من SearchBloc)
          BlocListener<SearchBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchError) {
                toastification.show(
                  context: context,
                  type: ToastificationType.error,
                  style: ToastificationStyle.flatColored,
                  title: const Text('Search Failed'),
                  description: Text(state.message),
                  autoCloseDuration: const Duration(seconds: 4),
                  alignment: Alignment.topCenter,
                );
              }
            },
          ),
        ],
        // 2. بناء الواجهة بناءً على حالة البحث فقط (SearchBloc)
        child: BlocBuilder<SearchBloc, SearchState>(
          builder: (context, state) {
            // حالة التحميل
            if (state is SearchLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            // حالة عرض النتائج (الاسم الجديد)
            if (state is SearchResultsLoaded) {
              final candidates = state.candidates;

              return CustomScrollView(
                slivers: [
                  SliverAppBar.medium(
                    backgroundColor: backgroundColor,
                    surfaceTintColor: Colors.transparent,
                    title: const Text(
                      'Search Results',
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
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Text(
                            "${candidates.length} Found",
                            style: TextStyle(
                              color: Colors.grey[600],
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),

                  if (candidates.isEmpty)
                    SliverFillRemaining(child: _buildEmptyState())
                  else
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      sliver: SliverList(
                        delegate: SliverChildBuilderDelegate((context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 16.0),
                            child: CandidateRichCard(
                              candidate: candidates[index],
                              primaryColor: primaryColor,
                              // نعتمد هنا على أن الكيان يحتوي على خاصية bookmarked
                              // إذا لم تكن موجودة، يمكنك تمرير false مؤقتاً
                              isBookmarked: candidates[index].bookmarked,
                            ),
                          );
                        }, childCount: candidates.length),
                      ),
                    ),
                ],
              );
            }

            // الحالة الافتراضية
            return _buildEmptyState();
          },
        ),
      ),
    );
  }

  Widget _buildEmptyState() {
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
              Icons.search_off_rounded,
              size: 60,
              color: Colors.grey[300],
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'No candidates found',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or location.',
            style: TextStyle(color: Colors.grey[500], fontSize: 15),
          ),
        ],
      ),
    );
  }
}
