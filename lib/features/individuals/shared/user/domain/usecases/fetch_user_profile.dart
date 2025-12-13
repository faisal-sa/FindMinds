import 'package:graduation_project/features/individuals/shared/user/domain/entities/user_entity.dart';
import 'package:graduation_project/features/individuals/shared/user/domain/repositories/user_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class FetchUserProfile {
  final UserRepository repository;
  FetchUserProfile(this.repository);
  Future<UserEntity> call(String userId) => repository.fetchRemoteProfile(userId);
}