part of 'company_bloc.dart';

@immutable
abstract class CompanyEvent {}

class RegisterCompanyEvent extends CompanyEvent {
  final String email;
  final String password;
  RegisterCompanyEvent(this.email, this.password);
}

class GetCompanyProfileEvent extends CompanyEvent {
  final String userId;
  GetCompanyProfileEvent(this.userId);
}

class UpdateCompanyProfileEvent extends CompanyEvent {
  final CompanyEntity company;
  UpdateCompanyProfileEvent(this.company);
}

class SearchCandidatesEvent extends CompanyEvent {
  final String? city;
  final String? skill;
  final String? experience;
  SearchCandidatesEvent({this.city, this.skill, this.experience});
}

class AddCandidateBookmarkEvent extends CompanyEvent {
  final String candidateId;
  AddCandidateBookmarkEvent(this.candidateId);
}
