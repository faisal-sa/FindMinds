import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation_project/features/company_portal/presentation/blocs/bloc/company_bloc.dart';

class CompanySearchPage extends StatelessWidget {
  const CompanySearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    final city = TextEditingController();
    final skill = TextEditingController();
    final exp = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text('Search Candidates')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            TextField(
              controller: city,
              decoration: const InputDecoration(labelText: 'City'),
            ),
            TextField(
              controller: skill,
              decoration: const InputDecoration(labelText: 'Skill'),
            ),
            TextField(
              controller: exp,
              decoration: const InputDecoration(labelText: 'Experience'),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed: () {
                context.read<CompanyBloc>().add(
                  SearchCandidatesEvent(
                    city: city.text,
                    skill: skill.text,
                    experience: exp.text,
                  ),
                );
              },
              child: const Text('Search'),
            ),
            const SizedBox(height: 16),
            Expanded(
              child: BlocBuilder<CompanyBloc, CompanyState>(
                builder: (context, state) {
                  if (state is CompanyLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is CandidateResults) {
                    if (state.candidates.isEmpty) {
                      return const Center(child: Text('No candidates found'));
                    }
                    return ListView.builder(
                      itemCount: state.candidates.length,
                      itemBuilder: (_, i) {
                        final c = state.candidates[i];
                        return ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(c['full_name'] ?? ''),
                          subtitle: Text('Skills: ${c['skills'] ?? ''}'),
                        );
                      },
                    );
                  }
                  return const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
