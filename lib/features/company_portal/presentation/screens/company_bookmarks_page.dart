import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class CompanyBookmarksPage extends StatelessWidget {
  const CompanyBookmarksPage({super.key});

  @override
  Widget build(BuildContext context) {
    final supabase = Supabase.instance.client;
    final user = supabase.auth.currentUser;

    if (user != null) {
      Future.microtask(
        () =>
            context.read<CompanyBloc>().add(GetCompanyBookmarksEvent(user.id)),
      );
    }

    return Scaffold(
      appBar: AppBar(title: const Text('Bookmarked Candidates')),
      body: BlocBuilder<CompanyBloc, CompanyState>(
        builder: (context, state) {
          if (state is CompanyLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is CompanyBookmarksLoaded) {
            if (state.bookmarks.isEmpty) {
              return const Center(child: Text('No bookmarks yet'));
            }
            return ListView.separated(
              itemCount: state.bookmarks.length,
              separatorBuilder: (_, __) => const Divider(),
              itemBuilder: (_, i) {
                final candidate = state.bookmarks[i]['profiles'];
                return ListTile(
                  leading: const Icon(Icons.person),
                  title: Text(candidate['full_name'] ?? ''),
                  subtitle: Text(
                    'Skills: ${candidate['skills'] ?? ''}\nCity: ${candidate['city'] ?? ''}',
                  ),
                );
              },
            );
          } else if (state is CompanyError) {
            return Center(child: Text(state.message));
          }
          return const SizedBox();
        },
      ),
    );
  }
}
