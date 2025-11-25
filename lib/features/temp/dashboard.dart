import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

class UserProfile extends Equatable {
  final String? name;

  const UserProfile({this.name});

  bool get isComplete => name != null && name!.isNotEmpty;

  int get progress => isComplete ? 35 : 5;

  @override
  List<Object?> get props => [name];
}

class UserCubit extends Cubit<UserProfile> {
  UserCubit() : super(const UserProfile(name: null));

  void uploadResume() {
    emit(const UserProfile(name: "Alex Johnson"));
  }

  void resetProfile() {
    emit(const UserProfile(name: null));
  }
}
