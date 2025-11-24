import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:graduation_project/features/company_portal/domain/entities/company_entity.dart';

part 'company_event.dart';
part 'company_state.dart';
part 'company_bloc.freezed.dart';

class CompanyBloc extends Bloc<CompanyEvent, CompanyState> {
  CompanyBloc() : super(_Initial()) {
    on<CompanyEvent>((event, emit) {
      // TODO: implement event handler
    });
  }
}
